/* ── Noxtua Insights · dashboard.js ─────────────────────────────────────── */

let ALL_DATA = [];
let CHANGELOG = [];
let TRENDING_IDS = new Set();
let IMPL14_IDS = new Set();
let MAX_MENTIONS = 1;
const FOURTEEN_DAYS_MS = 14 * 24 * 60 * 60 * 1000;

const ALL_CUSTOMER_GROUPS = [
  "Big Law Firm","Corporate Law Department","Distribution Department",
  "Government Institutions","Mixed","Prosecution/ Judges","Publisher","Small Law Firm"
];

const ALL_SQUADS = [
  "AI Squad","Drafting Squad","Platform Squad","Review Squad",
  "Workflow Squad","Design","Marketing","All"
];

async function init() {
  try {
    const [dataRes, changeRes] = await Promise.all([
      fetch("/api/data"), fetch("/api/changelog"),
    ]);
    ALL_DATA = await dataRes.json();
    CHANGELOG = await changeRes.json();
    if (ALL_DATA.error) { showToast(ALL_DATA.error, "err"); return; }
  } catch (e) { showToast("Failed to load data: " + e.message, "err"); return; }

  MAX_MENTIONS = Math.max(...ALL_DATA.map(d => d.mentions), 1);
  const cutoff = Date.now() - FOURTEEN_DAYS_MS;

  CHANGELOG.filter(c => c.type === "mentions_changed" && new Date(c.date).getTime() >= cutoff)
    .forEach(c => TRENDING_IDS.add(c.id));
  CHANGELOG.filter(c => c.type === "status_changed" && c.to && c.to.includes("Implemented") && new Date(c.date).getTime() >= cutoff)
    .forEach(c => IMPL14_IDS.add(c.id));

  updateHeaderMeta();
  updateStats();
  buildFilters();
  renderCards();

  document.querySelectorAll(".tab-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      document.querySelectorAll(".tab-btn").forEach(b => b.classList.remove("active"));
      document.querySelectorAll(".tab-content").forEach(t => t.classList.remove("active"));
      btn.classList.add("active");
      document.getElementById("tab-" + btn.dataset.tab).classList.add("active");
      if (btn.dataset.tab === "charts") renderCharts(ALL_DATA);
    });
  });

  document.querySelectorAll(".sort-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      document.querySelectorAll(".sort-btn").forEach(b => b.classList.remove("active"));
      btn.classList.add("active");
      sortMode = btn.dataset.sort;
      renderCards();
    });
  });

  document.getElementById("search").addEventListener("input", e => {
    filters.search = e.target.value.trim();
    renderCards();
  });

  document.querySelector(".sidebar").addEventListener("click", e => {
    const btn = e.target.closest(".filter-btn");
    if (!btn) return;
    const group = btn.dataset.group;
    const val = btn.dataset.filter;
    if (group === "show") {
      document.querySelectorAll('[data-group="show"]').forEach(b => b.classList.remove("active"));
      btn.classList.add("active");
      filters.show = val;
    } else {
      const siblings = document.querySelectorAll(`[data-group="${group}"]`);
      const wasActive = btn.classList.contains("active");
      siblings.forEach(b => b.classList.remove("active"));
      if (!wasActive) { btn.classList.add("active"); filters[group] = val; }
      else filters[group] = null;
    }
    renderCards();
  });
}

let sortMode = "mentions";
let filters = { show: "all", type: null, sentiment: null, sourceType: null, publisher: null, squad: null, feature: null, status: null, search: "" };

function updateHeaderMeta() {
  document.getElementById("header-count").textContent = ALL_DATA.length;
  const dates = ALL_DATA.map(d => d.lastModified).filter(Boolean).sort();
  document.getElementById("header-date").textContent = dates.at(-1) || "—";
}

function isRecent14(d) {
  if (!d.created) return false;
  return Date.now() - new Date(d.created).getTime() <= FOURTEEN_DAYS_MS;
}

