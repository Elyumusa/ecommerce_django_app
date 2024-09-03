import 'package:e_commerce_site_django/common/services/storage.dart';
import 'package:e_commerce_site_django/common/widgets/empty_widget.dart';
import 'package:e_commerce_site_django/common/widgets/login_bottom_sheet.dart';
import 'package:e_commerce_site_django/common/widgets/shimmers/list_shimmer.dart';
import 'package:e_commerce_site_django/const/constants.dart';
import 'package:e_commerce_site_django/src/products/controllers/product_notifier.dart';
import 'package:e_commerce_site_django/src/products/hooks/fetch_similar.dart';
import 'package:e_commerce_site_django/src/products/widgets/staggered_tile_widget.dart';
import 'package:e_commerce_site_django/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class SimilarProducts extends HookWidget {
  const SimilarProducts({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString("accessToken");
    final results =
        fetchSimilar(context.read<ProductNotifier>().product!.category);
    final products = results.products;
    final isLoading = results.isLoading;
    final error = results.error;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    return products.isEmpty
        ? EmptyWidget()
        : Padding(
            padding: EdgeInsets.all(8.h),
            child: StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 2,
              crossAxisSpacing: 4,
              children: List.generate(
                products.length,
                (i) {
                  final double mainAxisCellCount = (i % 2 == 0 ? 2.3 : 2.4);
                  final product = products[i];
                  return StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: mainAxisCellCount,
                      child: StaggeredTileWidget(
                        i: i,
                        product: product,
                        onTap: () {
                          if (accessToken == null) {
                            loginBottomSheet(context);
                          } else {
                            //handle wishlist functionality
                            context
                                .read<WishListNotifier>()
                                .addRemoveWishList(product.id, () {});
                          }
                        },
                      ));
                },
              ),
            ),
          );
  }
}
