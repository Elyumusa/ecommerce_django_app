import 'package:e_commerce_site_django/common/utils/kcolors.dart';
import 'package:e_commerce_site_django/common/widgets/app_style.dart';
import 'package:e_commerce_site_django/common/widgets/reusable_text.dart';
import 'package:e_commerce_site_django/common/widgets/shimmers/categories_shimmer.dart';
import 'package:e_commerce_site_django/const/constants.dart';
import 'package:e_commerce_site_django/src/categories/controllers/category_notifier.dart';
import 'package:e_commerce_site_django/src/categories/hooks/fetch_home_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CategoriesList extends HookWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final results = fetchHomeCategories();
    final categories = results.categories;
    final isLoading = results.isLoading;
    final error = results.error;

    if (isLoading) {
      return CatergoriesShimmer();
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: SizedBox(
        height: 80.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            categories.length,
            (index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () {
                  context
                      .read<CategoryNotifier>()
                      .setCategory(category.title, category.id);
                  context.push('/category');
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Kolors.kSecondaryLight,
                      child: Padding(
                        padding: EdgeInsets.all(4.h),
                        child: SvgPicture.network(
                          category.imageUrl,
                          width: 40.w,
                          height: 40.h,
                        ),
                      ),
                    ),
                    ReusableText(
                        text: category.title,
                        style: appStyle(12, Kolors.kGray, FontWeight.normal))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
