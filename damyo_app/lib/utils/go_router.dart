import 'package:damyo_app/view/home/home_view.dart';
import 'package:damyo_app/view/map/smoking_area/sa_detail_view.dart';
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
          path: 'sa/detail/:areaId',
          builder: (BuildContext context, GoRouterState state) {
            return SaDetailView(
              areaId: state.pathParameters['areaId']!,
            );
          },
        ),
      ],
    ),
  ],
);
