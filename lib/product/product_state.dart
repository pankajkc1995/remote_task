


import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:remote_task/models/Product.dart';

abstract class ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  ProductLoaded(this.products);
}

class FetchUserCurrentLocation extends ProductState{
  final LatLng currLatlng;
  FetchUserCurrentLocation(this.currLatlng);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}