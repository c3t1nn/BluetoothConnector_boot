# BluetoothConnector with Boot Auto-Connect

Simple macOS CLI to connect/disconnect Bluetooth devices with **automatic boot connection**.

> **Fork of [lapfelix/BluetoothConnector](https://github.com/lapfelix/BluetoothConnector) with added boot auto-connect feature**

## 🚀 Boot Auto-Connect

Automatically connect to your Bluetooth device when your Mac starts up!

## Installation

```bash
swift build -c release
sudo mv .build/release/BluetoothConnector /usr/local/bin/
```

## Usage

### Basic Commands
```bash
# List paired devices
BluetoothConnector

# Connect
BluetoothConnector --connect 00-00-00-00-00-00 --notify

# Disconnect  
BluetoothConnector --disconnect 00-00-00-00-00-00
```

### 🎯 Boot Auto-Connect

```bash
# Quick setup
./setup-boot.sh 00-00-00-00-00-00

# Manual setup
BluetoothConnector --boot 00-00-00-00-00-00
```

### Management
```bash
# Check status
launchctl list | grep bluetoothconnector

# View logs
tail -f /tmp/bluetoothconnector-boot.log

# Remove auto-connect
launchctl unload ~/Library/LaunchAgents/com.bluetoothconnector.boot.plist
rm ~/Library/LaunchAgents/com.bluetoothconnector.boot.plist
```

## What's Different?

This fork adds the **boot auto-connect** feature that automatically connects to your Bluetooth device when your Mac starts up. Perfect for AirPods, headphones, or any Bluetooth device you want to connect automatically.

## Original Project

Based on [lapfelix/BluetoothConnector](https://github.com/lapfelix/BluetoothConnector) - a simple macOS CLI to connect/disconnect Bluetooth devices.