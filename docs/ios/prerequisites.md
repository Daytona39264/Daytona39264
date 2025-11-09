# Prerequisites and Requirements

Before attempting to downgrade your iOS device, ensure you have everything you need and understand all requirements.

## System Requirements

### Computer Requirements

#### For Mac Users
- **macOS Catalina (10.15) or later**: Use Finder for device management
- **macOS Mojave (10.14) or earlier**: Use iTunes
- **At least 10 GB free space**: For iOS firmware files
- **USB port**: USB-A or USB-C (with appropriate cable/adapter)

#### For Windows Users
- **Windows 10 or later**: Recommended for best compatibility
- **Latest iTunes**: Download from [Apple's website](https://www.apple.com/itunes/)
- **At least 10 GB free space**: For iOS firmware files
- **USB port**: USB 2.0 or higher

### Device Requirements

- **Compatible iPhone model**: Must support the target iOS version
- **Battery charge**: At least 50% (ideally 100%)
- **Working USB cable**: Original Apple cable recommended
- **No hardware damage**: Screen, buttons, and ports must function properly

## Software Requirements

### iTunes/Finder
- **Latest version**: Always use the most recent version
- **Download**: [apple.com/itunes](https://www.apple.com/itunes/) (Windows)
- **Built-in**: Finder on macOS Catalina and later

### Device Settings
Before starting, configure your device:

1. **Disable Find My iPhone**
   - Settings → [Your Name] → Find My → Find My iPhone
   - Toggle off and enter Apple ID password

2. **Disable Passcode** (Optional but recommended)
   - Settings → Face ID & Passcode (or Touch ID & Passcode)
   - Turn off passcode temporarily

3. **Sign Out of iCloud** (Optional but recommended)
   - Settings → [Your Name] → Sign Out
   - Follow prompts to sign out

## Required Files

### IPSW Firmware File

You need the correct IPSW file for:
- Your exact device model (e.g., iPhone 12,1 not just "iPhone 11")
- The iOS version you want to downgrade to
- From a trusted source (preferably directly from Apple)

**File Size**: Typically 5-8 GB depending on iOS version

### How to Identify Your Device Model

1. **Settings Method**
   - Settings → General → About
   - Look at "Model Name" and "Model Number"

2. **Physical Method**
   - Check text on the back of the device
   - Look up model number (starts with "A")

3. **iTunes/Finder Method**
   - Connect device to computer
   - Open iTunes/Finder
   - View device information

## Important Checks

### ✅ Signing Status Check

**CRITICAL**: You can only install iOS versions that Apple is currently signing.

1. Visit [IPSW.me](https://ipsw.me)
2. Select your device model
3. Check which versions show green "signed" status
4. Red "not signed" versions cannot be installed

**Note**: Signing status can change at any time. Check immediately before starting.

### ✅ Backup Verification

**MANDATORY**: Downgrading erases all device data.

#### iCloud Backup
1. Settings → [Your Name] → iCloud → iCloud Backup
2. Tap "Back Up Now"
3. Wait for backup to complete
4. Verify completion in iCloud settings

#### Computer Backup
1. Connect device to computer
2. Open iTunes (Windows/old Mac) or Finder (new Mac)
3. Select your device
4. Click "Back Up Now"
5. Wait for backup to complete
6. Verify in Preferences → Devices (iTunes) or Finder

**⚠️ Important**: You cannot restore a backup from a newer iOS version to an older one. If you're on iOS 17 and downgrading to iOS 16, you'll need an iOS 16 or earlier backup.

### ✅ Data to Export Separately

Some data may not be in backups:

- **Photos/Videos**: Sync with iCloud Photos or export to computer
- **Music**: Ensure synced with Apple Music or backed up
- **Documents**: Use iCloud Drive or export via apps
- **WhatsApp/Telegram**: Make app-specific backups
- **Health data**: Requires encrypted backup
- **Wallet passes**: Screenshot important passes

## Network Requirements

- **Stable internet connection**: For downloading large IPSW files
- **Reliable WiFi**: Ethernet connection preferred for computers
- **Sufficient bandwidth**: 5-8 GB downloads can take time

## Time Requirements

Plan for:
- **Backup**: 15-60 minutes (depending on data size)
- **IPSW Download**: 15-120 minutes (depending on connection)
- **Downgrade Process**: 15-30 minutes
- **Setup**: 10-30 minutes
- **Total**: 1-4 hours for complete process

## Knowledge Requirements

You should be comfortable with:
- Basic computer operations
- Connecting devices via USB
- Following step-by-step instructions
- Troubleshooting basic connection issues
- Understanding that data will be erased

## What You DON'T Need

- ❌ Jailbreak (not required)
- ❌ Special tools or software (beyond iTunes/Finder)
- ❌ Technical expertise (if following guide carefully)
- ❌ Developer account
- ❌ Special cables (standard Apple cable works)

## Risk Assessment

### Low Risk Scenarios
✅ Following guide exactly
✅ Using official IPSW files
✅ Having complete backups
✅ Device in good condition
✅ Stable power and internet

### High Risk Scenarios
⚠️ Skipping backup steps
⚠️ Using unofficial IPSW sources
⚠️ Interrupting the process
⚠️ Device with hardware issues
⚠️ Unstable power during process

## Pre-Flight Checklist

Before proceeding, confirm:

- [ ] Device battery above 50%
- [ ] Complete backup created and verified
- [ ] Find My iPhone disabled
- [ ] Target iOS version is currently signed
- [ ] Correct IPSW file downloaded
- [ ] iTunes/Finder updated to latest version
- [ ] USB cable tested and working
- [ ] At least 1 hour of uninterrupted time
- [ ] Computer has enough free space
- [ ] You understand data will be erased

## Next Steps

Once all prerequisites are met:
1. [Download the correct IPSW file](downloading-firmware.md)
2. [Begin the downgrade process](downgrade-process.md)

## Need Help?

If you're missing any prerequisites:
- [Check the Troubleshooting Guide](troubleshooting.md)
- Verify your device model and compatibility
- Ensure you have enough free time and storage
