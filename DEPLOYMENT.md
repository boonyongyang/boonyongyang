# Deployment Configuration

This document explains how to deploy the separated apps to different domains/subdomains.

## Architecture Overview

- **Landing Page**: Lightweight portfolio landing page for main domain (e.g., `yourdomain.com`)
- **Main App**: Full-featured interactive app for subdomain (e.g., `app.yourdomain.com`)

## Build Commands

### Build Landing Page Only
```bash
./build_apps.sh landing
```

### Build Main App Only
```bash
./build_apps.sh app
```

### Build Both Apps
```bash
./build_apps.sh all
```

## Deployment Structure

```
build/
├── landing/          # Deploy to main domain
│   ├── index.html
│   ├── main.dart.js
│   └── assets/
└── app/             # Deploy to app subdomain
    ├── index.html
    ├── main.dart.js
    └── assets/
```

## Deployment Examples

### Static Hosting (Netlify, Vercel, etc.)

1. **Landing Page**: Deploy `build/landing/` to main domain
2. **Main App**: Deploy `build/app/` to subdomain

### Nginx Configuration

```nginx
# Main domain (landing page)
server {
    listen 80;
    server_name yourdomain.com;
    root /var/www/landing;
    
    location / {
        try_files $uri $uri/ /index.html;
    }
}

# App subdomain (main app)
server {
    listen 80;
    server_name app.yourdomain.com;
    root /var/www/app;
    
    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

### Firebase Hosting

```json
{
  "hosting": [
    {
      "site": "yourdomain-landing",
      "public": "build/landing",
      "rewrites": [
        {
          "source": "**",
          "destination": "/index.html"
        }
      ]
    },
    {
      "site": "yourdomain-app",
      "public": "build/app",
      "rewrites": [
        {
          "source": "**",
          "destination": "/index.html"
        }
      ]
    }
  ]
}
```

## Development

### Run Landing Page
```bash
flutter run -d chrome --target=lib/main_landing.dart
```

### Run Main App
```bash
flutter run -d chrome --target=lib/main_app.dart
```

## Environment Variables

You can customize the build using environment variables:

- `APP_MODE`: Set to 'landing' or 'main_app'
- `BASE_URL`: Base URL for the app
- `API_URL`: API endpoint URL

## Hot Reload Fix

The hot reload issue you mentioned earlier is now resolved because the apps are completely separated. Each app maintains its own state and routing configuration.
