import 'package:e_commerce_site_django/common/utils/kcolors.dart';
import 'package:e_commerce_site_django/common/widgets/app_style.dart';
import 'package:e_commerce_site_django/common/widgets/reusable_text.dart';
import 'package:e_commerce_site_django/src/addresses/models/address_model.dart';
import 'package:e_commerce_site_django/src/addresses/widgets/address_tile.dart';
import 'package:flutter/material.dart';

class AddressBlock extends StatelessWidget {
  const AddressBlock(
      {super.key, required this.address});
  final AddressModel? address;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableText(
            text: "Shipping Address",
            style: appStyle(13, Kolors.kPrimary, FontWeight.w500)),
        AddressTile(
          address: address!,
          isCheckout: true,
        )
      ],
    );
  }
}
