import 'package:booking_demo/core/di/locator.dart';
import 'package:booking_demo/features/booking/application/booking_bloc.dart';
import 'package:booking_demo/features/booking/domain/repositories/booking_repository.dart';
import 'package:booking_demo/features/booking/presentation/widgets/status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_demo/core/utils/date_formatting.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingBloc(sl<BookingRepository>())..add(LoadInitial()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Admin Dashboard')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<BookingBloc, BookingState>(
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

              return LayoutBuilder(
                builder: (context, constraints) {
                  final minCardWidth = 320.0;
                  final gridCount =
                      (constraints.maxWidth / minCardWidth).floor().clamp(1, 6);
                  final bookings = state.bookings;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridCount,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 3.2,
                    ),
                    itemCount: bookings.length,
                    itemBuilder: (_, i) {
                      final b = bookings[i];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(b.service.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                    const SizedBox(height: 6),
                                    Text(
                                      DateFormatting.range(
                                          b.slot.start, b.slot.end),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    if (b.note.isNotEmpty)
                                      Text('Note: ' + b.note,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              StatusPill(status: b.paymentStatus),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: b.paymentStatus == 'paid'
                                    ? null
                                    : () => context
                                        .read<BookingBloc>()
                                        .add(MarkAsPaid(b.id)),
                                child: const Text('Mark as Paid'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
