import 'package:e_commerce_site_django/common/services/storage.dart';
import 'package:e_commerce_site_django/common/utils/kcolors.dart';
import 'package:e_commerce_site_django/const/resource.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    _navigator();
    super.initState();
  }

  _navigator() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {
      if (Storage().getBool("firstOpen") == null) {
        //Go To Onboarding Screen
        GoRouter.of(context).go("/onboarding");
      } else {
        //Go to home page
        GoRouter.of(context).go("/home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kolors.kWhite,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(R.ASSETS_IMAGES_SPLASHSCREEN_PNG))),
      ),
    );
  }
}
