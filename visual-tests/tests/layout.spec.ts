import { expect, test, type Page } from '@playwright/test';

const landingURL = 'http://127.0.0.1:4174';
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

  test('landing expanded versions selector', async ({ page }) => {
    await page.addInitScript(() => localStorage.clear());
    await waitForFlutter(page, landingURL);
    await activate(page.getByRole('button', { name: /Portfolio versions and 3D themes/ }));
    await expect(page.getByRole('button', { name: 'Portfolio versions' })).toBeVisible();
    await expect(page.getByRole('button', { name: 'Store Review Room' })).toBeVisible();
    await expectContainedLayout(page);
    await expect(page).toHaveScreenshot('landing-versions-selector.png');
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
