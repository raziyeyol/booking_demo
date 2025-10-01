import 'package:freezed_annotation/freezed_annotation.dart';

part 'entities.freezed.dart';
part 'entities.g.dart';

@freezed
class Service with _$Service {
  const factory Service({
    required String id,
    required String name,
    required int minutes,
    required int priceCents,
    @Default(false) bool popular,
  }) = _Service;

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
}

@freezed
class Staff with _$Staff {
  const factory Staff({
    required String id,
    required String name,
  }) = _Staff;

  factory Staff.fromJson(Map<String, dynamic> json) => _$StaffFromJson(json);
}

@freezed
class TimeSlot with _$TimeSlot {
  const factory TimeSlot({
    required DateTime start,
    required DateTime end,
  }) = _TimeSlot;

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);
}

sealed class PaymentStatus {
  const PaymentStatus();
}

class Paid extends PaymentStatus {
  const Paid();
}

class Pending extends PaymentStatus {
  const Pending();
}

class Failed extends PaymentStatus {
  final String reason;
  const Failed(this.reason);
}

class Refunded extends PaymentStatus {
  const Refunded();
}

@freezed
class Booking with _$Booking {
  const factory Booking({
    required String id,
    required Service service,
    required Staff staff,
    required TimeSlot slot,
    @Default('') String note,
    @Default('pending')
    String paymentStatus, // 'paid' | 'pending' | 'failed' | 'refunded'
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> json) {
    // Transform API response to match our entity structure
    return Booking(
      id: json['id'] as String,
      service: Service.fromJson(json['service'] as Map<String, dynamic>),
      staff: Staff.fromJson(json['staff'] as Map<String, dynamic>),
      slot: TimeSlot(
        start: DateTime.parse(json['startAt'] as String),
        end: DateTime.parse(json['endAt'] as String),
      ),
      note: json['note'] as String? ?? '',
      paymentStatus: json['paymentStatus'] as String? ?? 'pending',
    );
  }
}
