import 'package:booking_demo/core/di/locator.dart';
import 'package:booking_demo/features/booking/domain/entities.dart';
import 'package:booking_demo/features/booking/domain/repositories/booking_repository.dart';
import 'package:booking_demo/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeRepo implements BookingRepository {
  @override
  Future<Booking> createBooking(
      {required String serviceId,
      required String staffId,
      required DateTime start}) async {
    return Booking(
      id: 'b1',
      service:
          Service(id: serviceId, name: 'Cut', minutes: 30, priceCents: 2500),
      staff: Staff(id: staffId, name: staffId),
      slot: TimeSlot(start: start, end: start.add(const Duration(minutes: 30))),
      paymentStatus: 'pending',
    );
  }

  @override
  Future<List<Booking>> getBookings() async => [];

  @override
  Future<List<Service>> getServices() async =>
      [const Service(id: 's1', name: 'Cut', minutes: 30, priceCents: 2500)];

  @override
  Future<Booking> markPaid(String bookingId) async =>
      throw UnimplementedError();

  @override
  Future<List<Staff>> getStaff() async => [const Staff(id: 't1', name: 'Alex')];
}

void main() {
  setUp(() async {
    if (sl.isRegistered<BookingRepository>())
      sl.unregister<BookingRepository>();
    sl.registerLazySingleton<BookingRepository>(() => FakeRepo());
  });

  testWidgets('HomePage shows title and buttons', (tester) async {
    final app = MaterialApp.router(routerConfig: createAppRouter());
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    expect(find.text('Booking Demo'), findsOneWidget);
    expect(find.text('Customer Mode'), findsOneWidget);
    expect(find.text('Admin Dashboard'), findsOneWidget);
  });

  testWidgets('Navigate to bookings and show FAB', (tester) async {
    final app = MaterialApp.router(routerConfig: createAppRouter());
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Customer Mode'));
    await tester.pumpAndSettle();

    expect(find.text('Your Bookings'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
