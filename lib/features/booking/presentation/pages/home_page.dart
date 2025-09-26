import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Demo')),
      body: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 16,
          children: [
            ElevatedButton.icon(
              onPressed: () => context.go('/bookings'),
              icon: const Icon(Icons.event_available),
              label: const Text('Customer Mode'),
            ),
            ElevatedButton.icon(
              onPressed: () => context.go('/admin'),
              icon: const Icon(Icons.dashboard_customize),
              label: const Text('Admin Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
