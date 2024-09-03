import 'package:e_commerce_site_django/common/utils/app_routes.dart';
import 'package:e_commerce_site_django/common/utils/environment.dart';
import 'package:e_commerce_site_django/common/utils/kstrings.dart';
import 'package:e_commerce_site_django/src/addresses/controllers/address_notifier.dart';
import 'package:e_commerce_site_django/src/auth/controllers/auth_notifier.dart';
import 'package:e_commerce_site_django/src/auth/controllers/password_notifier.dart';
import 'package:e_commerce_site_django/src/cart/controllers/cart_notifier.dart';
import 'package:e_commerce_site_django/src/categories/controllers/category_notifier.dart';
import 'package:e_commerce_site_django/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:e_commerce_site_django/src/home/controllers/home_tab_notifier.dart';
import 'package:e_commerce_site_django/src/notifications/controllers/notification_notifier.dart';
import 'package:e_commerce_site_django/src/onboarding/controllers/onboarding_nofier.dart';
import 'package:e_commerce_site_django/src/products/controllers/colors_sizes_notifier.dart';
import 'package:e_commerce_site_django/src/products/controllers/product_notifier.dart';
import 'package:e_commerce_site_django/src/reviews/controllers/rating_notifier.dart';
import 'package:e_commerce_site_django/src/search/controllers/search_notifier.dart';
import 'package:e_commerce_site_django/src/splashscreen/views/splashscreen_page.dart';
import 'package:e_commerce_site_django/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //load the correct environment
  await dotenv.load(fileName: Environment.fileName);

  GetStorage.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => OnboardingNotifier()),
      ChangeNotifierProvider(create: (_) => TabIndexNotifier()),
      ChangeNotifierProvider(create: (_) => CategoryNotifier()),
      ChangeNotifierProvider(create: (_) => HomeTabNotifier()),
      ChangeNotifierProvider(create: (_) => ProductNotifier()),
      ChangeNotifierProvider(create: (_) => ColorSizesNotifier()),
      ChangeNotifierProvider(create: (_) => PasswordNotifier()),
      ChangeNotifierProvider(create: (_) => AuthNotifier()),
      ChangeNotifierProvider(create: (_) => SearchNotifier()),
      ChangeNotifierProvider(create: (_) => WishListNotifier()),
      ChangeNotifierProvider(create: (_) => CartNotifier()),
      ChangeNotifierProvider(create: (_) => AddressNotifier()),
      ChangeNotifierProvider(create: (_) => NotificationNotifier()),
      ChangeNotifierProvider(create: (_) => RatingNotifier()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: screenSize,
      minTextAdapt: true,
      splitScreenMode: false,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppText.kAppName,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: router,
        );
      },
      child: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Environment.apiKey,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
