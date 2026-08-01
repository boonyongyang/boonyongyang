import 'package:boonyongyang/apps/landing/config/quick_config.dart';
import 'package:boonyongyang/apps/landing/models/project_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('public portfolio copy uses durable proof and current product names',
      () {
    final visibleCopy = [
      QuickConfig.workDuration,
      QuickConfig.achievementBanner,
      QuickConfig.mainAppMetrics,
      ...ProjectModel.getProductionApps().expand(
        (project) => [
          project.title,
          project.description,
          project.metrics,
          ...project.achievements,
        ],
      ),
    ].join(' ');

    expect(visibleCopy, isNot(contains('50K+')));
    expect(visibleCopy, isNot(contains('4.2')));
    expect(visibleCopy, isNot(contains('3.5 months')));
    expect(visibleCopy, isNot(contains('Built from scratch')));
    expect(visibleCopy, contains('Cashiu: Everyday cashback'));
    expect(QuickConfig.workDuration, 'June 2023 to Present');
    expect(QuickConfig.copyrightYear, '2026');
  });

  test('public projects and store listings use canonical destinations', () {
    final projects = ProjectModel.getPersonalProjects();
    final starter = projects.singleWhere(
      (project) => project.title == 'Flutter BLoC Starter Kit',
    );
    final cashiu = QuickConfig.storeLinksForProject(
      'Cashiu: Everyday cashback',
    );

    expect(
      starter.githubUrl,
      'https://github.com/boonyongyang/flutter_bloc_starter_kit',
    );
    expect(
      cashiu.appStore,
      'https://apps.apple.com/my/app/cashiu-everyday-cashback/id6745090543',
    );
    expect(
      cashiu.playStore,
      'https://play.google.com/store/apps/details?id=com.cmv.chaching&hl=en&gl=MY',
    );
  });
}
