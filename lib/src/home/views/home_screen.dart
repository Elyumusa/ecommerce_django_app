import 'package:e_commerce_site_django/src/home/controllers/home_tab_notifier.dart';
import 'package:e_commerce_site_django/src/home/widgets/categories_list.dart';
import 'package:e_commerce_site_django/src/home/widgets/custom_app_bar.dart';
import 'package:e_commerce_site_django/src/home/widgets/home_header.dart';
import 'package:e_commerce_site_django/src/home/widgets/home_slider.dart';
import 'package:e_commerce_site_django/src/home/widgets/home_tab.dart';
import 'package:e_commerce_site_django/src/products/widgets/explore_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  int _currentTabIndex = 0;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: homeTabs.length);
    _tabController.addListener(_handleSelection);
    super.initState();
  }

  void _handleSelection() {
    final controller = Provider.of<HomeTabNotifier>(context, listen: false);
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
      controller.setIndex(homeTabs[_currentTabIndex]);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(110),
          child: CustomAppBar(),
        ),
        body: ListView(
          //shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          children: [
            SizedBox(
              height: 20.h,
            ),
            HomeSlider(),
            SizedBox(
              height: 15.h,
            ),
            const HomeHeader(),
            SizedBox(
              height: 10.h,
            ),
            const CategoriesList(),
            SizedBox(
              height: 15.h,
            ),
            HomeTabs(tabController: _tabController),
            SizedBox(
              height: 15.h,
            ),
            const ExploreProducts(),
            SizedBox(
              height: 100.h,
            ),
          ],
        ));
  }
}

List<String> homeTabs = ['All', 'Popular', 'Unisex', 'Men', 'Women', 'Kids'];