function updateStats() {
  document.getElementById("stat-total").textContent = ALL_DATA.length;
  document.getElementById("stat-new").textContent = ALL_DATA.filter(d => d.isNew).length;
  document.getElementById("stat-recent").textContent = ALL_DATA.filter(isRecent14).length;
  document.getElementById("stat-trending").textContent = TRENDING_IDS.size;
  document.getElementById("stat-neg").textContent = ALL_DATA.filter(d => d.sentiment === "Negative").length;
  document.getElementById("stat-pos").textContent = ALL_DATA.filter(d => d.sentiment === "Positive").length;
  document.getElementById("stat-unclass").textContent = ALL_DATA.filter(d => d.unclassified).length;
  document.getElementById("stat-top").textContent = MAX_MENTIONS;
}

function applyFilters() {
  let d = [...ALL_DATA];
  if (filters.show === "new") d = d.filter(x => x.isNew);
  else if (filters.show === "recent14") d = d.filter(isRecent14);
  else if (filters.show === "trending14") d = d.filter(x => TRENDING_IDS.has(x.id));
  else if (filters.show === "implemented14") d = d.filter(x => IMPL14_IDS.has(x.id));
  else if (filters.show === "unclassified") d = d.filter(x => x.unclassified);
  if (filters.type) d = d.filter(x => x.type === filters.type);
  if (filters.sentiment) d = d.filter(x => x.sentiment === filters.sentiment);
  if (filters.sourceType) d = d.filter(x => (x.sourceTypes||[]).includes(filters.sourceType));
  if (filters.publisher) d = d.filter(x => x.publisher === filters.publisher);
  if (filters.squad) d = d.filter(x => (x.squads||[]).includes(filters.squad));
  if (filters.feature) d = d.filter(x => (x.features||[]).includes(filters.feature));
  if (filters.status) d = d.filter(x => x.status === filters.status);
  if (filters.search) {
    const q = filters.search.toLowerCase();
    d = d.filter(x => (x.insight||"").toLowerCase().includes(q) || (x.quotes||"").toLowerCase().includes(q) || (x.source||"").toLowerCase().includes(q) || String(x.id).includes(q));
  }
  return d;
}

function applySort(d) {
  return [...d].sort((a, b) => {
    if (sortMode === "mentions") return b.mentions - a.mentions;
    if (sortMode === "new_first") { if (a.isNew !== b.isNew) return a.isNew ? -1 : 1; return b.mentions - a.mentions; }
    if (sortMode === "modified_desc") return ((b.lastModified||"0") > (a.lastModified||"0") ? 1 : -1);
    if (sortMode === "modified_asc") return ((a.lastModified||"9") > (b.lastModified||"9") ? 1 : -1);
    if (sortMode === "id") return a.id - b.id;
    return 0;
  });
}

function buildFilters() {
  const cnt = pred => ALL_DATA.filter(pred).length;
  document.getElementById("cnt-all").textContent = ALL_DATA.length;
  document.getElementById("cnt-new-f").textContent = ALL_DATA.filter(d => d.isNew).length;
  document.getElementById("cnt-recent14").textContent = ALL_DATA.filter(isRecent14).length;
  document.getElementById("cnt-trending14").textContent = TRENDING_IDS.size;
  document.getElementById("cnt-impl14").textContent = IMPL14_IDS.size;
  document.getElementById("cnt-unclass-f").textContent = ALL_DATA.filter(d => d.unclassified).length;

  buildGroup("filter-type", "type", [...new Set(ALL_DATA.map(d=>d.type).filter(Boolean))].sort(), v => cnt(d=>d.type===v));
  buildGroup("filter-sentiment", "sentiment", ["Negative","Mixed","Positive"], v => cnt(d=>d.sentiment===v));
  buildGroup("filter-source-type", "sourceType", [...new Set(ALL_DATA.flatMap(d=>d.sourceTypes||[]))].sort(), v => cnt(d=>(d.sourceTypes||[]).includes(v)));
  buildGroup("filter-publisher", "publisher", [...new Set(ALL_DATA.map(d=>d.publisher).filter(Boolean))].sort(), v => cnt(d=>d.publisher===v));
  buildGroup("filter-squad", "squad", [...new Set(ALL_DATA.flatMap(d=>d.squads||[]))].sort(), v => cnt(d=>(d.squads||[]).includes(v)));
  buildGroup("filter-feature", "feature", [...new Set(ALL_DATA.flatMap(d=>d.features||[]))].sort(), v => cnt(d=>(d.features||[]).includes(v)));
  buildGroup("filter-status", "status", [...new Set(ALL_DATA.map(d=>d.status).filter(Boolean))].sort(), v => cnt(d=>d.status===v));
}

