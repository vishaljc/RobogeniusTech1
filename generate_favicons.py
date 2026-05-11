#!/usr/bin/env python3

"""
Simple Favicon Generator for RoboGenius Tech
Creates basic gradient favicons with RG text/logo
"""

try:
    from PIL import Image, ImageDraw, ImageFont
    import os
except ImportError:
    print("❌ PIL (Pillow) not installed")
    print("📦 Install with: pip3 install Pillow")
    print("Or use the online generator: https://realfavicongenerator.net/")
    exit(1)

def create_gradient_bg(width, height):
    """Create a gradient background"""
    image = Image.new('RGB', (width, height))
    draw = ImageDraw.Draw(image)
    
    # Color from #0066FF to #7B2FFF
    start_color = (0, 102, 255)  # #0066FF
    end_color = (123, 47, 255)   # #7B2FFF
    
    for y in range(height):
        ratio = y / height
        r = int(start_color[0] * (1 - ratio) + end_color[0] * ratio)
        g = int(start_color[1] * (1 - ratio) + end_color[1] * ratio)
        b = int(start_color[2] * (1 - ratio) + end_color[2] * ratio)
        draw.line([(0, y), (width, y)], fill=(r, g, b))
    
    return image

def create_favicon(size, filename, text="RG"):
    """Create a favicon with gradient background and text"""
    # Create gradient background
    img = create_gradient_bg(size, size)
    draw = ImageDraw.Draw(img)
    
    # Try to find a suitable font
    font_size = int(size * 0.5)
    try:
        font = ImageFont.truetype("/System/Library/Fonts/Helvetica.ttc", font_size)
    except:
        try:
            font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", font_size)
        except:
            font = ImageFont.load_default()
    
    # Draw text in center
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]
    
    x = (size - text_width) / 2
    y = (size - text_height) / 2 - bbox[1]
    
    draw.text((x, y), text, fill=(255, 255, 255), font=font)
    
    # Save
    img.save(filename, 'PNG')
    print(f"✅ Created: {filename}")

def create_maskable(size, filename):
    """Create maskable icon with safe zone padding"""
    # Create a larger gradient background
    img = create_gradient_bg(size, size)
    draw = ImageDraw.Draw(img)
    
    # Add RG text in the center with safe zone
    font_size = int(size * 0.35)  # Smaller to fit in safe zone
    try:
        font = ImageFont.truetype("/System/Library/Fonts/Helvetica.ttc", font_size)
    except:
        font = ImageFont.load_default()
    
    text = "RG"
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]
    
    x = (size - text_width) / 2
    y = (size - text_height) / 2 - bbox[1]
    
    draw.text((x, y), text, fill=(255, 255, 255), font=font)
    
    img.save(filename, 'PNG')
    print(f"✅ Created: {filename}")

def main():
    print("🎨 Generating RoboGenius Tech Favicons...")
    print("")
    
    # Create directories
    os.makedirs("web/icons", exist_ok=True)
    
    # Generate favicons
    create_favicon(16, "web/favicon-16x16.png", "R")
    create_favicon(32, "web/favicon-32x32.png", "RG")
    create_favicon(180, "web/apple-touch-icon.png", "RG")
    create_favicon(192, "web/icons/Icon-192.png", "RG")
    create_favicon(512, "web/icons/Icon-512.png", "RG")
    
    # Create maskable icons
    create_maskable(192, "web/icons/Icon-maskable-192.png")
    create_maskable(512, "web/icons/Icon-maskable-512.png")
    
    # Copy 32x32 as favicon.ico
    img = Image.open("web/favicon-32x32.png")
    img.save("web/favicon.ico", format='ICO')
    print("✅ Created: web/favicon.ico")
    
    print("")
    print("✨ All favicons created successfully!")
    print("")
    print("📁 Files created in web/ directory:")
    print("   • favicon.ico")
    print("   • favicon-16x16.png")
    print("   • favicon-32x32.png")
    print("   • apple-touch-icon.png")
    print("   • icons/Icon-192.png")
    print("   • icons/Icon-512.png")
    print("   • icons/Icon-maskable-192.png")
    print("   • icons/Icon-maskable-512.png")
    print("")
    print("🚀 Next Steps:")
    print("   1. Run: flutter build web --release")
    print("   2. Deploy to Netlify")
    print("   3. Your favicons will appear in browser tabs!")
    print("")
    print("💡 Want custom favicons with your logo?")
    print("   See FAVICON_GUIDE.md for detailed instructions")

if __name__ == "__main__":
    main()
