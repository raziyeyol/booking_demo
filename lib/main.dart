import 'package:flutter/material.dart';
import 'dart:async';
import 'app.dart';
import 'core/di/locator.dart';
import 'core/telemetry/error_reporter.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
    final reporter = sl<ErrorReporter>();
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      reporter.report(details.exception, stackTrace: details.stack);
    };
    runApp(const BookingApp());
  }, (error, stack) {
    // We cannot access GetIt safely if setup failed; ignore if not ready
    try {
      final reporter = sl<ErrorReporter>();
      reporter.report(error, stackTrace: stack);
    } catch (_) {}
  });
}
