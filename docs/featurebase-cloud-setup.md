# Featurebase access in a Claude Code cloud environment

How to set up a Claude Code on the web session so it can reach the Featurebase
API and run `featurebase_sync.py`.

The repo lives at **https://github.com/LeaDiNox/Customer-Insights-Data**
(default branch `main`). Step 0 below covers getting Claude access to it.

Once you have the repo, two more things have to be true. Miss either one and the
sync fails:

1. **`do.featurebase.app` is on the session's outbound allowlist** — otherwise the
   egress proxy blocks the connection.
2. **`FEATUREBASE_API_KEY` is set** as an environment variable in the session.

Everything else (board IDs, custom field IDs, the voter company ID) is already
committed in `featurebase_sync.py` and needs no per-person setup.

---

## Before you start: do not commit your API key

The repo `LeaDiNox/Customer-Insights-Data` is **public**. Anything you commit is
world-readable, immediately and permanently — including in git history after you
delete it.

`featurebase_sync.py` says so at the top of the file:

> Set FEATUREBASE_API_KEY as an environment variable. This file is committed
> to a public repo — never hardcode a key here, even as a fallback default.

Use `.claude/settings.local.json` (untracked) for your key, as described below.
Never `.claude/settings.json` (tracked).

---

## Step 0 — The repo, and letting Claude reach it

```
https://github.com/LeaDiNox/Customer-Insights-Data
git clone https://github.com/LeaDiNox/Customer-Insights-Data.git
```

The repo is public, so anyone can clone it. **Pushing** needs write access — ask
Lea to add you as a collaborator if you don't have it.

To let a Claude Code cloud session clone and push, connect your GitHub account
once, either way:

