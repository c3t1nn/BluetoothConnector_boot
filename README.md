# BluetoothConnector Boot

Fork of [lapfelix/BluetoothConnector](https://github.com/lapfelix/BluetoothConnector) - Auto-connect Bluetooth device at boot.

## What This Does

Connects your Bluetooth device automatically when Mac starts up. Runs once at boot, then stops. No loops, no repeated attempts.

## Installation

```bash
swift build -c release
```

## Usage

### Setup Auto-Connect
```bash
./setup-boot.sh YOUR-MAC-ADDRESS
# Example: ./setup-boot.sh 07-b1-87-8e-b9-7f
```

### Manual Commands
```bash
# Connect manually
./setup-boot.sh --connect MAC-ADDRESS

# Disconnect manually
./.build/release/BluetoothConnector --disconnect MAC-ADDRESS
```

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

## Difference from Original

**Original [lapfelix/BluetoothConnector](https://github.com/lapfelix/BluetoothConnector):**
- Manual connection only
- No auto-connect feature

**This Fork:**
- Boot auto-connect
- One-time execution
- Simple setup
- Less is more approach

## License

MIT License - Same as original project.