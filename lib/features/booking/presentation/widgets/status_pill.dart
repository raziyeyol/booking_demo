import 'package:flutter/material.dart';

class StatusPill extends StatelessWidget {
  final String status; // 'paid' | 'pending' | 'failed' | 'refunded'
  const StatusPill({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      'paid' => ('Paid', Colors.green),
      'pending' => ('Pending', Colors.orange),
      'failed' => ('Failed', Colors.red),
      'refunded' => ('Refunded', Colors.blueGrey),
      _ => ('Unknown', Colors.grey),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(label,
          style: TextStyle(color: color, fontWeight: FontWeight.w600)),
    );
  }
}
