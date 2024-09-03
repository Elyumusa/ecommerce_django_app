import 'package:e_commerce_site_django/common/services/storage.dart';
import 'package:e_commerce_site_django/common/utils/kcolors.dart';
import 'package:e_commerce_site_django/common/widgets/login_bottom_sheet.dart';
import 'package:e_commerce_site_django/src/notifications/hooks/fetch_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

class NotificationWidget extends HookWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchCount(context);
    final isLoading = result.isLoading;
    final data = result.count;
    return GestureDetector(
        onTap: () {
          //TODO: Navigate to notification page
          if (Storage().getString("accessToken") == null) {
            loginBottomSheet(context);
          } else {
            context.push("/notifications");
          }
        },
        child: Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: CircleAvatar(
            backgroundColor: Kolors.kGrayLight.withOpacity(0.3),
            child: Badge(
              label: Text(isLoading ? "0" : data.unreadCount.toString()),
              child: Icon(Ionicons.notifications, color: Kolors.kPrimary),
            ),
          ),
        ));
  }
}
