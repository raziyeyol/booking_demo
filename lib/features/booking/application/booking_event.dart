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
