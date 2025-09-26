import 'package:booking_demo/features/booking/domain/entities.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final Service service;
  final VoidCallback? onTap;
  const ServiceCard({super.key, required this.service, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(service.name,
                          style: Theme.of(context).textTheme.titleMedium),
                      if (service.popular) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.local_fire_department, size: 18),
                      ],
                    ]),
                    const SizedBox(height: 8),
                    Text(
                        '${service.minutes} min • ${(service.priceCents / 100).toStringAsFixed(2)} \$'),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
