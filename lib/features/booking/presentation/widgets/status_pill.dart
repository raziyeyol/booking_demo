import 'package:flutter/material.dart';

class StatusPill extends StatelessWidget {
  final String status; // 'paid' | 'pending' | 'failed' | 'refunded'
  const StatusPill({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final Color base = status == 'paid'
        ? colorScheme.primary
        : status == 'failed'
            ? colorScheme.error
            : colorScheme.secondary;
    final bg = base.withValues(alpha: 0.12);
    final fg = base;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: base.withValues(alpha: 0.3)),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: fg,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
