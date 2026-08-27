(function () {
  "use strict";

  const script = document.currentScript;
  const measurementId = script?.dataset.measurementId?.trim() || "";
  const version = script?.dataset.version?.trim() || "unknown";
  const theme = script?.dataset.theme?.trim() || "";
  const events = [];
  const allowedParameters = new Set([
    "version",
    "theme",
    "target",
    "project",
    "method",
    "profile",
    "path",
  ]);

  function cleanParameters(parameters) {
    const clean = {};
    for (const [key, value] of Object.entries(parameters || {})) {
      if (!allowedParameters.has(key) || value == null) continue;
      clean[key] = String(value).slice(0, 80);
    }
    return clean;
  }

  function track(name, parameters) {
    if (!/^[a-z][a-z0-9_]{1,39}$/.test(name)) return;
    const detail = {
      name,
      parameters: cleanParameters(parameters),
    };
    events.push(detail);
    window.dispatchEvent(
      new CustomEvent("portfolio:analytics", { detail }),
    );
    if (typeof window.gtag === "function" && /^G-[A-Z0-9]+$/.test(measurementId)) {
      window.gtag("event", name, detail.parameters);
    }
  }

  window.portfolioAnalytics = Object.freeze({ events, track });

  if (/^G-[A-Z0-9]+$/.test(measurementId)) {
    window.dataLayer = window.dataLayer || [];
    window.gtag = function () {
      window.dataLayer.push(arguments);
    };
    window.gtag("consent", "default", {
      ad_personalization: "denied",
      ad_storage: "denied",
      ad_user_data: "denied",
      analytics_storage: "denied",
      functionality_storage: "granted",
      security_storage: "granted",
    });
    window.gtag("js", new Date());
    window.gtag("config", measurementId, {
      allow_google_signals: false,
      anonymize_ip: true,
      send_page_view: false,
    });
    const loader = document.createElement("script");
    loader.async = true;
    loader.src = `https://www.googletagmanager.com/gtag/js?id=${encodeURIComponent(measurementId)}`;
    document.head.appendChild(loader);
  }

  function recordInitialView() {
    track("portfolio_version_view", {
      version,
      path: window.location.pathname,
    });
    if (theme) track("portfolio_theme_view", { version, theme });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", recordInitialView, {
      once: true,
    });
  } else {
    recordInitialView();
  }
})();
