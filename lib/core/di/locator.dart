import 'package:booking_demo/features/booking/data/api/booking_api.dart';
import 'package:booking_demo/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:booking_demo/features/booking/domain/repositories/booking_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  sl.registerLazySingleton<Dio>(() => Dio(BaseOptions(
        baseUrl: 'https://example.com/api',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
      )));

  sl.registerLazySingleton<BookingApi>(() => BookingApi(sl<Dio>()));

  sl.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(api: sl<BookingApi>()),
  );
}
