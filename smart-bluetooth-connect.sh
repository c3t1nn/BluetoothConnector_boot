#!/bin/bash

# Simple Boot Bluetooth Connection Script
# Just connects once at boot, no repeated attempts

MAC_ADDRESS="$1"
BLUETOOTH_CONNECTOR_PATH="/Users/c3t0/BluetoothConnector_boot/.build/release/BluetoothConnector"

echo "Boot: Connecting to $MAC_ADDRESS..."
"$BLUETOOTH_CONNECTOR_PATH" --connect "$MAC_ADDRESS" --notify
echo "Boot connection attempt completed for $MAC_ADDRESS"
