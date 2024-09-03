import 'package:e_commerce_site_django/src/cart/models/cart_count_model.dart';
import 'package:e_commerce_site_django/src/notifications/models/notification_count.dart';
import 'package:flutter/material.dart';

class FetchCount {
  final NotificationCount count;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchCount(
      {required this.count,
      required this.isLoading,
      required this.error,
      required this.refetch});
}
