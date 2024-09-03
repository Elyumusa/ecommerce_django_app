import 'package:e_commerce_site_django/common/utils/kcolors.dart';
import 'package:e_commerce_site_django/common/widgets/app_style.dart';
import 'package:e_commerce_site_django/common/widgets/back_button.dart';
import 'package:e_commerce_site_django/common/widgets/custom_button.dart';
import 'package:e_commerce_site_django/common/widgets/email_textfield.dart';
import 'package:e_commerce_site_django/common/widgets/password_field.dart';
import 'package:e_commerce_site_django/src/auth/controllers/auth_notifier.dart';
import 'package:e_commerce_site_django/src/auth/models/registration_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final TextEditingController _usernameController =
      TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passController = TextEditingController();
  final FocusNode _passwordNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _passController.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const AppBackButton(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 160.h,
          ),
          Text(
            "E Fashions",
            textAlign: TextAlign.center,
            style: appStyle(24, Kolors.kPrimary, FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text("Hi! Welcome back",
              textAlign: TextAlign.center,
              style: appStyle(13, Kolors.kGray, FontWeight.bold)),
          SizedBox(
            height: 25.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                EmailTextField(
                  radius: 25,
                  hintText: "Username",
                  controller: _usernameController,
                  prefixIcon: Icon(CupertinoIcons.profile_circled,
                      size: 20, color: Kolors.kGray),
                  keyboardType: TextInputType.name,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordNode);
                  },
                ),
                SizedBox(
                  height: 25.h,
                ),
                EmailTextField(
                  radius: 25,
                  focusNode: _passwordNode,
                  hintText: "Email",
                  controller: _emailController,
                  prefixIcon:
                      Icon(CupertinoIcons.mail, size: 20, color: Kolors.kGray),
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordNode);
                  },
                ),
                SizedBox(
                  height: 25.h,
                ),
                PasswordField(
                  controller: _passController,
                  focusNode: _passwordNode,
                  radius: 25,
                ),
                SizedBox(
                  height: 20.h,
                ),
                context.watch<AuthNotifier>().isRLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Kolors.kPrimary,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Kolors.kWhite),
                        ),
                      )
                    : CustomButton(
                        onTap: () {
                          RegistrationModel model = RegistrationModel(
                              password: _passController.text,
                              username: _usernameController.text,
                              email: _emailController.text);
                          String data = registrationModelToJson(model);
                          context
                              .read<AuthNotifier>()
                              .registrationFunc(data, context);
                        },
                        text: "SIGN UP",
                        btnWidth: ScreenUtil().screenWidth,
                        btnHieght: 40,
                        radius: 20,
                      )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 130.h,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 110.0),
            child: GestureDetector(
              onTap: () {
                context.push('/login');
              },
              child: Text(
                'Already have an account? Login instead',
                style: appStyle(12, Colors.blue, FontWeight.normal),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
