import 'package:e_commerce_site_django/common/utils/kcolors.dart';
import 'package:e_commerce_site_django/common/utils/kstrings.dart';
import 'package:e_commerce_site_django/common/widgets/app_style.dart';
import 'package:e_commerce_site_django/common/widgets/back_button.dart';
import 'package:e_commerce_site_django/common/widgets/reusable_text.dart';
import 'package:e_commerce_site_django/common/widgets/shimmers/list_shimmer.dart';
import 'package:flutter/material.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(),
        title: ReusableText(
            text: AppText.kNotifications,
            style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
      ),
      body: Container(
        color: Kolors.kWhite,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListShimmer(),
        ),
      ),
    );
  }
}
