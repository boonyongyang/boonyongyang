import { readFile } from 'node:fs/promises';

const surfaces = [
  {
    name: 'landing',
    output: 'build/landing',
    origin: 'https://boonyongyang.com',
    version: 'v1',
    schema: 'ProfilePage'
  },
  {
    name: 'interactive app',
    output: 'build/app',
    origin: 'https://app.boonyongyang.com',
    version: 'v2',
    schema: 'WebApplication'
  }
];

for (const surface of surfaces) {
  const [html, robots, sitemap, analytics, application] = await Promise.all([
    readFile(`${surface.output}/index.html`, 'utf8'),
    readFile(`${surface.output}/robots.txt`, 'utf8'),
    readFile(`${surface.output}/sitemap.xml`, 'utf8'),
    readFile(`${surface.output}/portfolio-analytics.js`, 'utf8'),
    readFile(`${surface.output}/main.dart.js`, 'utf8')
  ]);
  const requiredHtml = [
    `<link rel="canonical" href="${surface.origin}/">`,
    `data-version="${surface.version}"`,
    'data-measurement-id=""',
    'type="application/ld+json"',
    surface.schema
  ];
  for (const marker of requiredHtml) {
    if (!html.includes(marker)) throw new Error(`${surface.name} HTML is missing ${marker}.`);
  }
  if (html.includes('name="google-site-verification"')) {
    throw new Error(`${surface.name} contains an empty Search Console verification tag.`);
  }
  if (!robots.includes(`Sitemap: ${surface.origin}/sitemap.xml`)) {
    throw new Error(`${surface.name} robots.txt uses the wrong sitemap origin.`);
  }
  if (!sitemap.includes(`<loc>${surface.origin}/</loc>`)) {
    throw new Error(`${surface.name} sitemap uses the wrong canonical origin.`);
  }
  for (const event of [
    'portfolio_version_view',
    'portfolio_version_switch',
    'portfolio_theme_switch',
    'project_open',
    'contact_click',
    'external_profile_click'
  ]) {
    if (!analytics.includes(event) && !html.includes(event) && !application.includes(event)) {
      throw new Error(`${surface.name} is missing analytics event ${event}.`);
    }
  }
  if (!application.includes('https://v6.boonyongyang.com')) {
    throw new Error(`${surface.name} is missing the V6 canonical destination.`);
  }
  if (/__(?:PORTFOLIO_ORIGIN|PORTFOLIO_VERSION|ANALYTICS_MEASUREMENT_ID|GOOGLE_SITE_VERIFICATION)__/.test(html)) {
    throw new Error(`${surface.name} contains an unresolved production marker.`);
  }
}

console.log('Flutter web metadata, discovery, and analytics contracts passed.');
