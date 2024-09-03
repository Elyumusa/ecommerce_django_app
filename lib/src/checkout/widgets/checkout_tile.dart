import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_site_django/common/utils/kcolors.dart';
import 'package:e_commerce_site_django/common/widgets/app_style.dart';
import 'package:e_commerce_site_django/common/widgets/reusable_text.dart';
import 'package:e_commerce_site_django/const/constants.dart';
import 'package:e_commerce_site_django/src/cart/controllers/cart_notifier.dart';
import 'package:e_commerce_site_django/src/cart/models/cart_model.dart';
import 'package:e_commerce_site_django/src/cart/widgets/cart_counter.dart';
import 'package:e_commerce_site_django/src/cart/widgets/update_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class CheckoutTile extends StatelessWidget {
  const CheckoutTile({super.key, required this.cart});

  final CartModel cart;
  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(
      builder: (context, cartNotifier, child) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Container(
            width: ScreenUtil().screenWidth,
            height: 90.h,
            decoration: BoxDecoration(
                color: Kolors.kPrimaryLight.withOpacity(0.2),
                borderRadius: kRadiusAll),
            child: SizedBox(
              height: 85.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Kolors.kWhite,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12))),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: kRadiusAll,
                              child: SizedBox(
                                width: 76.w,
                                height: double.infinity,
                                child: CachedNetworkImage(
                                    imageUrl: cart.product.imageUrls[0],
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ReusableText(
                              text: cart.product.title,
                              style: appStyle(
                                  12, Kolors.kDark, FontWeight.normal)),
                          ReusableText(
                              text: 'Size: ${cart.size} || Color: ${cart.color}'
                                  .toUpperCase(),
                              style: appStyle(
                                  12, Kolors.kGray, FontWeight.normal)),
                          SizedBox(
                            width: ScreenUtil().screenWidth * 0.5,
                            child: Text(cart.product.description,
                                maxLines: 2,
                                textAlign: TextAlign.justify,
                                style: appStyle(
                                    9, Kolors.kGray, FontWeight.normal)),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              cartNotifier.setSelectedCounter(
                                  cart.id, cart.quantity);
                            },
                            child: Container(
                              width: 40.w,
                              height: 20.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(
                                      color: Kolors.kPrimary, width: 0.5)),
                              child: ReusableText(
                                  text: "* ${cart.quantity}",
                                  style: appStyle(
                                      12, Kolors.kPrimary, FontWeight.normal)),
                            )),
                        SizedBox(
                          height: 6.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 6.w),
                          child: ReusableText(
                              text:
                                  "\$ ${(cart.quantity * cart.product.price).toStringAsFixed(2)}",
                              style: appStyle(
                                  12, Kolors.kPrimary, FontWeight.w600)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
