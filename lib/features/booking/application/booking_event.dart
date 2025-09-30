part of 'booking_bloc.dart';

sealed class BookingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadInitial extends BookingEvent {}

class MarkAsPaid extends BookingEvent {
  final String bookingId;
  MarkAsPaid(this.bookingId);
  @override
  List<Object?> get props => [bookingId];
}

class CreateBooking extends BookingEvent {
  final String serviceId;
  final String staffId;
  final DateTime start;
  CreateBooking(
      {required this.serviceId, required this.staffId, required this.start});
  @override
  List<Object?> get props => [serviceId, staffId, start];
}
