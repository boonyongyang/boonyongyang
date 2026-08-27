import 'portfolio_analytics_stub.dart'
    if (dart.library.js_interop) 'portfolio_analytics_web.dart' as platform;

typedef PortfolioAnalyticsAction = ({
  String name,
  Map<String, Object?> parameters,
});

abstract final class PortfolioAnalytics {
  static const versionView = 'portfolio_version_view';
  static const themeView = 'portfolio_theme_view';
  static const versionSwitch = 'portfolio_version_switch';
  static const themeSwitch = 'portfolio_theme_switch';
  static const projectOpen = 'project_open';
  static const contactClick = 'contact_click';
  static const externalProfileClick = 'external_profile_click';

  static void track(String name, [Map<String, Object?> parameters = const {}]) {
    platform.trackPortfolioEvent(name, parameters);
  }

  static PortfolioAnalyticsAction classifyDestination(
    Uri destination, {
    String? label,
  }) {
    if (destination.scheme == 'mailto') {
      return (
        name: contactClick,
        parameters: const {'method': 'email'},
      );
    }

    final path = destination.path.toLowerCase();
    if (destination.host == 'boonyongyang.com') {
      return (
        name: versionSwitch,
        parameters: const {'target': 'v1'},
      );
    }
    if (destination.host == 'app.boonyongyang.com') {
      return (
        name: versionSwitch,
        parameters: const {'target': 'v2'},
      );
    }
    if (destination.host == '3d.boonyongyang.com') {
      if (path.contains('/themes/')) {
        final theme = path.split('/').where((part) => part.isNotEmpty).last;
        return (
          name: themeSwitch,
          parameters: {'target': theme},
        );
      }
      return (
        name: versionSwitch,
        parameters: const {'target': 'v3'},
      );
    }
    if (destination.host == 'v4.boonyongyang.com' ||
        destination.host == 'boonyongyang-v4.web.app') {
      return (
        name: versionSwitch,
        parameters: const {'target': 'v4'},
      );
    }
    if (destination.host.contains('github.com')) {
      return (
        name: externalProfileClick,
        parameters: const {'profile': 'github'},
      );
    }
    if (destination.host.contains('linkedin.com')) {
      return (
        name: externalProfileClick,
        parameters: const {'profile': 'linkedin'},
      );
    }

    return (
      name: projectOpen,
      parameters: {
        if (label != null && label.isNotEmpty) 'project': label,
        'target': destination.host,
      },
    );
  }

  static void trackDestination(Uri destination, {String? label}) {
    final action = classifyDestination(destination, label: label);
    track(action.name, action.parameters);
  }
}
