import 'package:e_commerce_site_django/src/cart/models/cart_count_model.dart';
import 'package:e_commerce_site_django/src/notifications/models/notification_count.dart';
import 'package:e_commerce_site_django/src/orders/models/orders_model.dart';
import 'package:flutter/material.dart';

class FetchOrder {
  final OrderModel? order;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchOrder(
      {required this.order,
      required this.isLoading,
      required this.error,
      required this.refetch});
}
