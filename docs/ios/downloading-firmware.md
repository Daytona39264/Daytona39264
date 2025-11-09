# Downloading iOS Firmware Files

This guide covers how to download the correct IPSW (iOS Software) file for your device.

## What is an IPSW File?

An IPSW (iPhone Software) file is the complete iOS firmware package that contains:
- iOS operating system
- System applications
- Drivers and frameworks
- All necessary software for your device

**File Extension**: `.ipsw`  
**Typical Size**: 5-8 GB  
**Format**: Encrypted ZIP archive

## Finding Your Device Model

Before downloading, you need your exact device identifier.

### Method 1: Settings App
1. Open **Settings**
2. Tap **General** → **About**
3. Look for **Model Name** (e.g., "iPhone 12 Pro")
4. Tap **Model Number** to see the identifier (e.g., "iPhone13,3")

### Method 2: Using IPSW.me
1. Visit [ipsw.me](https://ipsw.me)
2. Your device appears in the list
3. Match your device name to find the identifier

### Method 3: iTunes/Finder
1. Connect device to computer
2. Open iTunes or Finder
3. Select your device
4. View model information in summary

## Checking Signing Status

⚠️ **CRITICAL**: Only signed versions can be installed.

### Using IPSW.me
1. Go to [ipsw.me](https://ipsw.me)
2. Select your device model
3. View the list of iOS versions
4. **Green "signed"** = Can be installed ✅
5. **Red "not signed"** = Cannot be installed ❌

### Signing Status Notes
- Apple typically signs versions for 1-2 weeks after release
- Signing status can change without notice
- Check immediately before downloading
- Older versions are rarely signed

## Trusted Download Sources

### Option 1: IPSW.me (Recommended)

**Direct from Apple's servers via IPSW.me interface**

1. Visit [ipsw.me](https://ipsw.me)
2. Select your device model from the list
3. Find your target iOS version (must show "signed")
4. Click the **Download** button
5. File downloads directly from Apple's servers

**Advantages**:
- Files come directly from Apple
- Shows signing status clearly
- Easy to find correct version
- Regularly updated
- Fast CDN delivery

### Option 2: Direct Apple Links

**If you know the direct URL**

Apple hosts firmware at:
```
https://updates.cdn-apple.com/...
```

However, these URLs are not easily discoverable. IPSW.me provides these links.

### Option 3: ipsw.dev

Alternative interface with similar features:
1. Visit [ipsw.dev](https://ipsw.dev)
2. Search for your device
3. Download signed versions

## Download Process

### Step-by-Step Download

1. **Open IPSW.me**
   - Navigate to [ipsw.me](https://ipsw.me) in your browser

2. **Select Device**
   - Choose your iPhone model from the list
   - Ensure you select the correct variant (e.g., iPhone 12 vs 12 Pro)

3. **Verify Signing Status**
   - Look for green "signed" indicator
   - If all versions are red, you cannot downgrade

4. **Click Download**
   - Click the download button for your target version
   - Save to a known location (e.g., Desktop or Downloads)

5. **Wait for Download**
   - File is 5-8 GB, so this may take time
   - Keep browser open until complete
   - Don't interrupt the download

6. **Verify Download**
   - Check file size (should be 5-8 GB)
   - Ensure file extension is `.ipsw`
   - File should not be corrupted

### Download Tips

- **Use wired connection**: More stable than WiFi
- **Sufficient storage**: Ensure 10+ GB free space
- **Download manager**: Consider using one for large files
- **Pause/resume**: Some browsers support pausing
- **Multiple attempts**: If download fails, try again

## Verifying the IPSW File

### File Size Check
- Should be between 5-8 GB (varies by iOS version)
- Suspiciously small files are likely corrupted
- Compare with file size listed on IPSW.me

### File Extension
- Must end with `.ipsw`
- If it ends with `.zip` or `.ipsw.zip`, rename to remove `.zip`
- Do not extract/unzip the file

### Integrity Check (Optional)

For advanced users, verify SHA-1 checksum:

**macOS/Linux**:
```bash
shasum -a 1 /path/to/file.ipsw
```

**Windows (PowerShell)**:
```powershell
Get-FileHash -Algorithm SHA1 path\to\file.ipsw
```

Compare result with checksum from IPSW.me or Apple.

## Organizing Downloaded Files

### Recommended Folder Structure
```
Downloads/
  └── iOS_Firmware/
      ├── iPhone_12_Pro_iOS_16.5_20F66.ipsw
      └── iPhone_12_Pro_iOS_16.6_20G75.ipsw
```

### Naming Convention
Keep descriptive names:
- Original filename: `iPhone13,3,iPhone13,4_16.5_20F66_Restore.ipsw`
- Simplified: `iPhone_12_Pro_iOS_16.5_20F66.ipsw`

## Common Download Issues

### Issue: Download Keeps Failing
**Solutions**:
- Try a different browser (Chrome, Firefox, Safari)
- Use a download manager (Free Download Manager, etc.)
- Check internet connection stability
- Try downloading during off-peak hours
- Use wired ethernet if possible

### Issue: File Won't Download
**Solutions**:
- Disable browser extensions temporarily
- Clear browser cache
- Try incognito/private mode
- Check if Apple's servers are down
- Try alternative download source (ipsw.dev)

### Issue: Download is Very Slow
**Solutions**:
- Check your internet speed
- Close other downloading programs
- Pause other devices on your network
- Try a VPN (sometimes helps with CDN routing)
- Download during off-peak hours

### Issue: File Appears Corrupted
**Solutions**:
- Re-download the file completely
- Verify file size matches IPSW.me
- Check available disk space
- Try downloading to a different drive
- Verify the file is not being automatically extracted

## Security Considerations

### Safe Download Practices
✅ Only download from trusted sources (IPSW.me, ipsw.dev)
✅ Verify file size and extension
✅ Use HTTPS connections
✅ Check signing status before downloading
✅ Keep antivirus active

### Unsafe Practices
❌ Don't download from random forums
❌ Don't use "modified" or "custom" IPSW files
❌ Don't download from file sharing sites
❌ Don't trust files sent via email
❌ Don't use unofficial iOS versions

## Multiple Device Downloads

If downloading for multiple devices:
- Download separately for each model
- Keep files clearly labeled
- Verify each file's device compatibility
- Don't use one device's IPSW for another

## After Downloading

Once download is complete:

1. ✅ Verify file size (5-8 GB)
2. ✅ Confirm `.ipsw` extension
3. ✅ Note file location
4. ✅ Don't extract or modify the file
5. ✅ Keep file until after successful downgrade

## Next Steps

With your IPSW file ready:
- [Proceed to the Downgrade Process](downgrade-process.md)
- Review [Prerequisites](prerequisites.md) one more time
- Ensure your backup is complete and verified

## Quick Reference

| What | Where | How |
|------|-------|-----|
| Check signing status | [IPSW.me](https://ipsw.me) | Select device, look for green "signed" |
| Download IPSW | [IPSW.me](https://ipsw.me) | Click Download button |
| Verify file | File properties | Check size (5-8 GB) and extension (.ipsw) |
| Device identifier | Settings → General → About | Look for Model Number |

## Need Help?

- Can't find your device model: Check [Apple's Support](https://support.apple.com/specs)
- Download issues: See [Troubleshooting Guide](troubleshooting.md)
- Signing status questions: Check [IPSW.me status page](https://ipsw.me)
