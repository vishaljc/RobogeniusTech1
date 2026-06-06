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

### Step 2: Deploy to Cloudflare Pages (or Netlify)

#### Option A: Cloudflare Pages (Recommended)

**Via Git Integration (Highly Recommended):**
1. Push your code to GitHub/GitLab.
2. Go to the Cloudflare Dashboard → **Workers & Pages** → **Create application** → **Pages** → **Connect to Git**.
3. Select your repository.
4. Set up the build settings:
   - **Framework preset**: `None` (or `Flutter` if available)
   - **Build command**: `flutter build web --release`
   - **Build output directory**: `build/web`
5. Click **Save and Deploy**.
6. Cloudflare will automatically build and deploy your site, and compile the proxy function located in `functions/api/contact.js`.

**Via Wrangler CLI (Direct Upload):**
1. Install Wrangler CLI: `npm install -g wrangler`
2. Login to Cloudflare: `npx wrangler login`
3. Build the Flutter app: `flutter build web --release`
4. Deploy the folder: `npx wrangler pages deploy build/web --project-name=your-project-name`
   *(This also uploads the copy of Pages Functions located at `build/web/functions/api/contact.js`)*

#### Option B: Netlify

**Via Netlify Web Interface:**
1. Go to https://app.netlify.com
2. Click "Add new site" → "Deploy manually"
3. Drag and drop the `build/web` folder.
4. Your site will be live at `https://your-site-name.netlify.app`.

### Step 3: Environment Configuration

The app automatically detects the environment:
- **Cloudflare Pages (Production)**: Uses `/api/contact` proxy (routes to Cloudflare Pages Function proxy)
- **Netlify (Production)**: Uses `/.netlify/functions/contact` proxy
- **Local Development**: Uses direct API with SSL bypass
- **Native Apps**: Uses `IOClient` with SSL bypass

## How It Works

### For Cloudflare Pages
```
User Browser → Cloudflare Pages → Pages Function (/api/contact) → Upstream API (CORS Bypass)
```
The Cloudflare Pages Function at `functions/api/contact.js` (or `build/web/functions/api/contact.js`) acts as a proxy:
- Resolves CORS blocks by returning proper CORS headers (`Access-Control-Allow-Origin: *`).
- Makes a server-to-server request to the upstream Flask API, bypassing the browser's CORS/SSL restrictions.

### For Netlify
```
User Browser → Netlify → Serverless Function (/.netlify/functions/contact) → Upstream API
```

### For Native Apps (iOS/Android/Desktop)
```
App → Direct HTTPS Connection → Upstream API
```
Native apps can bypass SSL verification natively in Dart using `IOClient`.

## Testing After Deployment

1. Visit your Cloudflare Pages URL (e.g. `https://your-project.pages.dev` or custom domain).
2. Go to the **Contact** page.
3. Fill out and submit the form.
4. Verify success states and that emails/leads are sent successfully!

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
