import 'package:e_commerce_site_django/common/services/storage.dart';
import 'package:e_commerce_site_django/common/utils/kcolors.dart';
import 'package:e_commerce_site_django/common/utils/kstrings.dart';
import 'package:e_commerce_site_django/common/widgets/app_style.dart';
import 'package:e_commerce_site_django/common/widgets/reusable_text.dart';
import 'package:e_commerce_site_django/src/auth/views/login_screen.dart';
import 'package:e_commerce_site_django/src/products/widgets/explore_product.dart';
import 'package:e_commerce_site_django/src/wishlist/widgets/wishlist.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    if (accessToken == null) {
      return LoginPage();
    }
    return Scaffold(
        appBar: AppBar(
          title: ReusableText(
              text: AppText.kWishlist,
              style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: WishListWidget(),
        ));
  }
}
