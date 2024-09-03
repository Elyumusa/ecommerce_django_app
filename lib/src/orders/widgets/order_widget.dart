import 'package:e_commerce_site_django/common/utils/enums.dart';
import 'package:e_commerce_site_django/common/widgets/empty_screen_widget.dart';
import 'package:e_commerce_site_django/src/notifications/views/notification_shimmer.dart';
import 'package:e_commerce_site_django/src/orders/hooks/fetch_orders.dart';
import 'package:e_commerce_site_django/src/orders/widgets/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderWidget extends HookWidget {
  const OrderWidget({required this.ordersTypes, super.key});
  final FetchOrdersTypes ordersTypes;

  @override
  Widget build(BuildContext context) {
    final results = fetchOrders(ordersTypes);
    final orders = results.orders;
    final isLoading = results.isLoading;

    if (isLoading) {
      return NotificationShimmer();
    }
    return orders.isNotEmpty
        ? ListView(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            children: List.generate(
              orders.length,
              (index) {
                return OrderTile(
                  order: orders[index]!,
                );
              },
            ),
          )
        : EmptyScreenWidget();
  }
}
