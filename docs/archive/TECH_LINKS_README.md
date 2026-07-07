# Technology Links Configuration

The landing page technology chips are now clickable and link to relevant websites. All links are centrally managed in the `_techLinks` constant in `lib/apps/landing/pages/landing_page.dart`.

## How to Edit Links

To add, remove, or modify technology links, edit the `_techLinks` map at the top of the `_LandingPageState` class:

```dart
static const Map<String, String> _techLinks = {
  // Example entries:
  'Flutter': 'https://flutter.dev',
  'UXCam': 'https://uxcam.com',
  'Singular': 'https://www.singular.net',
  // Add more links here...
};
```

## Features

- **Clickable chips**: Technologies with links are clickable and show a small external link icon
- **Visual feedback**: Linked chips have slightly different styling (darker background, border)
- **Mouse cursor**: Cursor changes to pointer when hovering over clickable chips
- **Centralized management**: All links in one place for easy editing

## Adding New Technology Links

1. Open `lib/apps/landing/pages/landing_page.dart`
2. Find the `_techLinks` map (around line 19)
3. Add your new entry: `'Technology Name': 'https://website.com'`
4. The chip will automatically become clickable

## Current Categories

The links are organized by technology categories:
- Mobile Development (Flutter, Dart, iOS, Android, etc.)
- State Management & Architecture
- Dependency Injection & Navigation
- Networking & Data
- Testing & DevTools
- CI/CD & Deployment
- Firebase & Analytics
- Third-party Integrations (UXCam, Singular, etc.)
- UI/UX & Animation
- Backend Technologies
- Cloud & Storage
- Web Technologies
- Monitoring & Performance

## Notes

- If a technology doesn't have a link in the `_techLinks` map, it will still display but won't be clickable
- Links open in a new tab/window
- All external link icons are automatically added to linked chips
