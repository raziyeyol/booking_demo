import '../entities.dart';

abstract class BookingRepository {
  Future<List<Service>> getServices();
  Future<List<Staff>> getStaff();
  Future<List<Booking>> getBookings();
  Future<Booking> createBooking({
    required String serviceId,
    required String staffId,
    required DateTime start,
  });
  Future<Booking> markPaid(String bookingId);
}
