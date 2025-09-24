#!/bin/bash
# BluetoothConnector Boot Setup

# If --connect flag, just connect and exit
if [ "$1" = "--connect" ]; then
    MAC_ADDRESS="$2"
    BLUETOOTH_CONNECTOR_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.build/release/BluetoothConnector"
    "$BLUETOOTH_CONNECTOR_PATH" --connect "$MAC_ADDRESS" --notify
    exit 0
fi

# Setup mode
if [ -z "$1" ]; then
    echo "Usage: $0 <MAC_ADDRESS>"
    echo "Example: $0 07-b1-87-8e-b9-7f"
    exit 1
fi

MAC_ADDRESS="$1"
PLIST_FILE="$HOME/Library/LaunchAgents/com.bluetoothconnector.boot.plist"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up auto-connect for $MAC_ADDRESS..."

cat > "$PLIST_FILE" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.bluetoothconnector.boot</string>
    
    <key>ProgramArguments</key>
    <array>
        <string>$SCRIPT_DIR/setup-boot.sh</string>
        <string>--connect</string>
        <string>$MAC_ADDRESS</string>
    </array>
    
    <key>RunAtLoad</key>
    <true/>
    
    <key>StandardOutPath</key>
    <string>/tmp/bluetoothconnector-boot.log</string>
    
    <key>StandardErrorPath</key>
    <string>/tmp/bluetoothconnector-boot-error.log</string>
</dict>
</plist>
EOF

launchctl load "$PLIST_FILE"
echo "✅ Auto-connect setup completed!"
echo "To remove: launchctl unload $PLIST_FILE && rm $PLIST_FILE"