- **Claude GitHub App** — authorize it during onboarding at
  [claude.ai/code](https://claude.ai/code), or install it from
  [github.com/apps/claude](https://github.com/apps/claude).
- **`/web-setup`** — run it in your terminal to sync your existing `gh` CLI
  token to your Claude account. Easier if you already use `gh`.

Either is enough. Worth knowing: a cloud session can reach **any repository your
connected GitHub account can see** — installing the App on a specific repo is not
a per-repo access control. What App installation adds is PR webhooks, which is
what powers auto-fixing CI failures and review comments.

Then start a session at [claude.ai/code](https://claude.ai/code) and pick this
repo. The session clones it fresh into an isolated container.

Branch convention here: work on a branch, never push straight to `main`.

## Step 1 — Get a Featurebase API key

In Featurebase: **Settings → API**, and create a key. Keys look like
`sk_...`. Treat it like a password — it can create, edit, and delete posts on the
live Noxtua boards.

You need admin access to the Noxtua Featurebase workspace to see this page. If
you don't have it, ask Lea rather than reusing someone else's key.

## Step 2 — Allow the host

The cloud session's outbound HTTPS goes through a policy-enforcing proxy that
denies any host not explicitly allowed. Add Featurebase to the project's
allowlist in `.claude/settings.json`:

```json
{
  "network": {
    "outbound": {
      "allowedHosts": ["do.featurebase.app"],
      "blockedHosts": []
    }
  }
}
```

This part **is** safe to commit — it contains no secret — and it is already in
the repo, so you most likely don't need to change anything here.

Notes:

- The host to allow is `do.featurebase.app` (the API), **not**
  `noxtua.featurebase.app` (the public-facing board UI).
- Your environment's network policy, chosen when the cloud environment was
  created, sits above this. If it is set to "no network access", the project
  allowlist can't override it — you'll need an environment that permits outbound
  traffic. See the
  [Claude Code on the web docs](https://code.claude.com/docs/en/claude-code-on-the-web).
- After changing the allowlist, a **new session** picks it up reliably. An
  already-running session may pick it up without a restart, but don't count on
  it.

## Step 3 — Set your API key

Create `.claude/settings.local.json` in the repo root. This file is for personal,
machine-local settings and must never be committed:

```json
{
  "env": {
    "FEATUREBASE_API_KEY": "sk_your_key_here"
  }
}
```

Then make sure it is ignored by git. Confirm `.gitignore` contains:

```
.claude/settings.local.json
```

Verify it is actually untracked before you commit anything:

```bash
git check-ignore -v .claude/settings.local.json   # should print a .gitignore match
git status --short                                 # should NOT list the file
```

**Alternative for local (non-cloud) runs:** export it in your shell instead.
Nothing to gitignore, but it only lasts for that terminal session:

```bash
export FEATUREBASE_API_KEY="sk_your_key_here"
```

The script reads the key from the environment only (`os.environ.get`). It does
not read `.env` files.

## Step 4 — Verify

Run the read-only board listing. It touches the API but changes nothing:

```bash
python3 featurebase_sync.py --list-boards
```

Expected output (verified 2026-08-19):

```
Your Featurebase boards:

  ID: 6a2123630535f655cfaec3cb   Name: Feature Request
  ID: 6a213f3998f1621c64f747fb   Name:  Feedback
  ID: 6a422f49728db77bced50b63   Name: Product Board
  ID: 6a8309024756697e119ddcf9   Name: Setup Board: Germany
```

If you see those four boards, both the allowlist and the key are working, and
the board IDs hardcoded in the script still match the live workspace.

(The closing line telling you to "paste the correct ID into
MISSING_FEATURE_BOARD" is a leftover prompt from first-time setup. Ignore it —
the IDs are already configured.)

Requires Python 3.9+ (3.11 in the cloud image). No third-party packages — the
script uses only the standard library.

---

## Running the sync

Always dry-run first. It makes no API writes:

```bash
python3 featurebase_sync.py --dry-run
```

Then push for real:

```bash
python3 featurebase_sync.py --push
```

Useful variants:

| Command | What it does |
|---|---|
| `--push --id 249` | Push a single insight by ID |
| `--pull-votes` | Pull vote counts from Featurebase back into `insights.json` |
| `--check-ids` | Cross-check Featurebase posts against `insights.json` |
| `--list-companies` | List company IDs (for the voter pool) |
| `--list-custom-fields` | List custom field IDs |

Note that `--push` also **writes back** to `insights.json` (storing
`featurebase_id` and vote counts). Use `--push-no-save` to skip that.

Everything in `insights.json` is eligible to push. Review is not gated here — it
happens upstream, as part of the routine when new feedback is added, so anything
that reaches `insights.json` has already been reviewed.

Two exclusions still apply: insights whose status is "Implemented — a solution is
released" or "Well done — positive feedback outweighs negative", and any insight
explicitly marked `qa_deleted` (a deletion, not a review state).

---

## Troubleshooting

**`403` or `407` from the proxy, or "Forbidden" on CONNECT**
The host isn't allowed by the egress policy. Check `do.featurebase.app` is
spelled correctly in `allowedHosts`, then start a fresh session. Don't try to
route around the proxy or unset `HTTPS_PROXY` — it won't work and it's against
the environment's policy.

**`401 Unauthorized` from Featurebase**
The key is missing, mistyped, or revoked. Check it is actually reaching the
process:

```bash
python3 -c "import os; k=os.environ.get('FEATUREBASE_API_KEY',''); print('len', len(k))"
```

A length of `0` means the env var isn't set — most often
`.claude/settings.local.json` has a JSON syntax error, or the session was started
before you created the file.

**`certificate verify failed`**
The tool isn't trusting the proxy's CA. Point it at `/root/.ccr/ca-bundle.crt`
(e.g. `REQUESTS_CA_BUNDLE`, `SSL_CERT_FILE`). Python's `urllib` — which this
script uses — already picks it up, so you shouldn't hit this here. Never disable
TLS verification.

**Diagnosing proxy state generally**

```bash
curl -sS "$HTTPS_PROXY/__agentproxy/status"
```

Reports proxy state and the most recent proxy-side failures. Useful because curl
hides response bodies on failed CONNECTs, so the real reason for a block often
only shows up here.

**"Invalid post ID format"**
A known historical bug from calling `GET /posts/upvoters?...`, which the API
parsed as a post with id `upvoters`. Current code uses `GET /posts/{id}/voters`.
If you see this, you're on an outdated checkout — pull `main`.

---

## Reference

- API base: `https://do.featurebase.app/v2`
- Auth header: `Authorization: Bearer <key>`
- List endpoints are cursor-paginated: responses are
  `{ "object": "list", "data": [...], "nextCursor": "..." }`. Page by passing
  the cursor back, not by page numbers.
- Public board UI: https://noxtua.featurebase.app
