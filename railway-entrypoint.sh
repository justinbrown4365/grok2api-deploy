#!/bin/sh
set -eu

echo "[railway-entrypoint] generating config file"

mkdir -p /app/data /run/grok2api
chown -R 10001:10001 /app/data /run/grok2api

if [ -z "${GROK2API_CONFIG_B64:-}" ]; then
  echo "ERROR: GROK2API_CONFIG_B64 is not set" >&2
  exit 1
fi

if ! printf '%s' "$GROK2API_CONFIG_B64" | base64 -d > /run/grok2api/config.yaml; then
  echo "ERROR: GROK2API_CONFIG_B64 is not valid Base64" >&2
  exit 1
fi

chmod 0600 /run/grok2api/config.yaml

echo "[railway-entrypoint] config generated successfully"

# 固定调用项目原始入口，不转发 Railway 可能覆盖的 CMD 参数。
exec /usr/local/bin/grok2api-entrypoint \
  /app/grok2api \
  --config /app/config.yaml \
  --listen 0.0.0.0:8000
