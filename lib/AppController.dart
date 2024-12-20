import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'models/Product.dart';

class AppController{
  static void showProductDetails(Product product,BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(product.title.toString()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(product.imageUrl.toString()),
              SizedBox(height: 10),
              Text(product.body.toString()),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }


 static String calculateDistance(double currLat, double curlng, double targetLatitude, double targetLongitude) {
    double distanceInMeters = Geolocator.distanceBetween(
      currLat,
      curlng,
      targetLatitude,
      targetLongitude,
    );

    return '${(distanceInMeters / 1000).toStringAsFixed(2)} km'; // Convert to kilometers
  }

}