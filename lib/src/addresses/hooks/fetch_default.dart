import 'dart:convert';

import 'package:e_commerce_site_django/common/services/storage.dart';
import 'package:e_commerce_site_django/common/utils/environment.dart';
import 'package:e_commerce_site_django/src/addresses/hooks/results/default_results.dart';
import 'package:e_commerce_site_django/src/addresses/models/address_model.dart';
import 'package:e_commerce_site_django/src/cart/hooks/results/cart_results.dart';
import 'package:e_commerce_site_django/src/cart/models/cart_model.dart';
import 'package:e_commerce_site_django/src/categories/hooks/results/categories_results.dart';
import 'package:e_commerce_site_django/src/categories/hooks/results/category_products_results.dart';
import 'package:e_commerce_site_django/src/categories/models/categories_model.dart';
import 'package:e_commerce_site_django/src/products/models/products_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchDefaultAddress fetchDefaultAddress() {
  final address = useState<AddressModel?>(null);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  String? accessToken = Storage().getString('accessToken');
  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/address/me/');
      String? accessToken = Storage().getString('accessToken');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": 'application/json',
          "Authorization": 'Token $accessToken'
        },
      );
      if (response.statusCode == 200) {
        address.value = addressModelFromJson(response.body);
        print("cart :${address}");
      }
    } catch (e) {
      error.value = e.toString();
      print("error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    if(accessToken!=null){
    fetchData();}
    return;
  }, const []);

  void refetch() {
    isLoading.value = true;
    print("Refetch has ran");
    fetchData();
  }

  return FetchDefaultAddress(
      address: address.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
