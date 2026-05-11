# Web Testing Guide - Flutter Web with HTTPS API

## Problem
The contact form API (`https://reliwave.relitrade.in:9010/contact`) uses a self-signed SSL certificate, which browsers block for security reasons. This causes "Failed to fetch" errors in Flutter Web builds.

## Solutions

### Option 1: Test with Chrome Security Disabled (Quick & Easy)

**Step 1:** Start the Flutter web server
```bash
flutter run -d web-server --web-port 8080
```

**Step 2:** Run Chrome with security disabled
```bash
./run_chrome_dev.sh
```

Or manually:
```bash
killall "Google Chrome" 2>/dev/null
open -na "Google Chrome" --args \
  --disable-web-security \
  --user-data-dir="/tmp/chrome_dev_test" \
  --ignore-certificate-errors \
  http://localhost:8080
```

**Step 3:** Test the contact form in the opened Chrome window

⚠️ **Warning:** Only use this for development/testing. Never browse the internet with these flags enabled!

---

### Option 2: Test on Mobile/Desktop Platforms

The SSL certificate bypass works natively on mobile and desktop platforms:

**Android:**
```bash
flutter run -d android
```

**iOS:**
```bash
flutter run -d ios
```

**macOS:**
```bash
flutter run -d macos
```

**Windows:**
```bash
flutter run -d windows
```

**Linux:**
```bash
flutter run -d linux
```

---

### Option 3: Production Solution

For production deployment, you'll need to:

1. **Fix the server SSL certificate:**
   - Install a valid SSL certificate from Let's Encrypt or a trusted CA
   - Configure proper CORS headers on the server

2. **Add CORS headers to the API server:**
   ```
   Access-Control-Allow-Origin: *
   Access-Control-Allow-Methods: POST, OPTIONS
   Access-Control-Allow-Headers: Content-Type
   ```

3. **Use a reverse proxy** (nginx/Apache) with proper SSL in front of the API

---

## Current Implementation

The app automatically:
- Uses `IOClient` with certificate bypass on mobile/desktop
- Falls back to standard `http.Client` on web (where bypass isn't possible)
- Shows helpful error messages for CORS/SSL issues

## Testing Checklist

- [x] API works in Postman (with SSL verification disabled) ✅
- [ ] Test contact form on mobile/desktop (SSL bypass works)
- [ ] Test contact form on web with Chrome security disabled
- [ ] For production: Fix server SSL certificate and CORS headers
