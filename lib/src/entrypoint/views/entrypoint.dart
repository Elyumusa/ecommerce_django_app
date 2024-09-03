import 'package:e_commerce_site_django/common/utils/kcolors.dart';
import 'package:e_commerce_site_django/src/cart/hooks/fetch_cart_count.dart';
import 'package:e_commerce_site_django/src/cart/views/cart_screen.dart';
import 'package:e_commerce_site_django/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:e_commerce_site_django/src/home/views/home_screen.dart';
import 'package:e_commerce_site_django/src/profile/views/profile_screen.dart';
import 'package:e_commerce_site_django/src/wishlist/views/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class AppEntryPoint extends HookWidget {
  AppEntryPoint({super.key});

  List<Widget> pageList = const [
    HomePage(),
    WishlistPage(),
    CartPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    final result = fetchCartCount(context);
    final count = result.count;
    return Consumer<TabIndexNotifier>(
        builder: (context, tabIndexNotifier, child) {
      return Scaffold(
        body: Stack(
          children: [
            pageList[tabIndexNotifier.index],
            Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                  data:
                      Theme.of(context).copyWith(canvasColor: Kolors.kOffWhite),
                  child: BottomNavigationBar(
                      selectedFontSize: 9,
                      elevation: 0,
                      backgroundColor: Kolors.kOffWhite,
                      showSelectedLabels: true,
                      currentIndex: tabIndexNotifier.index,
                      selectedItemColor: Kolors.kPrimary,
                      unselectedItemColor: Kolors.kGray,
                      showUnselectedLabels: false,
                      unselectedIconTheme:
                          const IconThemeData(color: Colors.black38),
                      onTap: (value) {
                        tabIndexNotifier.setIndex(value);
                      },
                      items: [
                        BottomNavigationBarItem(
                            icon: tabIndexNotifier.index == 0
                                ? const Icon(
                                    AntDesign.home,
                                    color: Kolors.kPrimary,
                                    size: 24,
                                  )
                                : const Icon(
                                    AntDesign.home,
                                    size: 24,
                                  ),
                            label: "Home"),
                        BottomNavigationBarItem(
                            icon: tabIndexNotifier.index == 1
                                ? const Icon(
                                    Ionicons.heart,
                                    color: Kolors.kPrimary,
                                    size: 24,
                                  )
                                : const Icon(
                                    Ionicons.heart_outline,
                                  ),
                            label: "WishList"),
                        BottomNavigationBarItem(
                            icon: tabIndexNotifier.index == 2
                                ?  Badge(
                                    label: Text(count.cartCount.toString()),
                                    child: Icon(
                                      MaterialCommunityIcons.shopping,
                                      color: Kolors.kPrimary,
                                      size: 24,
                                    ),
                                  )
                                :  Badge(
                                    label: Text(count.cartCount.toString()),
                                    child: Icon(
                                      MaterialCommunityIcons.shopping_outline,
                                    ),
                                  ),
                            label: "Cart"),
                        BottomNavigationBarItem(
                            icon: tabIndexNotifier.index == 3
                                ? const Icon(
                                    EvilIcons.user,
                                    color: Kolors.kPrimary,
                                    size: 34,
                                  )
                                : const Icon(
                                    EvilIcons.user,
                                    size: 34,
                                  ),
                            label: "Profile")
                      ])),
            )
          ],
        ),
      );
    });
  }
}
