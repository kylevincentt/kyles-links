# CLAUDE.md — Kyle's Links

A single-page synthwave link-in-bio site. Plain static HTML, no build step.

## Stack

- **Source:** one file — `index.html` (~30 KB, ~866 lines). Inline CSS + JS, no bundler, no framework.
- **Analytics:** Google Analytics 4, Measurement ID `G-7ZM5VLJ6RR`. Tracks page views, link clicks, and scroll depth via inline `gtag()` calls in `index.html`.

## Deployment

Two paths exist in the repo — know which one the live site uses before changing config.

- **Vercel (primary):** `vercel.json` is present (currently just `{ "version": 2 }`). Vercel deploys on push to `main`. No build step — it serves `index.html` from the repo root.
- **Docker / nginx (alternative):** `Dockerfile` + `nginx.conf` build a static-serving image. The Dockerfile fetches Space Cadet Pinball WASM assets (`SpaceCadetPinball.js/.wasm/.data`) and copies in the project `index.html`. Use this path on hosts that need a container (e.g., Railway).

**Not** GitHub Pages — there is no Pages workflow or `CNAME`.

## Known gotcha — WASM headers

The Docker variant ships Space Cadet Pinball via WebAssembly and **`nginx.conf` sets COOP/COEP headers** required for cross-origin isolation (`SharedArrayBuffer`):

```
Cross-Origin-Opener-Policy:   same-origin
Cross-Origin-Embedder-Policy: require-corp
Cross-Origin-Resource-Policy: same-origin
```

`vercel.json` does **not** currently set these headers. If you want the pinball game to work on a Vercel deployment, add a `headers` array to `vercel.json` matching the nginx config. Otherwise the game will fail to instantiate.

## Editing

- Edit `index.html` directly — there is no build, no source map, no tooling. Open it in a browser to test.
- When adding a link, keep the existing markup and CSS class conventions (synthwave palette: neon pink/cyan/magenta on dark background). Don't introduce a framework just to add a link.
- If you change GA event names, also update any downstream dashboards.

## Layout

```
index.html      — the entire site (HTML + inline CSS + inline JS + GA4)
vercel.json     — Vercel deployment config (no headers)
Dockerfile      — nginx-based container image, fetches pinball WASM
nginx.conf      — sets COOP/COEP for WASM, SPA fallback
README.md       — currently empty
```
