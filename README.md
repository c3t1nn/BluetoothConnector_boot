# BluetoothConnector Boot

**Fork of [lapfelix/BluetoothConnector](https://github.com/lapfelix/BluetoothConnector)** - Auto-connect Bluetooth device at boot.

> **Less is more** - Connects once at startup, then stops. No loops, no spam.

## What This Does

- ✅ **Boot Auto-Connect**: Connects your Bluetooth device when Mac starts
- ✅ **One-time Only**: Runs once at boot, no repeated attempts  
- ✅ **No Spam**: Won't keep sending notifications
- ✅ **Perfect for**: AirPods, headphones, speakers

## Quick Setup

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

**Done!** Your device will connect automatically at boot.

## How It Works

1. **Boot**: Mac starts → Script runs once
2. **Connect**: Tries to connect your device → Sends notification
3. **Stop**: Script ends, no background process

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
./setup-boot.sh --connect MAC-ADDRESS

# Disconnect manually  
./.build/release/BluetoothConnector --disconnect MAC-ADDRESS
```

## What's Different from Original?

**Original [lapfelix/BluetoothConnector](https://github.com/lapfelix/BluetoothConnector):**
- Manual connection only
- No auto-connect feature

**This Fork:**
- ✅ **Boot auto-connect** - Connects automatically at startup
- ✅ **One-time execution** - No loops or repeated attempts
- ✅ **Simple setup** - Single command setup
- ✅ **Less is more** - Minimal, clean approach

## License

MIT License - Same as original project.