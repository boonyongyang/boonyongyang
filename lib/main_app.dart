import 'apps/app_bootstrap.dart';
import 'apps/main_app/main_app.dart';

void main() {
  bootstrapApp(
    app: const MainApp(),
    initializeMainServices: true,
  );
}
