import 'package:booking_demo/features/booking/data/api/booking_api.dart';
import 'package:booking_demo/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:booking_demo/features/booking/domain/repositories/booking_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../config/app_config.dart';
import '../telemetry/error_reporter.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  final config = AppConfig.fromEnvironment();
  sl.registerSingleton<AppConfig>(config);

  final dio = Dio(BaseOptions(
    baseUrl: config.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      return handler.next(options);
    },
    onError: (e, handler) async {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        try {
          final clone = await dio.fetch(e.requestOptions);
          return handler.resolve(clone);
        } catch (_) {}
      }
      return handler.next(e);
    },
  ));

  sl.registerLazySingleton<Dio>(() => dio);
  sl.registerLazySingleton<BookingApi>(() => BookingApi(sl<Dio>()));
  sl.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(api: sl<BookingApi>(), config: sl<AppConfig>()),
  );

  const sentryDsn = String.fromEnvironment('SENTRY_DSN', defaultValue: '');
  if (sentryDsn.isNotEmpty) {
    final reporter = await SentryErrorReporter.init(sentryDsn);
    sl.registerSingleton<ErrorReporter>(reporter);
  } else {
    sl.registerSingleton<ErrorReporter>(NoopErrorReporter());
  }
}
