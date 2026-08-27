import 'package:boonyongyang/shared/services/portfolio_analytics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('classifies portfolio versions and themes without full URLs', () {
    final v2 = PortfolioAnalytics.classifyDestination(
      Uri.parse('https://app.boonyongyang.com'),
    );
    expect(v2.name, PortfolioAnalytics.versionSwitch);
    expect(v2.parameters, const {'target': 'v2'});

    final theme = PortfolioAnalytics.classifyDestination(
      Uri.parse('https://3d.boonyongyang.com/themes/field-manual/'),
    );
    expect(theme.name, PortfolioAnalytics.themeSwitch);
    expect(theme.parameters, const {'target': 'field-manual'});
  });

  test('classifies contact, profiles, and project destinations', () {
    expect(
      PortfolioAnalytics.classifyDestination(
        Uri.parse('mailto:boonyongyang@gmail.com'),
      ).name,
      PortfolioAnalytics.contactClick,
    );
    expect(
      PortfolioAnalytics.classifyDestination(
        Uri.parse('https://github.com/boonyongyang'),
      ).parameters,
      const {'profile': 'github'},
    );
    final project = PortfolioAnalytics.classifyDestination(
      Uri.parse('https://apps.apple.com/my/app/example/id1'),
      label: 'Example app',
    );
    expect(project.name, PortfolioAnalytics.projectOpen);
    expect(project.parameters, const {
      'project': 'Example app',
      'target': 'apps.apple.com',
    });
  });
}
