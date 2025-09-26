import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../domain/entities.dart';
import '../domain/repositories/booking_repository.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository repo;
  BookingBloc(this.repo) : super(const BookingState()) {
    on<LoadInitial>(_onLoad);
    on<MarkAsPaid>(_onMarkPaid);
  }

  Future<void> _onLoad(LoadInitial event, Emitter<BookingState> emit) async {
    emit(state.copyWith(loading: true));
    try {
      final bookings = await repo.getBookings();
      final services = await repo.getServices();
      emit(state.copyWith(
          loading: false, bookings: bookings, services: services));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onMarkPaid(MarkAsPaid event, Emitter<BookingState> emit) async {
    try {
      final updated = await repo.markPaid(event.bookingId);
      final newList =
          state.bookings.map((b) => b.id == updated.id ? updated : b).toList();
      emit(state.copyWith(bookings: newList));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
