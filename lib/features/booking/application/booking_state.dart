part of 'booking_bloc.dart';

class BookingState extends Equatable {
  final bool loading;
  final String? error;
  final List<Booking> bookings;
  final List<Service> services;

  const BookingState({
    this.loading = false,
    this.error,
    this.bookings = const [],
    this.services = const [],
  });

  BookingState copyWith({
    bool? loading,
    String? error,
    List<Booking>? bookings,
    List<Service>? services,
  }) =>
      BookingState(
        loading: loading ?? this.loading,
        error: error,
        bookings: bookings ?? this.bookings,
        services: services ?? this.services,
      );

  @override
  List<Object?> get props => [loading, error, bookings, services];
}
