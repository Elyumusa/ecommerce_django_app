import 'package:e_commerce_site_django/common/utils/kcolors.dart';
import 'package:e_commerce_site_django/common/widgets/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ProfileTileWidget extends StatelessWidget {
  const ProfileTileWidget(
      {super.key, required this.title, this.onTap, required this.leading});
  final String title;
  final void Function()? onTap;
  final IconData leading;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      onTap: onTap,
      leading: Icon(
        leading,
        color: Kolors.kGray,
      ),
      title: Text(
        title,
        style: appStyle(13, Kolors.kDark, FontWeight.normal),
      ),
      trailing: Icon(
        AntDesign.right,
        size: 16,
        color: Kolors.kDark,
      ),
    );
  }
}
