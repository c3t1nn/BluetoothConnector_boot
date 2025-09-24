# BluetoothConnector Boot

**Fork of [lapfelix/BluetoothConnector](https://github.com/lapfelix/BluetoothConnector)** - Simple macOS CLI with automatic boot connection.

> **Less is more** - Just connects your Bluetooth device once at startup, then stops.

## What This Does

- ✅ **Boot Auto-Connect**: Automatically connects your Bluetooth device when Mac starts
- ✅ **One-time Only**: Runs once at boot, no repeated attempts
- ✅ **No Spam**: Won't keep sending "Already connected" notifications
- ✅ **Perfect for**: AirPods, headphones, speakers, any Bluetooth device

## Quick Start

### 1. Build
```bash
swift build -c release
```

### 2. Find Your Device
```bash
./.build/release/BluetoothConnector
```

### 3. Setup Auto-Connect
```bash
./setup-boot.sh YOUR-MAC-ADDRESS
# Example: ./setup-boot.sh 07-b1-87-8e-b9-7f
```

**Done!** Your device will now connect automatically at boot.

## How It Works

1. **Boot**: Mac starts → Launch Agent runs once
2. **Connect**: Tries to connect your device
3. **Done**: Stops, no more attempts until next boot

## Management

### Check Status
```bash
launchctl list | grep bluetoothconnector
```

### View Logs
```bash
tail -f /tmp/bluetoothconnector-boot.log
```

### Remove Auto-Connect
```bash
launchctl unload ~/Library/LaunchAgents/com.bluetoothconnector.boot.plist
rm ~/Library/LaunchAgents/com.bluetoothconnector.boot.plist
```

## Manual Commands

```bash
# Connect manually
./.build/release/BluetoothConnector --connect MAC-ADDRESS --notify

# Disconnect manually  
./.build/release/BluetoothConnector --disconnect MAC-ADDRESS
```

## What's Different from Original?

This fork adds **boot auto-connect** feature:
- Original: Manual connection only
- This fork: Automatic connection at startup + manual commands

**Less is more approach** - Simple, clean, no unnecessary complexity.

## License

MIT License - Same as original project.