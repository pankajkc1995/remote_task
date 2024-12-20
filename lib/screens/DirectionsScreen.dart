import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/Product.dart';

class DirectionsScreen extends StatelessWidget {
  final LatLng userLocation;
  final int UserIndex;
  final List<Product> products;
  DirectionsScreen({required this.userLocation,required this.UserIndex, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Directions')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: userLocation,
          zoom: 7,
        ),
        markers: _createMarkers(),
        polylines: {
          Polyline(
            polylineId: PolylineId('route'),

            points: [userLocation, LatLng(products[UserIndex].coordinates![0].toDouble(), products[UserIndex].coordinates![1].toDouble())],
            color: Colors.blue,
            width: 5,
          ),
        },
      ),
    );
  }


  Set<Marker> _createMarkers() {
    return products.map((location) {
      return Marker(
        markerId: MarkerId(location.title!),
        position: LatLng(location.coordinates![0].toDouble(), location.coordinates![1].toDouble()),
        infoWindow: InfoWindow(
          title: location.body!,
          snippet: 'Lat: ${location.coordinates![0].toDouble()}, Lng: ${location.coordinates![1].toDouble()}',
        ),
      );
    }).toSet();
  }

}