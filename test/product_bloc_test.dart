import 'package:flutter_test/flutter_test.dart';
import 'package:remote_task/appController.dart';
import 'package:remote_task/services/apiService.dart';



void main() {
  test('Fetch products from API', () async {
    final apiService = ApiService();
    final products = await apiService.fetchProducts();

    expect(products, isNotEmpty);
    expect(products[0].title, isNotNull);
    expect(products[0].coordinates, isNotNull);
  });

  group('Distance Calculation', () {
    test('calculates distance correctly', () {
      // Assuming you have a function to calculate distance
      final distance = AppController.calculateDistance(37.7749, -122.4194, 34.0522, -118.2437);

      // Assert
      expect(distance, isA<String>()); // Assuming it returns a String
      expect(distance, contains('km')); // Check if it contains the unit
    });
  });
}