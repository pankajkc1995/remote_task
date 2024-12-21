import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:remote_task/AppUtils/routers/error_route_screen.dart';
import 'package:remote_task/AppUtils/routers/route_name.dart';
import 'package:remote_task/models/product.dart';
import 'package:remote_task/screens/directionsScreen.dart';
import 'package:remote_task/screens/product_view.dart';

class AppRouter {
  AppRouter._privateContructor();

  static AppRouter? _instance;

  factory AppRouter() => _instance ??= AppRouter._privateContructor();

  final router = GoRouter(
    initialLocation: AppRouteNames.productlistRouteName,
    routes: [
      GoRoute(
        path: AppRouteNames.productlistRouteName,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ProductView(),
        ),
      ),
      GoRoute(
        path: AppRouteNames.directionRouteName,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: DirectionsScreen(
              userLocation: state.extra as LatLng,
              UserIndex: state.extra as int,
              products: state.extra as List<Product>),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: ErrorScreen(
        e: state.error,
      ),
    ),
  );
}
