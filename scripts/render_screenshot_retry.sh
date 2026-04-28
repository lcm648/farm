#!/usr/bin/env bash
set -u

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OUT_DIR="$ROOT_DIR/artifacts"
mkdir -p "$OUT_DIR"

log() {
  printf '[%s] %s\n' "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "$1"
}

log "Render retry started"

# 1) Playwright path
if command -v npx >/dev/null 2>&1; then
  log "Try 1/3: playwright chromium install"
  if npx -y playwright@1.55.0 install chromium; then
    log "Playwright chromium installed"
    if npx -y playwright@1.55.0 screenshot --device="Desktop Chrome" "file://$ROOT_DIR/index.html" "$OUT_DIR/index-playwright.png"; then
      log "SUCCESS: screenshot saved to artifacts/index-playwright.png"
      exit 0
    else
      log "Playwright screenshot command failed"
    fi
  else
    log "Playwright chromium install failed"
  fi
else
  log "npx not found, skip playwright"
fi

# 2) wkhtmltoimage path
if command -v wkhtmltoimage >/dev/null 2>&1; then
  log "Try 2/3: wkhtmltoimage"
  if wkhtmltoimage "file://$ROOT_DIR/index.html" "$OUT_DIR/index-wkhtml.png"; then
    log "SUCCESS: screenshot saved to artifacts/index-wkhtml.png"
    exit 0
  else
    log "wkhtmltoimage failed"
  fi
else
  log "wkhtmltoimage not found, skip"
fi

# 3) SVG direct copy fallback
if [ -f "$ROOT_DIR/assets/pipeline-v3.2.svg" ]; then
  cp "$ROOT_DIR/assets/pipeline-v3.2.svg" "$OUT_DIR/pipeline-preview.svg"
  log "FALLBACK: copied SVG preview to artifacts/pipeline-preview.svg"
  log "No PNG screenshot generated in this environment"
  exit 1
fi

log "FAIL: no render path succeeded"
exit 1
