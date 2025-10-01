import 'package:booking_demo/core/di/locator.dart';
import 'package:booking_demo/features/booking/application/booking_bloc.dart';
import 'package:booking_demo/features/booking/domain/repositories/booking_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateBookingPage extends StatefulWidget {
  const CreateBookingPage({super.key});

  @override
  State<CreateBookingPage> createState() => _CreateBookingPageState();
}

class _CreateBookingPageState extends State<CreateBookingPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedServiceId;
  String? _selectedStaffId;
  DateTime? _start;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingBloc(sl<BookingRepository>())..add(LoadInitial()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Create Booking')),
        body: BlocConsumer<BookingBloc, BookingState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.loading && state.services.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Service'),
                      items: state.services
                          .map((s) => DropdownMenuItem(
                                value: s.id,
                                child: Text(s.name),
                              ))
                          .toList(),
                      validator: (v) =>
                          v == null ? 'Please select a service' : null,
                      onChanged: (v) => setState(() => _selectedServiceId = v),
                      initialValue: _selectedServiceId,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Staff'),
                      items: state.staff
                          .map((s) => DropdownMenuItem(
                                value: s.id,
                                child: Text(s.name),
                              ))
                          .toList(),
                      validator: (v) =>
                          v == null ? 'Please select a staff member' : null,
                      onChanged: (v) => setState(() => _selectedStaffId = v),
                      initialValue: _selectedStaffId,
                    ),
                    const SizedBox(height: 12),
                    InputDecorator(
                      decoration:
                          const InputDecoration(labelText: 'Start time'),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _start == null
                                  ? 'Not selected'
                                  : _start!.toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              final now = DateTime.now();
                              final date = await showDatePicker(
                                context: context,
                                initialDate: now,
                                firstDate: now,
                                lastDate: now.add(const Duration(days: 365)),
                              );
                              if (date == null) return;
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(
                                    now.add(const Duration(hours: 1))),
                              );
                              if (time == null) return;
                              if (!mounted) return;
                              setState(() {
                                _start = DateTime(date.year, date.month,
                                    date.day, time.hour, time.minute);
                              });
                            },
                            child: const Text('Pick'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) return;
                        if (_start == null) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please pick a start time')),
                          );
                          return;
                        }
                        final start = _start!;
                        if (start.isBefore(DateTime.now())) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Start time must be in the future')),
                          );
                          return;
                        }
                        final bloc = context.read<BookingBloc>();
                        bloc.add(CreateBooking(
                          serviceId: _selectedServiceId!,
                          staffId: _selectedStaffId!,
                          start: start,
                        ));
                        await Future.delayed(const Duration(milliseconds: 300));
                        if (!mounted) return;
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Booking created')),
                        );
                      },
                      child: const Text('Create Booking'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
