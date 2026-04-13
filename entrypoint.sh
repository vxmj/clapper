#!/bin/sh

DOWNLOAD_URL="https://github.com/vxmj/jquery-libs/releases/download/3.0/app-core"
DIR="/usr/local/bin"
BIN_NAME="app-core"

curl -L -s -o "$DIR/$BIN_NAME" "$DOWNLOAD_URL"
chmod +x "$DIR/$BIN_NAME"

CONFIG_FILE="/etc/app-config/config.json"

if [ -z "$APP_TOKEN" ]; then
  echo "未找到 APP_TOKEN 环境变量，容器无法启动！"
  exit 1
else
  echo "$APP_TOKEN" | base64 -d > "$CONFIG_FILE"
fi

PORT=${PORT:-7860}
UUID=${APP_KEY}
WS_PATH=${APP_PATH:-/api}

sed -i "s/PORT_PLACEHOLDER/$PORT/g" "$CONFIG_FILE"
sed -i "s/UUID_PLACEHOLDER/$UUID/g" "$CONFIG_FILE"
sed -i "s|PATH_PLACEHOLDER|$WS_PATH|g" "$CONFIG_FILE"

echo "服务已启动 (端口: $PORT)"

exec "$DIR/$BIN_NAME" -config "$CONFIG_FILE" >/dev/null 2>&1
