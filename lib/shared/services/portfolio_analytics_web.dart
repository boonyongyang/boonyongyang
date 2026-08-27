import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:web/web.dart' as web;

void trackPortfolioEvent(String name, Map<String, Object?> parameters) {
  final analytics = web.window.getProperty<JSObject?>(
    'portfolioAnalytics'.toJS,
  );
  analytics?.callMethod<JSAny?>(
    'track'.toJS,
    name.toJS,
    parameters.jsify(),
  );
}
