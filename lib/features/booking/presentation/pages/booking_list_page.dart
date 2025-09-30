import 'package:booking_demo/core/di/locator.dart';
import 'package:booking_demo/features/booking/application/booking_bloc.dart';
import 'package:booking_demo/features/booking/domain/repositories/booking_repository.dart';
import 'package:booking_demo/features/booking/presentation/widgets/status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_demo/core/utils/date_formatting.dart';
import 'package:go_router/go_router.dart';

class BookingListPage extends StatelessWidget {
  const BookingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingBloc(sl<BookingRepository>())..add(LoadInitial()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Your Bookings')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.go('/bookings/new'),
          icon: const Icon(Icons.add),
          label: const Text('New Booking'),
        ),
        body: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Error: ' + state.error!),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<BookingBloc>().add(LoadInitial()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            if (state.bookings.isEmpty) {
              return const _EmptyState();
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<BookingBloc>().add(LoadInitial());
                await Future.delayed(const Duration(milliseconds: 300));
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.bookings.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final b = state.bookings[i];
                  return ListTile(
                    title: Text(b.service.name),
                    subtitle:
                        Text(DateFormatting.range(b.slot.start, b.slot.end)),
                    trailing: StatusPill(status: b.paymentStatus),
                  );
                },
              ),
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
            'No bookings yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text('Create a new booking to get started.'),
        ],
      ),
    );
  }
}