function buildGroup(containerId, group, values, countFn) {
  document.getElementById(containerId).innerHTML = values.map(v => `
    <button class="filter-btn" data-filter="${esc(v)}" data-group="${group}">
      <span>${esc(v)}</span><span class="count">${countFn(v)}</span>
    </button>`).join("");
}

function renderCards() {
  const filtered = applySort(applyFilters());
  const list = document.getElementById("insights-list");
  document.getElementById("result-count").textContent = `${filtered.length} of ${ALL_DATA.length}`;
  if (!filtered.length) {
    list.innerHTML = `<div class="empty-state"><div class="icon">◈</div><p>No insights match the current filters.</p></div>`;
    return;
  }
  list.innerHTML = filtered.map(d => cardHTML(d)).join("");
}

function cardHTML(d) {
  const barPct = Math.round((d.mentions / MAX_MENTIONS) * 100);
  const isTrending = TRENDING_IDS.has(d.id);
  const squadPills = (d.squads||[]).length ? d.squads.map(s=>`<span class="pill pill-squad">${esc(s)}</span>`).join("") : `<span class="pill pill-unclass">squad unclassified</span>`;
  const featPills = (d.features||[]).length ? d.features.map(f=>`<span class="pill pill-feature">${esc(f)}</span>`).join("") : `<span class="pill pill-unclass">feature unclassified</span>`;
  const newBadge = d.isNew ? `<span class="pill pill-new">● NEW</span>` : "";
  const trendBadge = isTrending ? `<span class="pill pill-trending">↑ TRENDING</span>` : "";

  // Status editor
  const statusOpts = (STATUS_OPTIONS||[]).map(o=>`<option value="${esc(o)}" ${o===d.status?"selected":""}>${esc(o)}</option>`).join("");

  // Squad tag editor — current squads as removable tags + add dropdown
  const currentSquads = d.squads || [];
  const squadTagsHTML = currentSquads.map((s,i) =>
    `<span class="squad-tag">${esc(s)}<button class="squad-tag-remove" onclick="removeSquad(${d.id},${i})" title="Remove">×</button></span>`
  ).join("");
  const availableSquads = ALL_SQUADS.filter(s => !currentSquads.includes(s));
  const squadAddOptions = availableSquads.map(s=>`<option value="${esc(s)}">${esc(s)}</option>`).join("");

  // Customer group tag editor
  const currentUGs = parseUGList(d.userGroup);
  const ugTagsHTML = currentUGs.map((g,i) =>
    `<span class="squad-tag">${esc(g)}<button class="squad-tag-remove" onclick="removeUG(${d.id},${i})" title="Remove">×</button></span>`
  ).join("");
  const availableUGs = ALL_CUSTOMER_GROUPS.filter(g => !currentUGs.includes(g));
  const ugAddOptions = availableUGs.map(g=>`<option value="${esc(g)}">${esc(g)}</option>`).join("");

  const quoteHTML = d.quotes && d.quotes !== "nan"
    ? `<div class="detail-section"><div class="detail-label">Direct Quote</div><div class="detail-quote">${esc(d.quotes)}</div></div>` : "";

  const jiraHTML = d.jira && d.jira !== "nan" && d.jira.trim()
    ? `<div class="detail-section"><div class="detail-label">JIRA</div><a class="jira-link" href="https://xainag.atlassian.net/browse/${esc(d.jira)}" target="_blank">${esc(d.jira)} ↗</a></div>` : "";

  const sourceHTML = `<div class="detail-section"><div class="detail-label">Sources</div><div class="detail-value" style="color:var(--muted2);font-size:10px;word-break:break-all;line-height:1.7">${esc(d.source)}</div></div>`;
  const metaHTML = `<div class="detail-section"><div class="detail-label">Created</div><div class="detail-value" style="color:var(--muted2)">${esc(d.created||"—")}</div></div><div class="detail-section" style="margin-top:4px"><div class="detail-label">Last Modified</div><div class="detail-value" style="color:var(--muted2)">${esc(d.lastModified||"—")}</div></div>`;

  const unclassHTML = d.unclassified ? `<div class="unclass-flag">⚠ Needs squad / feature classification</div>` : "";

  const classes = ["insight-card", d.isNew?"is-new":"", isTrending?"is-trending":"", d.unclassified?"is-unclassified":""].filter(Boolean).join(" ");

  return `
<div class="${classes}" data-id="${d.id}">
  <div class="card-header" onclick="toggleCard(${d.id})">
    <div class="mention-bar-wrap">
      <div class="mention-count">${d.mentions}</div>
      <div class="mention-bar"><div class="mention-bar-fill" style="height:${barPct}%"></div></div>
    </div>
    <div class="card-body">
      <div class="card-insight">${esc(d.insight)}</div>
      <div class="card-pills">
        ${newBadge}${trendBadge}
        <span class="pill pill-type">${typeIcon(d.type)} ${esc(d.type)}</span>
        ${sentimentPill(d.sentiment)}
        ${squadPills}${featPills}
        <span class="pill pill-status" style="color:${statusColor(d.status)}">${esc(d.status)}</span>
      </div>
    </div>
    <div class="expand-icon">▾</div>
  </div>
  <div class="card-detail">
    <div class="detail-grid">
      <div>
        ${quoteHTML}
        <!-- NOTES -->
        <div class="detail-section">
          <div class="detail-label">Notes</div>
          <textarea class="edit-textarea" id="notes-${d.id}">${esc(d.notes && d.notes!=="nan" ? d.notes : "")}</textarea>
        </div>
        <!-- STATUS -->
        <div class="detail-section">
          <div class="detail-label">Status</div>
          <div class="status-wrap">
            <select class="status-select" id="sel-${d.id}">${statusOpts}</select>
          </div>
        </div>
        <!-- MENTIONS -->
        <div class="detail-section">
          <div class="detail-label">Mention Count</div>
          <div class="mentions-editor">
            <button class="mention-btn" onclick="adjustMention(${d.id},-1)">−</button>
            <span class="mention-display" id="mc-${d.id}">${d.mentions}</span>
            <button class="mention-btn" onclick="adjustMention(${d.id},+1)">+</button>
          </div>
        </div>
        <!-- SQUADS -->
        <div class="detail-section">
          <div class="detail-label">Affected Squads</div>
          <div class="squad-tags" id="squad-tags-${d.id}">${squadTagsHTML}</div>
          <div class="squad-add-row">
            <select class="squad-add-select" id="squad-sel-${d.id}">
              <option value="">Add squad…</option>
              ${squadAddOptions}
            </select>
            <button class="squad-add-btn" onclick="addSquad(${d.id})">Add</button>
          </div>
        </div>
        <!-- CUSTOMER GROUP -->
        <div class="detail-section">
          <div class="detail-label">Customer Group</div>
          <div class="squad-tags" id="ug-tags-${d.id}">${ugTagsHTML}</div>
          <div class="squad-add-row">
            <select class="squad-add-select" id="ug-sel-${d.id}">
              <option value="">Add group…</option>
              ${ugAddOptions}
            </select>
            <button class="squad-add-btn" onclick="addUG(${d.id})">Add</button>
          </div>
        </div>
        <!-- SAVE -->
        <div style="display:flex;align-items:center;gap:8px">
          <button class="save-all-btn" onclick="saveAll(${d.id})">Save changes</button>
          <span class="save-msg" id="save-msg-${d.id}"></span>
        </div>
        ${jiraHTML}
      </div>
      <div>${sourceHTML}${metaHTML}</div>
    </div>
    ${unclassHTML}
  </div>
</div>`;
}

