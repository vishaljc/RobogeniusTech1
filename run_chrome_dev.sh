#!/bin/bash
# Kill any existing Chrome instances
killall "Google Chrome" 2>/dev/null || true
sleep 1

# Start Chrome with security disabled for testing
open -na "Google Chrome" --args \
  --disable-web-security \
  --user-data-dir="/tmp/chrome_dev_test" \
  --ignore-certificate-errors \
  --allow-insecure-localhost \
  http://localhost:8080

echo "Chrome started with security disabled"
echo "Access your app at: http://localhost:8080"
