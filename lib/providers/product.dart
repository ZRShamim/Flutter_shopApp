import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatuss() async {
    final _oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://shop-app-zrs-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json';
    try {
      final response = await http.patch(Uri.parse(url),
          body: json.encode({'isFavorite': isFavorite}));
      if (response.statusCode >= 400) {
        _setFavValue(_oldStatus);
      }
    } catch (error) {
      _setFavValue(_oldStatus);
    }
  }
}