function toggleCard(id) {
  const card = document.querySelector(`.insight-card[data-id="${id}"]`);
  if (card) card.classList.toggle("expanded");
}


// Safe fetch helper — surfaces Flask HTML error pages as readable messages
async function safePost(url, body) {
  const res = await fetch(url, {
    method: "POST",
    headers: {"Content-Type": "application/json"},
    body: JSON.stringify(body)
  });
  const text = await res.text();
  try {
    return { ok: res.ok, status: res.status, data: JSON.parse(text) };
  } catch (_) {
    // Flask returned an HTML error page — extract the message if possible
    const match = text.match(/<title>([^<]+)<\/title>/i);
    const msg = match ? match[1] : `HTTP ${res.status}`;
    return { ok: false, status: res.status, data: { error: msg } };
  }
}

// ── Per-card mention delta state ────────────────────────────────────────────
const mentionDeltas = {};

function adjustMention(id, delta) {
  mentionDeltas[id] = (mentionDeltas[id] || 0) + delta;
  const insight = ALL_DATA.find(d => d.id === id);
  if (!insight) return;
  const newVal = Math.max(0, insight.mentions + mentionDeltas[id]);
  const el = document.getElementById("mc-" + id);
  if (el) el.textContent = newVal;
}

// ── Per-card squad state ─────────────────────────────────────────────────────
const squadEdits = {};

