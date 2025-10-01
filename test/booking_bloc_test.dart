import 'package:booking_demo/features/booking/application/booking_bloc.dart';
import 'package:booking_demo/features/booking/domain/entities.dart';
import 'package:booking_demo/features/booking/domain/repositories/booking_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeRepo implements BookingRepository {
  List<Service> services = [
    const Service(id: 's1', name: 'Cut', minutes: 30, priceCents: 2500)
  ];
  List<Booking> bookings = [];

  @override
  Future<Booking> createBooking(
      {required String serviceId,
      required String staffId,
      required DateTime start}) async {
    final b = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      service: services.firstWhere((s) => s.id == serviceId),
      staff: Staff(id: staffId, name: staffId),
      slot: TimeSlot(start: start, end: start.add(const Duration(minutes: 30))),
      paymentStatus: 'pending',
    );
    bookings.insert(0, b);
    return b;
  }

  @override
  Future<List<Booking>> getBookings() async => List.of(bookings);

  @override
  Future<List<Service>> getServices() async => services;

  @override
  Future<Booking> markPaid(String bookingId) async {
    bookings = bookings
        .map((b) => b.id == bookingId ? b.copyWith(paymentStatus: 'paid') : b)
        .toList();
    return bookings.firstWhere((b) => b.id == bookingId);
  }

  @override
  Future<List<Staff>> getStaff() async => [
        const Staff(id: 't1', name: 'Alex'),
        const Staff(id: 't2', name: 'Sarah'),
      ];
}

Future<void> waitUntilLoaded(BookingBloc bloc) async {
  // Poll until loading becomes false
  while (bloc.state.loading) {
    await Future.delayed(const Duration(milliseconds: 1));
  }
}

void main() {
  test('load initial loads services and bookings', () async {
    final repo = FakeRepo();
    repo.bookings = [];
    final bloc = BookingBloc(repo);

    bloc.add(LoadInitial());
    await Future.delayed(const Duration(milliseconds: 1));
    await waitUntilLoaded(bloc);

    expect(bloc.state.loading, false);
    expect(bloc.state.services.isNotEmpty, true);
  });

  test('create booking adds to list', () async {
    final repo = FakeRepo();
    final bloc = BookingBloc(repo);
    bloc.add(LoadInitial());
    await Future.delayed(const Duration(milliseconds: 1));
    await waitUntilLoaded(bloc);

    final start = DateTime.now().add(const Duration(hours: 1));
    bloc.add(CreateBooking(serviceId: 's1', staffId: 't1', start: start));
    await Future.delayed(const Duration(milliseconds: 5));

    expect(bloc.state.bookings.length, 1);
    expect(bloc.state.bookings.first.service.name, 'Cut');
  });

  test('mark as paid updates booking', () async {
    final repo = FakeRepo();
    final start = DateTime.now().add(const Duration(hours: 1));
    final created =
        await repo.createBooking(serviceId: 's1', staffId: 't1', start: start);
    final bloc = BookingBloc(repo);
    bloc.add(LoadInitial());
    await Future.delayed(const Duration(milliseconds: 1));
    await waitUntilLoaded(bloc);

    bloc.add(MarkAsPaid(created.id));
    await Future.delayed(const Duration(milliseconds: 5));

    expect(bloc.state.bookings.first.paymentStatus, 'paid');
  });
}
