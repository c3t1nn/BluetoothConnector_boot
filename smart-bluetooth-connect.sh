#!/bin/bash
MAC_ADDRESS="$1"
BLUETOOTH_CONNECTOR_PATH="/Users/c3t0/BluetoothConnector_boot/.build/release/BluetoothConnector"
"$BLUETOOTH_CONNECTOR_PATH" --connect "$MAC_ADDRESS" --notify
