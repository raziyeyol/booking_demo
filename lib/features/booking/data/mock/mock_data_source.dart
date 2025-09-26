import 'dart:math';

import 'package:booking_demo/features/booking/domain/entities.dart';

class MockDataSource {
  final _rng = Random(42);

  List<Service> getServices() => [
        Service(
            id: 's1',
            name: 'Haircut',
            minutes: 30,
            priceCents: 2500,
            popular: true),
        Service(id: 's2', name: 'Coloring', minutes: 60, priceCents: 6000),
      ];

  List<Booking> getBookings() {
    final services = getServices();
    return List.generate(5, (i) {
      final start = DateTime.now().add(Duration(days: i, hours: i + 9));
      final slot = TimeSlot(
          start: start, end: start.add(Duration(minutes: 30 + 15 * (i % 3))));
      return Booking(
        id: 'b$i',
        service: services[i % services.length],
        staff: Staff(id: 't1', name: 'Alex'),
        slot: slot,
        note: i.isEven ? 'First-time visitor' : '',
        paymentStatus: i.isEven ? 'paid' : 'pending',
      );
    });
  }

  Booking markPaid(Booking b) => b.copyWith(paymentStatus: 'paid');
}
