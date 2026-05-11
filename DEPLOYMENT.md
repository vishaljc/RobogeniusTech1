# Deployment Guide - RoboGenius Tech Website

## Prerequisites

1. Netlify account (sign up at https://netlify.com)
2. Git repository with your code
3. Flutter SDK installed

## Deployment Steps

### Step 1: Build the Flutter Web App

```bash
flutter clean
flutter pub get
flutter build web --release
```

This creates a production build in `build/web/`

### Step 2: Deploy to Netlify

**Option A: Netlify CLI (Recommended)**

```bash
# Install Netlify CLI
npm install -g netlify-cli

# Login to Netlify
netlify login

# Deploy
netlify deploy --prod --dir=build/web
```

**Option B: Netlify Web Interface**

1. Go to https://app.netlify.com
2. Click "Add new site" → "Deploy manually"
3. Drag and drop the `build/web` folder
4. Your site will be live at `https://your-site-name.netlify.app`

**Option C: Connect Git Repository**

1. Push your code to GitHub/GitLab/Bitbucket
2. In Netlify, click "Add new site" → "Import an existing project"
3. Connect your repository
4. Build settings:
   - **Build command**: `flutter build web --release`
   - **Publish directory**: `build/web`
5. Click "Deploy site"

### Step 3: Environment Configuration

The app automatically detects the environment:
- **Production (Netlify)**: Uses `/.netlify/functions/contact` proxy
- **Local Development**: Uses direct API with SSL bypass
- **Native Apps**: Uses IOClient with SSL bypass

## How It Works

### For Web Deployment (Netlify)

```
User Browser → Netlify → Serverless Function → Your API
```

The Netlify serverless function at `netlify/functions/contact.js` acts as a proxy:
- Handles CORS
- Bypasses SSL certificate verification server-side
- Returns response to your Flutter app

### For Native Apps (iOS/Android/Desktop)

```
App → Direct HTTPS Connection → Your API
```

Native apps can bypass SSL verification using `IOClient`.

## Testing After Deployment

1. Visit your Netlify URL: `https://your-site-name.netlify.app`
2. Navigate to the Contact page
3. Fill out the form
4. Submit and verify it works

## Troubleshooting

### Issue: Contact form not working on Netlify

**Check:**
1. Netlify function deployed correctly:
   - Go to Netlify dashboard → Functions
   - You should see `contact` function listed
2. Check Netlify function logs for errors
3. Verify your API server is accessible

### Issue: CORS errors

**Solution:** The Netlify function should handle CORS. If issues persist, update the function headers in `netlify/functions/contact.js`.

### Issue: 404 on netlify function

**Solution:** Ensure `netlify.toml` is in the root directory with correct configuration.

## Production Recommendations

### Long-term Solution: Fix the API Server

For production, it's recommended to:

1. **Get a valid SSL certificate:**
   ```bash
   # Using Let's Encrypt (free)
   sudo apt-get install certbot
   sudo certbot certonly --standalone -d reliwave.relitrade.in
   ```

2. **Add CORS to your Flask API:**
   ```python
   from flask_cors import CORS
   
   app = Flask(__name__)
   CORS(app, resources={r"/contact": {
       "origins": ["https://your-site-name.netlify.app"],
       "methods": ["POST", "OPTIONS"]
   }})
   ```

3. **Update Flutter app** to call API directly (remove proxy)

### Security Considerations

- The serverless function disables SSL verification (`rejectUnauthorized: false`)
- This is acceptable for internal APIs but not recommended long-term
- Consider moving API behind a proper SSL-enabled endpoint

## Custom Domain (Optional)

1. In Netlify dashboard → Domain settings
2. Add custom domain
3. Update DNS records as instructed
4. SSL certificate is automatically provisioned

## Continuous Deployment

Once connected to Git:
- Every push to main branch triggers automatic deployment
- Netlify builds and deploys your Flutter app
- Updates are live in ~2-3 minutes

## Files Created for Deployment

- `netlify.toml` - Netlify configuration
- `netlify/functions/contact.js` - Serverless proxy function
- `WEB_TESTING.md` - Testing guide for development

## Cost

- **Netlify Free Tier** includes:
  - 100GB bandwidth/month
  - Unlimited sites
  - Serverless functions (125k requests/month)
  - Automatic SSL
  - Custom domains

Perfect for this project! 🚀
