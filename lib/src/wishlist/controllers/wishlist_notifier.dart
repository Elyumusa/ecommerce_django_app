import 'dart:convert';

import 'package:e_commerce_site_django/common/services/storage.dart';
import 'package:e_commerce_site_django/common/utils/environment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WishListNotifier with ChangeNotifier {
  String? error;
  void setError(String e) {
    error = e;
    notifyListeners();
  }

  void addRemoveWishList(int id, Function refetch) async {
    final accessToken = Storage().getString('accessToken');

    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/wishlist/toggle/?id=$id');

      final response = await http.get(url, headers: {
        'Authorization': 'Token $accessToken',
        'Content-Type': 'application/json'
      });

      print(response.statusCode);

      if (response.statusCode == 201) {
        //Set the ID to a list in our local machine
        setToList(id);
        //refetch data
        refetch();
      } else if (response.statusCode == 204) {
        //remove from local storage
        setToList(id);
        //refetch data
        refetch();
      }
    } catch (e) {
      error = e.toString();
    }
  }

  List _wishlist = [];
  List get wishlist => _wishlist;

  void setWishList(List w) {
    _wishlist.clear();
    _wishlist = w;
    notifyListeners();
  }

  void setToList(int v) {
    String? accessToken = Storage().getString("accessToken");
    String? wishlist = Storage().getString('${accessToken}wishlist');
    if (wishlist == null) {
      List wishlist = [];
      wishlist.add(v);
      setWishList(wishlist);
      Storage().setString('${accessToken}wishlist', jsonEncode(wishlist));
    } else {
      List w = jsonDecode(wishlist);
      if (w.contains(v)) {
        w.removeWhere((e) => e == v);
        setWishList(w);
        Storage().setString('${accessToken}wishlist', jsonEncode(w));
      } else if (!w.contains(v)) {
        w.add(v);
        setWishList(w);
        Storage().setString('${accessToken}wishlist', jsonEncode(w));
      }
    }
  }
}
