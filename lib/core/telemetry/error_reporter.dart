import 'package:sentry_flutter/sentry_flutter.dart';

abstract class ErrorReporter {
  Future<void> report(dynamic error,
      {StackTrace? stackTrace, Map<String, String>? tags});
}

class SentryErrorReporter implements ErrorReporter {
  final String dsn;
  SentryErrorReporter(this.dsn);

  static Future<SentryErrorReporter> init(String dsn) async {
    await SentryFlutter.init((options) {
      options.dsn = dsn;
      options.tracesSampleRate = 1.0;
    });
    return SentryErrorReporter(dsn);
  }

  @override
  Future<void> report(dynamic error,
      {StackTrace? stackTrace, Map<String, String>? tags}) async {
    await Sentry.captureException(error, stackTrace: stackTrace,
        withScope: (scope) {
      tags?.forEach((k, v) => scope.setTag(k, v));
    });
  }
}

class NoopErrorReporter implements ErrorReporter {
  @override
  Future<void> report(dynamic error,
      {StackTrace? stackTrace, Map<String, String>? tags}) async {}
}
