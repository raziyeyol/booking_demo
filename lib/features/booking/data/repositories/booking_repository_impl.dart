import 'dart:io';
import 'package:booking_demo/features/booking/data/api/booking_api.dart';
import 'package:booking_demo/features/booking/data/mock/mock_data_source.dart';
import 'package:booking_demo/features/booking/domain/entities.dart';
import 'package:booking_demo/features/booking/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingApi api;
  final _mock = MockDataSource();

  BookingRepositoryImpl({required this.api});

  bool get _useMock => Platform.environment['USE_MOCK'] == 'true';

  @override
  Future<List<Service>> getServices() async {
    if (_useMock) return _mock.getServices();
    return api.getServices();
  }

  @override
  Future<List<Booking>> getBookings() async {
    if (_useMock) return _mock.getBookings();
    return api.getBookings();
  }

  @override
  Future<Booking> createBooking({
    required String serviceId,
    required String staffId,
    required DateTime start,
  }) async {
    if (_useMock) {
      final b = Booking(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        service: _mock.getServices().first,
        staff: const Staff(id: 't1', name: 'Alex'),
        slot:
            TimeSlot(start: start, end: start.add(const Duration(minutes: 30))),
        paymentStatus: 'pending',
      );
      return b;
    }
    return api.createBooking({
      'serviceId': serviceId,
      'staffId': staffId,
      'start': start.toIso8601String(),
    });
  }

  @override
  Future<Booking> markPaid(String bookingId) async {
    if (_useMock) {
      final list = await getBookings();
      final b = list.firstWhere((e) => e.id == bookingId);
      return _mock.markPaid(b);
    }
    return api.markPaid(bookingId);
  }
}
