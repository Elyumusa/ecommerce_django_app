import 'package:e_commerce_site_django/common/services/storage.dart';
import 'package:e_commerce_site_django/common/utils/kcolors.dart';
import 'package:e_commerce_site_django/common/utils/kstrings.dart';
import 'package:e_commerce_site_django/common/widgets/app_style.dart';
import 'package:e_commerce_site_django/common/widgets/back_button.dart';
import 'package:e_commerce_site_django/common/widgets/reusable_text.dart';
import 'package:e_commerce_site_django/const/constants.dart';
import 'package:e_commerce_site_django/src/addresses/controllers/address_notifier.dart';
import 'package:e_commerce_site_django/src/addresses/hooks/fetch_default.dart';
import 'package:e_commerce_site_django/src/addresses/widgets/address_block.dart';
import 'package:e_commerce_site_django/src/cart/controllers/cart_notifier.dart';
import 'package:e_commerce_site_django/src/checkout/models/check_out_model.dart';
import 'package:e_commerce_site_django/src/checkout/views/payment.dart';
import 'package:e_commerce_site_django/src/checkout/widgets/checkout_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends HookWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final result = fetchDefaultAddress();
    final address = result.address;
    final isLoading = result.isLoading;
    return Consumer<CartNotifier>(builder: (context, cartNotifier, child) {
      return context
              .read<CartNotifier>()
              .paymentUrl
              .contains('https://checkout.stripe.com')
          ? const PaymentWebView()
          : Scaffold(
              appBar: AppBar(
                leading: AppBackButton(
                  onTap: () {
                    //Clear the address
                    context.read<AddressNotifier>().clearAddress();
                    context.pop();
                  },
                ),
                title: ReusableText(
                    text: AppText.kCheckout,
                    style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
              ),
              body: Consumer<CartNotifier>(
                builder: (context, cartNoti, child) {
                  return ListView(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    children: [
                      //Add address block
                      isLoading
                          ? SizedBox.shrink()
                          : AddressBlock(
                              address: address,
                            ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: ScreenUtil().screenHeight * 0.5,
                        child: Column(
                          children: List.generate(
                            cartNotifier.selectedCartItems.length,
                            (index) {
                              return CheckoutTile(
                                cart: cartNotifier.selectedCartItems[index],
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
              bottomNavigationBar:
                  Consumer<CartNotifier>(builder: (context, cartN, child) {
                return GestureDetector(
                  onTap: () {
                    if (address == null) {
                      context.push("/addresses");
                    } else {
                      List<CartItem> checkoutItems = [];
                      for (var item in cartNotifier.selectedCartItems) {
                        CartItem data = CartItem(
                            name: item.product.title,
                            id: item.product.id,
                            price: item.product.price,
                            cartQuantity: item.quantity,
                            size: item.size,
                            color: item.color);
                        checkoutItems.add(data);
                      }
                      CreateCheckout data = CreateCheckout(
                          address:
                              context.read<AddressNotifier>().address == null
                                  ? address.id
                                  : context.read<AddressNotifier>().address!.id,
                          accesstoken: accessToken!.toString(),
                          fcm: "",
                          totalAmount: cartNotifier.totalPrice,
                          cartItems: checkoutItems);
                      String c = createCheckoutToJson(data);
                      cartNotifier.createCheckout(c);
                    }
                    //create checkout
                  },
                  child: Container(
                    height: 80,
                    width: ScreenUtil().screenWidth,
                    decoration: BoxDecoration(
                        color: Kolors.kPrimaryLight, borderRadius: kRadiusTop),
                    child: Center(
                      child: ReusableText(
                          text: address == null
                              ? "Please an address"
                              : "Continue To Payment",
                          style: appStyle(16, Kolors.kWhite, FontWeight.w600)),
                    ),
                  ),
                );
              }),
            );
    });
  }
}