function getCardSquads(id) {
  if (squadEdits[id] !== undefined) return squadEdits[id];
  const insight = ALL_DATA.find(d => d.id === id);
  return insight ? [...(insight.squads || [])] : [];
}

function removeSquad(id, index) {
  const squads = getCardSquads(id);
  squads.splice(index, 1);
  squadEdits[id] = squads;
  refreshSquadTags(id);
}

function addSquad(id) {
  const sel = document.getElementById("squad-sel-" + id);
  if (!sel || !sel.value) return;
  const squads = getCardSquads(id);
  if (!squads.includes(sel.value)) { squads.push(sel.value); squadEdits[id] = squads; }
  sel.value = "";
  refreshSquadTags(id);
}

// ── Per-card customer group state ────────────────────────────────────────────
const ugEdits = {};

function parseUGList(raw) {
  if (!raw || raw === "nan" || raw === "Unknown") return [];
  return raw.split(/[;,]/).map(g => g.trim()).filter(Boolean);
}

function getCardUGs(id) {
  if (ugEdits[id] !== undefined) return ugEdits[id];
  const insight = ALL_DATA.find(d => d.id === id);
  return insight ? parseUGList(insight.userGroup) : [];
}

function removeUG(id, index) {
  const groups = getCardUGs(id);
  groups.splice(index, 1);
  ugEdits[id] = groups;
  refreshUGTags(id);
}

function addUG(id) {
  const sel = document.getElementById("ug-sel-" + id);
  if (!sel || !sel.value) return;
  const groups = getCardUGs(id);
  if (!groups.includes(sel.value)) { groups.push(sel.value); ugEdits[id] = groups; }
  sel.value = "";
  refreshUGTags(id);
}

function refreshUGTags(id) {
  const groups = getCardUGs(id);
  const container = document.getElementById("ug-tags-" + id);
  if (!container) return;
  container.innerHTML = groups.map((g, i) =>
    `<span class="squad-tag">${esc(g)}<button class="squad-tag-remove" onclick="removeUG(${id},${i})" title="Remove">×</button></span>`
  ).join("");
  const sel = document.getElementById("ug-sel-" + id);
  if (sel) {
    const available = ALL_CUSTOMER_GROUPS.filter(g => !groups.includes(g));
    sel.innerHTML = `<option value="">Add group…</option>` + available.map(g => `<option value="${esc(g)}">${esc(g)}</option>`).join("");
  }
}

function refreshSquadTags(id) {
  const squads = getCardSquads(id);
  const container = document.getElementById("squad-tags-" + id);
  if (!container) return;
  container.innerHTML = squads.map((s, i) =>
    `<span class="squad-tag">${esc(s)}<button class="squad-tag-remove" onclick="removeSquad(${id},${i})" title="Remove">×</button></span>`
  ).join("");
  // Refresh available options in add-select
  const sel = document.getElementById("squad-sel-" + id);
  if (sel) {
    const available = ALL_SQUADS.filter(s => !squads.includes(s));
    sel.innerHTML = `<option value="">Add squad…</option>` + available.map(s => `<option value="${esc(s)}">${esc(s)}</option>`).join("");
  }
}

