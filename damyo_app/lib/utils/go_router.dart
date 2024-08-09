import 'package:damyo_app/view/home/home_view.dart';
import 'package:damyo_app/view/map/smoking_area/sa_detail_view.dart';
import 'package:damyo_app/view/map/smoking_area/sa_inform_view.dart';
import 'package:damyo_app/view/map/smoking_area/sa_review_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomeView();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'smokingarea/inform',
          builder: (BuildContext context, GoRouterState state) {
            final Map<String, double> coord =
                state.extra as Map<String, double>;
            final double lat = coord["lat"]!;
            final double lng = coord["lng"]!;
            return SaInformView(lat: lat, lng: lng);
          },
        ),
        GoRoute(
          path: 'smokingarea/:areaId',
          builder: (BuildContext context, GoRouterState state) {
            return SaDetailView(
              areaId: state.pathParameters['areaId']!,
            );
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'review',
              builder: (BuildContext context, GoRouterState state) {
                final String title = state.extra as String;
                return SaReviewView(
                  areaId: state.pathParameters['areaId']!,
                  name: title,
                );
              },
            )
          ],
        ),
      ],
    ),
  ],
);
