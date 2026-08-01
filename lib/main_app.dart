import 'package:flutter_web_plugins/url_strategy.dart';

import 'apps/app_bootstrap.dart';
import 'apps/main_app/main_app.dart';

void main() {
  usePathUrlStrategy();
  bootstrapApp(
    app: const MainApp(),
    initializeMainServices: true,
  );
}
