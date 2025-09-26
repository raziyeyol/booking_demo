import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:booking_demo/features/booking/domain/entities.dart';

part 'booking_api.g.dart';

@RestApi()
abstract class BookingApi {
  factory BookingApi(Dio dio, {String baseUrl}) = _BookingApi;

  @GET('/services')
  Future<List<Service>> getServices();

  @GET('/bookings')
  Future<List<Booking>> getBookings();

  @POST('/bookings')
  Future<Booking> createBooking(@Body() Map<String, dynamic> body);

  @POST('/bookings/{id}/mark-paid')
  Future<Booking> markPaid(@Path('id') String id);
}
