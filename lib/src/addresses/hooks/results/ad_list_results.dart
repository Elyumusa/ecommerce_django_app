import 'package:e_commerce_site_django/src/addresses/models/address_model.dart';
import 'package:e_commerce_site_django/src/cart/models/cart_count_model.dart';
import 'package:e_commerce_site_django/src/cart/models/cart_model.dart';
import 'package:flutter/material.dart';

class FetchAddress {
  final List<AddressModel> address;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchAddress(
      {required this.address,
      required this.isLoading,
      required this.error,
      required this.refetch});
}
