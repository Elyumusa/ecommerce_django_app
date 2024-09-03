import 'package:e_commerce_site_django/common/utils/enums.dart';
import 'package:e_commerce_site_django/common/utils/kcolors.dart';
import 'package:e_commerce_site_django/common/utils/kstrings.dart';
import 'package:e_commerce_site_django/common/widgets/app_style.dart';
import 'package:e_commerce_site_django/common/widgets/back_button.dart';
import 'package:e_commerce_site_django/common/widgets/reusable_text.dart';
import 'package:e_commerce_site_django/common/widgets/tab_widget.dart';
import 'package:e_commerce_site_django/src/orders/widgets/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OrdersPage extends StatefulHookWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  int _currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: AppBackButton(
            onTap: () {
              return context.go('/home');
            },
          ),
          title: ReusableText(
              text: AppText.kOrder,
              style: appStyle(14, Kolors.kPrimary, FontWeight.w600)),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(30.h),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: SizedBox(
                  height: 22.h,
                  child: TabBar(
                    tabs: <Widget>[
                      Tab(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: ScreenUtil().screenWidth / 3,
                          height: 25,
                          child: const Center(child: Text('Processing')),
                        ),
                      ),
                      Tab(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: ScreenUtil().screenWidth / 3,
                          height: 25,
                          child: const Center(child: Text('Fultfiled')),
                        ),
                      ),
                      Tab(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: ScreenUtil().screenWidth / 3,
                          height: 25,
                          child: const Center(child: Text('Cancelled')),
                        ),
                      )
                    ],
                    controller: _tabController,
                    labelPadding: EdgeInsets.zero,
                    labelColor: Kolors.kWhite,
                    dividerColor: Colors.transparent,
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    labelStyle: appStyle(11, Kolors.kPrimary, FontWeight.w600),
                    unselectedLabelStyle:
                        appStyle(11, Kolors.kGray, FontWeight.normal),
                    indicator: BoxDecoration(
                      color: Kolors.kPrimary,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              )),
        ),
        body: Container(
          color: Kolors.kOffWhite,
          height: ScreenUtil().screenHeight,
          child: TabBarView(controller: _tabController, children: const [
            OrderWidget(
              ordersTypes: FetchOrdersTypes.pending,
            ),
            OrderWidget(ordersTypes: FetchOrdersTypes.delivered),
            OrderWidget(ordersTypes: FetchOrdersTypes.cancelled),
          ]),
        ),
      ),
    );
  }
}
