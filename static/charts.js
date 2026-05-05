/* ── Noxtua Insights · charts.js ─────────────────────────────────────────── */

let chartsRendered = false;
let CHART_DATA = [];
const CHART_INSTANCES = {};

// Brand-aligned palette
const PALETTE = [
  "#ba99cf","#70a3f4","#a3aad0","#c7bdd0","#dfe9fc",
  "#5c406b","#60c8a0","#e07070","#e0b870","#7a5a8a",
  "#9b80bf","#5080d0","#83a0c0","#a080b0","#c0d8f0",
  "#4a2248","#409080","#c05050","#b09050","#6a4a7a",
];

Chart.defaults.font.family = "'DM Sans', sans-serif";
Chart.defaults.font.size = 11;
Chart.defaults.font.weight = "300";
Chart.defaults.color = "#a390b0";

function renderCharts(data) {
  if (chartsRendered) return;
  chartsRendered = true;
  CHART_DATA = data;
  populateSquadFilter(data);
  renderStatusChart(data);
  renderTypeChart(data);
  renderUserGroupChart(data);
  renderSourceTypeChart(data);
  renderSourcesChart(data);
}

// ── Squad filter for status chart ────────────────────────────────────────────
function populateSquadFilter(data) {
  const sel = document.getElementById("status-squad-filter");
  if (!sel) return;
  const squads = [...new Set(data.flatMap(d => d.squads||[]))].sort();
  sel.innerHTML = `<option value="">All squads</option>` + squads.map(s => `<option value="${s}">${s}</option>`).join("");
}

function updateStatusChart() {
  const sel = document.getElementById("status-squad-filter");
  const squad = sel ? sel.value : "";
  const filtered = squad ? CHART_DATA.filter(d => (d.squads||[]).includes(squad)) : CHART_DATA;
  if (CHART_INSTANCES.status) { CHART_INSTANCES.status.destroy(); delete CHART_INSTANCES.status; }
  document.getElementById("legend-status").innerHTML = "";
  renderStatusChart(filtered);
}

// ── 1. Status Donut ───────────────────────────────────────────────────────────
function renderStatusChart(data) {
  const counts = {};
  data.forEach(d => { const s = d.status||"Unknown"; counts[s]=(counts[s]||0)+1; });
  const labels = Object.keys(counts).sort((a,b)=>counts[b]-counts[a]);
  const values = labels.map(l=>counts[l]);
  const colors = labels.map(l=>statusChartColor(l));

  const ctx = document.getElementById("chart-status").getContext("2d");
  CHART_INSTANCES.status = new Chart(ctx, {
    type:"doughnut",
    data: { labels, datasets:[{ data:values, backgroundColor:colors, borderColor:"#2a1229", borderWidth:2, hoverOffset:4 }] },
    options: { responsive:true, maintainAspectRatio:true, cutout:"62%", plugins:{ legend:{display:false}, tooltip:{ callbacks:{ label:ctx=>` ${ctx.label}: ${ctx.parsed} (${Math.round(ctx.parsed/data.length*100)}%)` } } } }
  });

  document.getElementById("legend-status").innerHTML = labels.map((l,i)=>`
    <div class="legend-item">
      <div class="legend-dot" style="background:${colors[i]}"></div>
      <span class="legend-label">${l}</span>
      <span class="legend-count">${values[i]}</span>
    </div>`).join("");
}

function statusChartColor(s) {
  if (s.includes("New")) return "#ba99cf";
  if (s.includes("Implemented")) return "#60c8a0";
  if (s.includes("Planned")) return "#70a3f4";
  if (s.includes("Identified")) return "#e0b870";
  if (s.includes("Well done")) return "#a3aad0";
  return "#4a2248";
}

// ── 2. Feedback Type Donut ───────────────────────────────────────────────────
function renderTypeChart(data) {
  const counts = {};
  data.forEach(d => { const t = d.type||"Unknown"; counts[t]=(counts[t]||0)+1; });
  const labels = Object.keys(counts).sort((a,b)=>counts[b]-counts[a]);
  const values = labels.map(l=>counts[l]);
  const colors = PALETTE.slice(0, labels.length);

  const ctx = document.getElementById("chart-type").getContext("2d");
  CHART_INSTANCES.type = new Chart(ctx, {
    type:"doughnut",
    data: { labels, datasets:[{ data:values, backgroundColor:colors, borderColor:"#2a1229", borderWidth:2, hoverOffset:4 }] },
    options: { responsive:true, maintainAspectRatio:true, cutout:"62%", plugins:{ legend:{display:false}, tooltip:{ callbacks:{ label:ctx=>` ${ctx.label}: ${ctx.parsed}` } } } }
  });

  document.getElementById("legend-type").innerHTML = labels.map((l,i)=>`
    <div class="legend-item">
      <div class="legend-dot" style="background:${colors[i]}"></div>
      <span class="legend-label">${l}</span>
      <span class="legend-count">${values[i]}</span>
    </div>`).join("");
}

