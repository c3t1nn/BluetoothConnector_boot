#!/bin/bash

# BluetoothConnector Boot Setup Script
# This script sets up BluetoothConnector to run automatically at system startup

set -e

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}BluetoothConnector Boot Setup${NC}"
echo "=================================="

# Get MAC address from user
if [ -z "$1" ]; then
    echo -e "${YELLOW}Usage: $0 <MAC_ADDRESS>${NC}"
    echo "Example: $0 00-11-22-33-44-55"
    echo ""
    echo "To see currently paired devices:"
    echo "BluetoothConnector"
    exit 1
fi

MAC_ADDRESS="$1"

# Validate MAC address (simple check)
if [[ ! $MAC_ADDRESS =~ ^[0-9A-Fa-f]{2}-[0-9A-Fa-f]{2}-[0-9A-Fa-f]{2}-[0-9A-Fa-f]{2}-[0-9A-Fa-f]{2}-[0-9A-Fa-f]{2}$ ]]; then
    echo -e "${RED}Error: Invalid MAC address format. Format: 00-11-22-33-44-55${NC}"
    exit 1
fi

echo -e "${GREEN}MAC Address: $MAC_ADDRESS${NC}"

# Check if BluetoothConnector is installed
BLUETOOTH_CONNECTOR_PATH=""
if command -v BluetoothConnector &> /dev/null; then
    BLUETOOTH_CONNECTOR_PATH="BluetoothConnector"
    echo -e "${GREEN}BluetoothConnector found (system-wide)${NC}"
elif [ -f ".build/release/BluetoothConnector" ]; then
    BLUETOOTH_CONNECTOR_PATH="$(pwd)/.build/release/BluetoothConnector"
    echo -e "${GREEN}BluetoothConnector found (local build)${NC}"
else
    echo -e "${RED}Error: BluetoothConnector not found. Build it first:${NC}"
    echo "swift build -c release"
    exit 1
fi

# Create plist file
PLIST_FILE="$HOME/Library/LaunchAgents/com.bluetoothconnector.boot.plist"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${YELLOW}Creating LaunchAgent plist file...${NC}"

cat > "$PLIST_FILE" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.bluetoothconnector.boot</string>
    
    <key>ProgramArguments</key>
    <array>
        <string>$BLUETOOTH_CONNECTOR_PATH</string>
        <string>--boot</string>
        <string>$MAC_ADDRESS</string>
    </array>
    
    <key>RunAtLoad</key>
    <true/>
    
    <key>StartInterval</key>
    <integer>300</integer>
    
    <key>StandardOutPath</key>
    <string>/tmp/bluetoothconnector-boot.log</string>
    
    <key>StandardErrorPath</key>
    <string>/tmp/bluetoothconnector-boot-error.log</string>
    
    <key>ThrottleInterval</key>
    <integer>60</integer>
</dict>
</plist>
EOF

echo -e "${GREEN}LaunchAgent plist file created: $PLIST_FILE${NC}"

# Load LaunchAgent
echo -e "${YELLOW}Loading LaunchAgent...${NC}"
launchctl load "$PLIST_FILE"

echo -e "${GREEN}✅ Boot auto-connect setup completed!${NC}"
echo ""
echo -e "${YELLOW}Setup details:${NC}"
echo "- MAC Address: $MAC_ADDRESS"
echo "- Plist file: $PLIST_FILE"
echo "- Log files: /tmp/bluetoothconnector-boot*.log"
echo ""
echo -e "${YELLOW}Usage:${NC}"
echo "- To stop auto-connect: launchctl unload $PLIST_FILE"
echo "- To check status: launchctl list | grep bluetoothconnector"
echo "- To view logs: tail -f /tmp/bluetoothconnector-boot.log"
echo ""
echo -e "${GREEN}Your system will now automatically connect to $MAC_ADDRESS on startup!${NC}"
