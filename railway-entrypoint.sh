#!/bin/sh
set -eu

# Railway Volume 挂到 /app/data 后通常由 root 创建；
# 官方程序实际以 UID 10001 运行，因此修正目录归属。
mkdir -p /app/data /run/grok2api
chown -R 10001:10001 /app/data /run/grok2api

# 由 Railway Variable 中的 Base64 内容恢复配置文件。
if [ -z "${GROK2API_CONFIG_B64:-}" ]; then
  echo "missing GROK2API_CONFIG_B64" >&2
  exit 1
fi

printf '%s' "$GROK2API_CONFIG_B64" | base64 -d > /run/grok2api/config.yaml
chmod 0600 /run/grok2api/config.yaml

# 调用官方入口脚本；它会进一步复制配置并以 grok2api 用户启动程序。
exec /usr/local/bin/grok2api-entrypoint "$@"
