import 'package:e_commerce_site_django/common/services/storage.dart';
import 'package:e_commerce_site_django/common/utils/kcolors.dart';
import 'package:e_commerce_site_django/common/utils/kstrings.dart';
import 'package:e_commerce_site_django/common/widgets/app_style.dart';
import 'package:e_commerce_site_django/common/widgets/back_button.dart';
import 'package:e_commerce_site_django/common/widgets/reusable_text.dart';
import 'package:e_commerce_site_django/common/widgets/shimmers/list_shimmer.dart';
import 'package:e_commerce_site_django/const/constants.dart';
import 'package:e_commerce_site_django/src/auth/views/login_screen.dart';
import 'package:e_commerce_site_django/src/cart/controllers/cart_notifier.dart';
import 'package:e_commerce_site_django/src/cart/hooks/fetch_cart.dart';
import 'package:e_commerce_site_django/src/cart/hooks/fetch_cart_count.dart';
import 'package:e_commerce_site_django/src/cart/widgets/cart_tile.dart';
import 'package:e_commerce_site_django/src/search/controllers/search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CartPage extends HookWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final results = fetchCart();
    final cart = results.cart;
    final isLoading = results.isLoading;
    final refetch = results.refetch;
    final error = results.error;
    if (accessToken == null) {
      return LoginPage();
    }
    if (isLoading) {
      return const Scaffold(
        body: ListShimmer(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
            text: AppText.kCart,
            style: appStyle(15, Kolors.kPrimary, FontWeight.bold)),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        children: List.generate(
          cart.length,
          (index) {
            final cartItem = cart[index];
            return CartTile(
              cart: cartItem,
              onDelete: () {
                context.read<CartNotifier>().deleteCart(cartItem.id, refetch);
              },
              onUpdate: () {
                context.read<CartNotifier>().updateCart(cartItem.id, refetch);
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Consumer<CartNotifier>(
        builder: (context, cartNotifier, child) {
          return GestureDetector(
            onTap: () {
              context.push('/checkout');
            },
            child: cartNotifier.selectedCartItems.isNotEmpty
                ? Container(
                    padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 90.h),
                    height: 130,
                    decoration: BoxDecoration(
                        color: Kolors.kPrimaryLight, borderRadius: kRadiusTop),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusableText(
                              text: "Click To Checkout",
                              style:
                                  appStyle(15, Kolors.kWhite, FontWeight.w600)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusableText(
                              text:
                                  "\$${cartNotifier.totalPrice.toStringAsFixed(2)}",
                              style:
                                  appStyle(15, Kolors.kWhite, FontWeight.w600)),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
