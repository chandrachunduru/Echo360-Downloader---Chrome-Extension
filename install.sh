#!/usr/bin/env bash
set -e

# detect OS
case "$(uname -s)" in
  Darwin*)  HOST_DIR="$HOME/Library/Application Support/Google/Chrome/NativeMessagingHosts" ;;
  Linux*)   HOST_DIR="$HOME/.config/google-chrome/NativeMessagingHosts" ;;
  *)        echo "Unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac

mkdir -p "$HOST_DIR"

# copy your host files
cp native_host.py native_host.sh "$HOST_DIR"

# write a manifest pointing at the shell wrapper
cat > "$HOST_DIR/com.echo360_downloader.host.json" <<EOF
{
  "name": "com.echo360_downloader.host",
  "description": "Echo360 Downloader native host",
  "path": "${HOST_DIR}/native_host.sh",
  "type": "stdio",
  "allowed_origins": ["chrome-extension://<YOUR-EXTENSION-ID>/"]
}
EOF

echo "✅ Native host installed to $HOST_DIR"
echo "➡️  Now open Chrome → chrome://extensions → Load unpacked → select the 'echo360-ext' folder"
