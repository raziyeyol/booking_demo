import 'package:booking_demo/features/booking/presentation/pages/admin_dashboard_page.dart';
import 'package:booking_demo/features/booking/presentation/pages/booking_list_page.dart';
import 'package:booking_demo/features/booking/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter createAppRouter() => GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: 'bookings',
              name: 'bookings',
              builder: (context, state) => const BookingListPage(),
            ),
            GoRoute(
              path: 'admin',
              name: 'admin',
              builder: (context, state) => const AdminDashboardPage(),
            ),
          ],
        ),
      ],
    );
