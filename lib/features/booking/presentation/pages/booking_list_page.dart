import 'package:booking_demo/core/di/locator.dart';
import 'package:booking_demo/features/booking/application/booking_bloc.dart';
import 'package:booking_demo/features/booking/domain/repositories/booking_repository.dart';
import 'package:booking_demo/features/booking/presentation/widgets/status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingListPage extends StatelessWidget {
  const BookingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingBloc(sl<BookingRepository>())..add(LoadInitial()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Your Bookings')),
        body: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(child: Text('Error: ${state.error}'));
            }
            if (state.bookings.isEmpty) {
              return const _EmptyState();
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.bookings.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) {
                final b = state.bookings[i];
                return ListTile(
                  title: Text(b.service.name),
                  subtitle: Text('${b.slot.start} - ${b.slot.end}'),
                  trailing: StatusPill(status: b.paymentStatus),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.inbox, size: 64),
          const SizedBox(height: 12),
          Text(
            'Hiç randevunuz yok',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text('Yeni bir randevu oluşturmayı deneyin.'),
        ],
      ),
    );
  }
}