// ── 3. Customer Group Bar ─────────────────────────────────────────────────────
function renderUserGroupChart(data) {
  const counts = {};
  data.forEach(d => {
    const raw = d.userGroup||"";
    [...new Set(raw.split(/[;,]/).map(g=>g.trim()).filter(g=>g&&g!=="nan"))]
      .forEach(g => { counts[g]=(counts[g]||0)+1; });
  });
  const sorted = Object.entries(counts).sort((a,b)=>b[1]-a[1]);

  const ctx = document.getElementById("chart-usergroup").getContext("2d");
  CHART_INSTANCES.usergroup = new Chart(ctx, {
    type:"bar",
    data: { labels:sorted.map(e=>e[0]), datasets:[{ data:sorted.map(e=>e[1]), backgroundColor:PALETTE.slice(0,sorted.length), borderRadius:3, borderSkipped:false }] },
    options: { indexAxis:"y", responsive:true, maintainAspectRatio:false, plugins:{ legend:{display:false}, tooltip:{ callbacks:{ label:ctx=>` ${ctx.parsed.x} insights` } } }, scales: { x:{ grid:{color:"#3D1A39"}, ticks:{color:"#a390b0"}, border:{color:"#3D1A39"} }, y:{ grid:{display:false}, ticks:{color:"#EFEEEA"}, border:{color:"#3D1A39"} } } }
  });
}

// ── 4. Source Type Donut ──────────────────────────────────────────────────────
function renderSourceTypeChart(data) {
  const counts = {};
  data.forEach(d => {
    [...new Set(d.sourceTypes||[])].forEach(st => { if(st&&st!=="nan") counts[st]=(counts[st]||0)+1; });
  });
  const labels = Object.keys(counts).sort((a,b)=>counts[b]-counts[a]);
  const values = labels.map(l=>counts[l]);
  const colors = [PALETTE[1],PALETTE[0],PALETTE[2],PALETTE[4],PALETTE[3],PALETTE[5]].slice(0,labels.length);

  const ctx = document.getElementById("chart-sourcetype").getContext("2d");
  CHART_INSTANCES.sourcetype = new Chart(ctx, {
    type:"doughnut",
    data: { labels, datasets:[{ data:values, backgroundColor:colors, borderColor:"#2a1229", borderWidth:2, hoverOffset:4 }] },
    options: { responsive:true, maintainAspectRatio:true, cutout:"62%", plugins:{ legend:{display:false}, tooltip:{ callbacks:{ label:ctx=>` ${ctx.label}: ${ctx.parsed}` } } } }
  });

  document.getElementById("legend-sourcetype").innerHTML = labels.map((l,i)=>`
    <div class="legend-item">
      <div class="legend-dot" style="background:${colors[i]}"></div>
      <span class="legend-label">${l}</span>
      <span class="legend-count">${values[i]}</span>
    </div>`).join("");
}

// ── 5. Top Sources Bar ────────────────────────────────────────────────────────
function renderSourcesChart(data) {
  const counts = {};
  data.forEach(d => {
    (d.source||"").split(",").map(s=>s.trim()).filter(s=>s&&s!=="nan")
      .forEach(s => { counts[s]=(counts[s]||0)+1; });
  });
  const sorted = Object.entries(counts).sort((a,b)=>b[1]-a[1]).slice(0,20);

  const ctx = document.getElementById("chart-sources").getContext("2d");
  CHART_INSTANCES.sources = new Chart(ctx, {
    type:"bar",
    data: { labels:sorted.map(e=>e[0]), datasets:[{ data:sorted.map(e=>e[1]), backgroundColor:"#ba99cf", borderRadius:3, borderSkipped:false }] },
    options: { indexAxis:"y", responsive:true, maintainAspectRatio:false, plugins:{ legend:{display:false}, tooltip:{ callbacks:{ label:ctx=>` ${ctx.parsed.x} insights` } } }, scales: { x:{ grid:{color:"#3D1A39"}, ticks:{color:"#a390b0"}, border:{color:"#3D1A39"} }, y:{ grid:{display:false}, ticks:{color:"#EFEEEA",font:{size:10}}, border:{color:"#3D1A39"} } } }
  });
}
