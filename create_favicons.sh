#!/bin/bash

# Simple Favicon Generator for RoboGenius Tech
# This creates basic placeholder favicons until you add your custom logo

echo "🎨 Creating favicon placeholders for RoboGenius Tech..."

# Create icons directory if it doesn't exist
mkdir -p web/icons

# Method 1: Download from placeholder service (requires internet)
echo "📥 Downloading placeholder icons..."

# Favicon sizes with RG branding colors
curl -s "https://via.placeholder.com/16x16/0066FF/FFFFFF?text=R" -o web/favicon-16x16.png
curl -s "https://via.placeholder.com/32x32/0066FF/FFFFFF?text=RG" -o web/favicon-32x32.png
curl -s "https://via.placeholder.com/180x180/0066FF/FFFFFF?text=RG" -o web/apple-touch-icon.png
curl -s "https://via.placeholder.com/192x192/0066FF/FFFFFF?text=RG" -o web/icons/Icon-192.png
curl -s "https://via.placeholder.com/512x512/0066FF/FFFFFF?text=RG" -o web/icons/Icon-512.png
curl -s "https://via.placeholder.com/192x192/7B2FFF/FFFFFF?text=RG" -o web/icons/Icon-maskable-192.png
curl -s "https://via.placeholder.com/512x512/7B2FFF/FFFFFF?text=RG" -o web/icons/Icon-maskable-512.png

# Copy 32x32 as ico (browsers will accept PNG with .ico extension)
cp web/favicon-32x32.png web/favicon.ico

echo "✅ Placeholder favicons created!"
echo ""
echo "📁 Files created:"
echo "   web/favicon.ico"
echo "   web/favicon-16x16.png"
echo "   web/favicon-32x32.png"
echo "   web/apple-touch-icon.png"
echo "   web/icons/Icon-192.png"
echo "   web/icons/Icon-512.png"
echo "   web/icons/Icon-maskable-192.png"
echo "   web/icons/Icon-maskable-512.png"
echo ""
echo "🚀 Next steps:"
echo "   1. Run: flutter build web --release"
echo "   2. Deploy to Netlify"
echo "   3. Replace with custom logos later (see FAVICON_GUIDE.md)"
echo ""
echo "💡 For custom favicons:"
echo "   Visit: https://realfavicongenerator.net/"
echo "   Upload your logo and download the package"
