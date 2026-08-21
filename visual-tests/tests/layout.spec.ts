import { expect, test, type Locator, type Page } from '@playwright/test';

const landingURL = process.env.LANDING_URL ?? 'http://127.0.0.1:4174';
const appURL = 'http://127.0.0.1:4175';

async function waitForFlutter(page: Page, url: string) {
  await page.goto(url);
  await expect(page.locator('flt-glass-pane')).toHaveCount(1, { timeout: 30_000 });
  await expect(page.getByRole('button', { name: 'Enable accessibility' })).toBeVisible();
  await page.getByRole('button', { name: 'Enable accessibility' }).evaluate((element) => (element as HTMLElement).click());
  await expect(page.locator('flt-semantics')).not.toHaveCount(0, { timeout: 10_000 });
  await page.waitForTimeout(500);
}

async function expectContainedLayout(page: Page) {
  const layout = await page.evaluate(() => ({
    clientHeight: document.documentElement.clientHeight,
    clientWidth: document.documentElement.clientWidth,
    scrollWidth: document.documentElement.scrollWidth
  }));
  expect(layout.scrollWidth).toBeLessThanOrEqual(layout.clientWidth);
}

async function activate(locator: ReturnType<Page['locator']>) {
  await locator.evaluate((element) => (element as HTMLElement).click());
}

async function scrollFlutterLocatorIntoView(page: Page, locator: Locator) {
  const viewport = page.viewportSize();
  if (!viewport) throw new Error('Expected a configured viewport');

  await page.mouse.move(viewport.width / 2, viewport.height / 2);
  for (let attempt = 0; attempt < 12; attempt += 1) {
    await page.mouse.wheel(0, viewport.height * 0.72);
    await page.waitForTimeout(120);
    const box = await locator.boundingBox();
    if (box && box.y >= 80 && box.y + box.height <= viewport.height * 0.55) return;
  }
}

test.describe('Flutter deployment layout baselines', () => {
  test.describe.configure({ retries: 0 });

  test.beforeEach(async ({}, testInfo) => {
    testInfo.snapshotSuffix = process.platform;
  });

  for (const preset of [
    { label: 'Studio Light', snapshot: 'landing-studio-light.png', storage: null },
    { label: 'Midnight Zinc', snapshot: 'landing-midnight-zinc.png', storage: 'midnightZinc' },
    { label: 'Signal Amber', snapshot: 'landing-signal-amber.png', storage: 'signalAmber' }
  ]) {
    test(`landing ${preset.label}`, async ({ page }) => {
      await page.addInitScript((storage) => {
        localStorage.clear();
        if (storage) localStorage.setItem('landing_theme_preset', storage);
      }, preset.storage);
      await waitForFlutter(page, landingURL);
      await expectContainedLayout(page);
      await expect(page).toHaveScreenshot(preset.snapshot);
    });
  }

  test('landing expanded versions selector', async ({ page }, testInfo) => {
    await page.addInitScript(() => localStorage.clear());
    await waitForFlutter(page, landingURL);
    await activate(page.getByRole('button', { name: /Portfolio versions and 3D themes/ }));
    await expect(page.getByRole('button', { name: 'Portfolio versions' })).toBeVisible();
    await expect(page.getByRole('button', { name: 'V4 Release Dossier' })).toBeVisible();
    await expect(page.getByRole('button', { name: 'Store Review Room' })).toBeVisible();
    await expectContainedLayout(page);
    await page.screenshot({ path: testInfo.outputPath('landing-versions-selector-proof.png') });
    await expect(page).toHaveScreenshot('landing-versions-selector.png', {
      maxDiffPixelRatio: 0.001,
    });
  });

  test('landing real product evidence', async ({ page }, testInfo) => {
    await page.addInitScript(() => localStorage.clear());
    await waitForFlutter(page, landingURL);

    const evidenceHeading = page.getByText('Real product screens').first();
    await scrollFlutterLocatorIntoView(page, evidenceHeading);
    await page.waitForTimeout(500);

    await expect(evidenceHeading).toBeInViewport();
    await expect(page.getByRole('img', { name: /Involve Asia mobile overview/ })).toBeVisible();
    await expect(page.getByRole('img', { name: /Involve Asia brand discovery/ })).toBeVisible();
    await expectContainedLayout(page);
    await page.screenshot({ path: testInfo.outputPath('landing-product-evidence-proof.png') });
    await expect(page).toHaveScreenshot('landing-product-evidence.png', {
      maxDiffPixelRatio: 0.001,
    });
  });

  test('landing product evidence responsive matrix', async ({ page }, testInfo) => {
    test.skip(testInfo.project.name !== 'desktop', 'One browser project owns the width matrix');
    await page.addInitScript(() => localStorage.clear());

    for (const viewport of [
      { width: 320, height: 568 },
      { width: 390, height: 844 },
      { width: 768, height: 1024 },
      { width: 1024, height: 768 },
      { width: 1440, height: 900 },
      { width: 1920, height: 1080 }
    ]) {
      await page.setViewportSize(viewport);
      await page.goto('about:blank');
      await waitForFlutter(page, landingURL);
      const images = [
        page.getByRole('img', { name: /Involve Asia mobile overview/ }),
        page.getByRole('img', { name: /Involve Asia brand discovery/ }),
        page.getByRole('img', { name: /Cashiu shopping screen/ }),
        page.getByRole('img', { name: /Cashiu referral rewards/ })
      ];

      for (const image of images) {
        await expect(image).toBeVisible();
        const box = await image.boundingBox();
        expect(box).not.toBeNull();
        expect(box!.x).toBeGreaterThanOrEqual(0);
        expect(box!.x + box!.width).toBeLessThanOrEqual(viewport.width);
      }
      await expectContainedLayout(page);
    }
  });

  for (const route of [
    { path: '/', snapshot: 'interactive-home.png', timeout: 15_000 },
    { path: '/plays/connect4', snapshot: 'interactive-connect4.png', timeout: 5_000 }
  ]) {
    test(`interactive app ${route.path}`, async ({ page }) => {
      await waitForFlutter(page, `${appURL}${route.path}`);
      await expectContainedLayout(page);
      await expect(page).toHaveScreenshot(route.snapshot, { timeout: route.timeout });
    });
  }
});
