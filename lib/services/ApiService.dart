import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:remote_task/AppUtils/constant.dart';

import '../models/Product.dart';

class ApiService {

  Future<List<Product>> fetchProducts() async {

    final response = await http.get(Uri.parse(Constant.base_url));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body.toString());
      return jsonResponse.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
  }

