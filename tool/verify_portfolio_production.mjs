const timeoutMs = 20_000;
const userAgent = 'boonyongyang-portfolio-production-smoke/1.0';

const routes = [
  ['Landing custom', 'https://boonyongyang.com/'],
  ['Landing fallback', 'https://boonyongyang.web.app/'],
  ['Interactive app custom', 'https://app.boonyongyang.com/'],
  ['Interactive app fallback', 'https://boonyongyang-app.web.app/'],
  ['3D custom', 'https://3d.boonyongyang.com/'],
  ['3D Release Bench', 'https://3d.boonyongyang.com/themes/release-bench/'],
  ['3D Field Manual', 'https://3d.boonyongyang.com/themes/field-manual/'],
  ['3D Store Review Room', 'https://3d.boonyongyang.com/themes/review-room/'],
  ['3D fallback', 'https://boonyongyang-3d.web.app/'],
  ['V4 Release Dossier', 'https://boonyongyang-v4.web.app/']
];

const request = async (url, options = {}) => {
  const response = await fetch(url, {
    ...options,
    headers: { 'user-agent': userAgent, ...options.headers },
    signal: AbortSignal.timeout(timeoutMs)
  });
  return response;
};

const expectStatus = async (label, url, expected = 200) => {
  const response = await request(url);
  if (response.status !== expected) {
    throw new Error(`${label}: expected HTTP ${expected}, received ${response.status} from ${url}`);
  }
  console.log(`PASS ${response.status} ${label}`);
};

const expectRedirect = async (url) => {
  const response = await request(url, { redirect: 'manual' });
  const location = response.headers.get('location');
  if (response.status !== 301 || location !== 'https://3d.boonyongyang.com') {
    throw new Error(
      `Legacy redirect: expected 301 to https://3d.boonyongyang.com, received ${response.status} to ${location}`
    );
  }
  console.log(`PASS 301 Legacy redirect ${url}`);
};

const expectContent = async (label, url, requiredValues) => {
  const response = await request(url);
  if (response.status !== 200) {
    throw new Error(`${label}: expected HTTP 200, received ${response.status}`);
  }
  const body = await response.text();
  for (const value of requiredValues) {
    if (!body.includes(value)) {
      throw new Error(`${label}: missing ${value}`);
    }
  }
  console.log(`PASS content ${label}`);
};

try {
  for (const [label, url] of routes) {
    await expectStatus(label, url);
  }

  await expectRedirect('https://boonyongyang-portfolio-3d.web.app/');
  await expectRedirect('https://boonyongyang-portfolio-3d.web.app/unknown-path');

  await expectContent('3D metadata and navigation', 'https://3d.boonyongyang.com/', [
    'https://3d.boonyongyang.com',
    'https://app.boonyongyang.com',
    'Release Bench',
    '/themes/field-manual/',
    '/themes/review-room/'
  ]);
  await expectContent('3D robots', 'https://3d.boonyongyang.com/robots.txt', [
    'Host: https://3d.boonyongyang.com',
    'Sitemap: https://3d.boonyongyang.com/sitemap.xml'
  ]);
  await expectContent('3D sitemap', 'https://3d.boonyongyang.com/sitemap.xml', [
    'https://3d.boonyongyang.com/themes/release-bench/',
    'https://3d.boonyongyang.com/themes/field-manual/',
    'https://3d.boonyongyang.com/themes/review-room/'
  ]);
  await expectContent('V4 version navigation', 'https://boonyongyang-v4.web.app/', [
    'https://app.boonyongyang.com',
    'https://3d.boonyongyang.com/themes/release-bench/',
    'https://3d.boonyongyang.com/themes/field-manual/',
    'https://3d.boonyongyang.com/themes/review-room/'
  ]);
  await expectContent('Landing version navigation', 'https://boonyongyang.web.app/main.dart.js', [
    'https://app.boonyongyang.com',
    'https://3d.boonyongyang.com'
  ]);
  await expectContent('Interactive app version navigation', 'https://boonyongyang-app.web.app/main.dart.js', [
    'https://app.boonyongyang.com',
    'https://3d.boonyongyang.com'
  ]);

  console.log(`Production smoke passed: ${routes.length} routes, 2 redirects, and 6 content contracts.`);
} catch (error) {
  console.error(`FAIL ${error instanceof Error ? error.message : error}`);
  process.exitCode = 1;
}
