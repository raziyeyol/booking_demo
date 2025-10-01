import 'package:booking_demo/features/booking/data/api/booking_api.dart';
import 'package:booking_demo/features/booking/data/mock/mock_data_source.dart';
import 'package:booking_demo/features/booking/domain/entities.dart';
import 'package:booking_demo/features/booking/domain/repositories/booking_repository.dart';
import 'package:booking_demo/core/config/app_config.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingApi api;
  final AppConfig config;
  final _mock = MockDataSource();

  BookingRepositoryImpl({required this.api, required this.config});

  bool get _useMock => config.useMock;

  @override
  Future<List<Service>> getServices() async {
    if (_useMock) {
      print('🔧 Using mock services data');
      return _mock.getServices();
    }
    print('🌐 Fetching services from API: ${config.baseUrl}/v1/services');
    try {
      final services = await api.getServices();
      print('✅ Loaded ${services.length} services from API');
      return services;
    } catch (e) {
      print('❌ Error loading services from API: $e');
      rethrow;
    }
  }

  @override
  Future<List<Staff>> getStaff() async {
    if (_useMock) {
      print('🔧 Using mock staff data');
      return _mock.getStaff();
    }
    print('🌐 Fetching staff from API: ${config.baseUrl}/v1/staff');
    try {
      final staff = await api.getStaff();
      print('✅ Loaded ${staff.length} staff members from API');
      return staff;
    } catch (e) {
      print('❌ Error loading staff from API: $e');
      rethrow;
    }
  }

  @override
  Future<List<Booking>> getBookings() async {
    if (_useMock) {
      print('🔧 Using mock bookings data');
      return _mock.getBookings();
    }
    print('🌐 Fetching bookings from API: ${config.baseUrl}/v1/bookings');
    try {
      final bookings = await api.getBookings();
      print('✅ Loaded ${bookings.length} bookings from API');
      return bookings;
    } catch (e) {
      print('❌ Error loading bookings from API: $e');
      rethrow;
    }
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
