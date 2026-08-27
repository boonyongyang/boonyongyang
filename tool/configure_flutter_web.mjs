import { readFile, writeFile } from 'node:fs/promises';
import { resolve } from 'node:path';

const [outputArgument, originArgument, version, measurementId = '', googleVerification = ''] = process.argv.slice(2);

if (!outputArgument || !originArgument || !/^v[1-4]$/.test(version ?? '')) {
  throw new Error(
    'Usage: node tool/configure_flutter_web.mjs <output> <origin> <version> [measurement-id] [google-verification]'
  );
}

const output = resolve(outputArgument);
const origin = new URL(originArgument);
origin.pathname = '/';
origin.search = '';
origin.hash = '';
const canonicalOrigin = origin.toString().replace(/\/$/, '');

if (measurementId && !/^G-[A-Z0-9]+$/.test(measurementId)) {
  throw new Error('ANALYTICS_MEASUREMENT_ID must be empty or a GA4 ID such as G-ABC123.');
}
if (googleVerification && !/^[A-Za-z0-9_-]{10,100}$/.test(googleVerification)) {
  throw new Error('GOOGLE_SITE_VERIFICATION contains unsupported characters.');
}

const indexPath = resolve(output, 'index.html');
let html = await readFile(indexPath, 'utf8');
const replacements = new Map([
  ['__PORTFOLIO_ORIGIN__', canonicalOrigin],
  ['__PORTFOLIO_VERSION__', version],
  ['__ANALYTICS_MEASUREMENT_ID__', measurementId],
  ['__GOOGLE_SITE_VERIFICATION__', googleVerification]
]);

for (const [marker, value] of replacements) {
  html = html.replaceAll(marker, value);
}

if (!googleVerification) {
  html = html.replace(/<meta\s+name="google-site-verification"\s+content=""\s*\/?>/g, '');
}

if (/__(?:PORTFOLIO_ORIGIN|PORTFOLIO_VERSION|ANALYTICS_MEASUREMENT_ID|GOOGLE_SITE_VERIFICATION)__/.test(html)) {
  throw new Error(`Unresolved production marker remains in ${indexPath}.`);
}

await writeFile(indexPath, html);
await writeFile(
  resolve(output, 'robots.txt'),
  `User-agent: *\nAllow: /\nSitemap: ${canonicalOrigin}/sitemap.xml\n`
);
await writeFile(
  resolve(output, 'sitemap.xml'),
  `<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n  <url><loc>${canonicalOrigin}/</loc><changefreq>monthly</changefreq><priority>1.0</priority></url>\n</urlset>\n`
);

console.log(`Configured ${version} metadata and discovery files for ${canonicalOrigin}.`);
