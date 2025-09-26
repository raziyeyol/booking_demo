import 'package:flutter/material.dart';
import 'app.dart';
import 'core/di/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const BookingApp());
}
