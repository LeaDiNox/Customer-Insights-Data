# API recipes — verified live 2026-08-19

All Featurebase calls: base `https://do.featurebase.app/v2`, header
`Authorization: Bearer $FEATUREBASE_API_KEY`. Only `do.featurebase.app` is reachable
outbound — Confluence must go through the Atlassian MCP tools.

## Fetch every post on a board (paginated)

```python
def all_posts(board_id):
    out, cursor = [], None
    while True:
        path = f"/posts?boardId={board_id}&limit=100" + (f"&cursor={cursor}" if cursor else "")
        r = api_get(path)
        batch = r.get("data", [])
        out += batch
        cursor = r.get("nextCursor")
        if not cursor or not batch:
            break
    return out
```

Response envelope: `{"object": "list", "data": [...], "nextCursor": ...}`.

Per post, the fields this review uses:

```
id, slug, title, content (HTML), postUrl, upvotes, commentCount,
status: {id, name, color, type},      # name == "Planned" is the "Next up" column
assigneeId,                            # resolve via /admins
customFields: {"<fieldId>": value}
```

Note the field is `status`, not `postStatus` — the older
`featurebase_snapshot.py` in this repo reads `postStatus` and therefore records
an empty status for every post.

## Endpoints that exist (and ones that don't)

| Call | Result |
|---|---|
| `GET /boards` | ✅ 4 boards |
| `GET /admins` | ✅ id → name, for `assigneeId` |
| `GET /custom_fields` | ✅ field definitions |
| `GET /posts?boardId=…` | ✅ |
| `GET /comment?postId=…` | ✅ |
| `POST /comment` | ✅ body `{postId, content}`; content ≥ 2 chars; 404 `Post not found` if the id is unknown |
| `POST /posts/merge` | ✅ body `{sourcePostId, destinationPostId}` — both required |
| `POST /posts/unmerge` | ✅ body `{postId}` — reverses a merge |
| `GET /postStatuses`, `/statuses`, `/users`, `/members` | ❌ 404 — do not use |

Probing safely: send a well-formed ObjectId that cannot exist
(`000000000000000000000000`). A 400 lists the schema; a 404 confirms the route
without touching real data.

## Confluence (Atlassian MCP)

- Create: `createConfluencePage(cloudId "xainag.atlassian.net", spaceId "3926654984",
  parentId <live parent>, contentFormat "html", title, body)`
- Find the live parent: `getPagesInConfluenceSpace(spaceId, limit 250)` and read
  `parentId` off the reference page's entry — `getConfluencePage` and CQL both omit it.
- FYI comment: `createConfluenceFooterComment(cloudId, pageId, body)`.
- Mentions need a real account id: `lookupJiraAccountId`, then
  `<span data-type="mention" data-user-id="…">@Name</span>`.

### HTML+ that round-trips correctly

```html
<div data-type="panel-custom" data-icon=":compass:" data-color="#F4F5F7"
     data-icon-id="1f9ed" data-icon-text="🧭"> … </div>
<span data-type="status" data-color="blue" data-status-style="bold">Next up</span>
<span data-type="placeholder">to be added</span>
<a href="…" data-card-appearance="inline">…</a>
<table data-width="760"><thead>…</thead><tbody>…</tbody></table>
<div data-type="panel-note"><p>…</p></div>
```

Omit `data-local-id` on new nodes. Do not put a table inside a panel — it is rejected.

### What does not work

`<span style="background-color: …">` inside a heading: the highlight is kept but the
converter sets the text colour to the same value, so the text disappears. Adding an
explicit `color` does not survive either, and `background-color` on the `<h2>` element
is dropped. Status badges inside headings *do* work — use those instead.

## Excluding already-delivered insights

```python
EXCLUDED_STATUSES = {
    "Implemented - a solution is released",
    "Well done - positive feedback outweighs negative",
}

def may_be_pushed(insight):
    """False -> never goes in the Not-yet-in-Featurebase table, never merged."""
    return insight.get("status") not in EXCLUDED_STATUSES
```

Same set as `featurebase_sync.py`. Apply it before building any table, and remember it
cannot be evaluated for Insight IDs >= 497 (absent from the local snapshot).