// ── Save all ─────────────────────────────────────────────────────────────────
async function saveAll(id) {
  const msgEl = document.getElementById("save-msg-" + id);
  if (msgEl) { msgEl.textContent = "Saving…"; msgEl.className = "save-msg"; }

  const notesEl = document.getElementById("notes-" + id);
  const statusEl = document.getElementById("sel-" + id);
  const id_int = parseInt(id, 10);
  const payload = { id: id_int };
  if (notesEl) payload.notes = notesEl.value;
  if (ugEdits[id] !== undefined) payload.userGroup = ugEdits[id].join("; ");
  if (squadEdits[id] !== undefined) payload.squads = squadEdits[id];
  if (mentionDeltas[id] !== undefined && mentionDeltas[id] !== 0) payload.mentions_delta = mentionDeltas[id];

  // Status via separate endpoint
  const newStatus = statusEl ? statusEl.value : null;
  const insight = ALL_DATA.find(d => d.id === id);
  const statusChanged = newStatus && insight && newStatus !== insight.status;

  try {
    // Save editable fields
    const hasEdits = payload.notes !== undefined || payload.userGroup !== undefined || payload.squads !== undefined || payload.mentions_delta !== undefined;
    if (hasEdits) {
      const { ok: ok1, data } = await safePost("/api/edit", payload);
      if (!ok1 || !data.ok) { if (msgEl) { msgEl.textContent = "Error: " + (data.error||"unknown"); msgEl.className = "save-err"; } return; }
      // Update local data
      if (data.row) {
        const idx = ALL_DATA.findIndex(d => d.id === id);
        if (idx >= 0) ALL_DATA[idx] = data.row;
      }
    }

    // Save status if changed
    if (statusChanged) {
      const { ok: ok2, data: d2 } = await safePost("/api/status", {id: id_int, status: newStatus});
      if (!ok2 || !d2.ok) { if (msgEl) { msgEl.textContent = "Status error: " + (d2.error||"unknown"); msgEl.className = "save-err"; } return; }
      const idx = ALL_DATA.findIndex(d => d.id === id);
      if (idx >= 0) { ALL_DATA[idx].status = newStatus; ALL_DATA[idx].isNew = newStatus.includes("New"); }
    }

    // Clear deltas
    delete mentionDeltas[id];
    delete squadEdits[id];
    delete ugEdits[id];
    MAX_MENTIONS = Math.max(...ALL_DATA.map(d => d.mentions), 1);

    if (msgEl) { msgEl.textContent = "✓ Saved"; msgEl.className = "save-msg"; }
    showToast("Changes saved", "ok");
    setTimeout(() => renderCards(), 400);

  } catch (e) {
    if (msgEl) { msgEl.textContent = "Error: " + e.message; msgEl.className = "save-err"; }
    showToast("Save failed: " + e.message, "err");
  }
}

async function reloadData() {
  showToast("Reloading from latest CSV…", "");
  try {
    const res = await fetch("/api/reload", { method: "POST" });
    const data = await res.json();
    if (data.ok) { showToast(`Reloaded ${data.count} insights`, "ok"); setTimeout(() => location.reload(), 800); }
    else showToast("Reload failed: " + (data.error||"unknown"), "err");
  } catch (e) { showToast("Reload error: " + e.message, "err"); }
}

// ── Helpers ──────────────────────────────────────────────────────────────────
function esc(str) {
  return String(str??'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
}
function sentimentPill(s) {
  if (s==="Negative") return `<span class="pill pill-neg">↓ Negative</span>`;
  if (s==="Positive") return `<span class="pill pill-pos">↑ Positive</span>`;
  return `<span class="pill pill-mix">~ Mixed</span>`;
}
function typeIcon(t) {
  return {"Missing Feature":"◈","Improvement":"△","General Feedback":"○","Idea":"◇","Bug":"✕","To be removed":"—"}[t]||"";
}
function statusColor(s) {
  if (!s) return "var(--muted2)";
  if (s.includes("New")) return "var(--accent)";
  if (s.includes("Implemented")) return "var(--pos)";
  if (s.includes("Planned")) return "var(--accent2)";
  if (s.includes("Identified")) return "var(--accent3)";
  if (s.includes("Well done")) return "var(--pos)";
  return "var(--muted2)";
}

let toastTimer;
function showToast(msg, type="") {
  let t = document.getElementById("toast");
  if (!t) { t = document.createElement("div"); t.id="toast"; t.className="toast"; document.body.appendChild(t); }
  t.textContent = msg;
  t.className = "toast " + type;
  clearTimeout(toastTimer);
  requestAnimationFrame(() => { t.classList.add("show"); toastTimer = setTimeout(() => t.classList.remove("show"), 2800); });
}

init();
