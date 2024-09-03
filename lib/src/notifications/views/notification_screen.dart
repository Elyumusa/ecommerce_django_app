import 'package:e_commerce_site_django/common/utils/kcolors.dart';
import 'package:e_commerce_site_django/common/utils/kstrings.dart';
import 'package:e_commerce_site_django/common/widgets/app_style.dart';
import 'package:e_commerce_site_django/common/widgets/back_button.dart';
import 'package:e_commerce_site_django/common/widgets/empty_screen_widget.dart';
import 'package:e_commerce_site_django/common/widgets/reusable_text.dart';
import 'package:e_commerce_site_django/src/notifications/controllers/notification_notifier.dart';
import 'package:e_commerce_site_django/src/notifications/hooks/fetch_notifications.dart';
import 'package:e_commerce_site_django/src/notifications/views/notification_shimmer.dart';
import 'package:e_commerce_site_django/src/notifications/widgets/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends HookWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchNotifications(context);
    final notifications = result.notifications;
    final isLoading = result.isLoading;

    if (isLoading) {
      return NotificationShimmer();
    }
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(),
        title: ReusableText(
            text: AppText.kNotifications,
            style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
      ),
      body: notifications.isEmpty
          ? const EmptyScreenWidget()
          : ListView(
              children: List.generate(
                notifications.length,
                (index) {
                  final notification = notifications[index];
                  return NotificationTile(
                    notification: notification,
                    index: index,
                    onUpdate: () {
                      context
                          .read<NotificationNotifier>()
                          .setOrderId(notifications[index].orderId);
                      context.push('/tracking');
                    },
                  );
                },
              ),
            ),
    );
  }
}
