import 'dart:convert';

import 'package:e_commerce_site_django/common/services/storage.dart';
import 'package:e_commerce_site_django/common/utils/environment.dart';
import 'package:e_commerce_site_django/common/utils/kstrings.dart';
import 'package:e_commerce_site_django/common/widgets/error_modal.dart';
import 'package:e_commerce_site_django/src/auth/models/auth_token_model.dart';
import 'package:e_commerce_site_django/src/auth/models/profile_model.dart';
import 'package:e_commerce_site_django/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AuthNotifier with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  bool _isRLoading = false;
  bool get isRLoading => _isRLoading;
  void setRLoading() {
    _isRLoading = !_isRLoading;
    notifyListeners();
  }

  void loginFunc(String data, BuildContext context) async {
    setLoading();

    try {
      var response = await http.post(
          Uri.parse("${Environment.appBaseUrl}/auth/token/login"),
          headers: {"Content-Type": 'application/json'},
          body: data);
      //3print("${Environment.appBaseUrl}/auth/token/login ${response.body}");
      if (response.statusCode == 200) {
        String accessToken = accessTokenFromJson(response.body).authToken;
        Storage().setString('accessToken', accessToken);
        print("AccessT: $accessToken");
        //TODO: Get user info
        //TODO: Get user extras
        getUser(accessToken, context);
        setLoading();
      }
    } catch (e) {
      setLoading();
      print("${Environment.appBaseUrl}/auth/token/login ${e.toString()}");
      showErrorPopup(context, AppText.kErrorLogin, null, null);
    }
  }

  void registrationFunc(String data, BuildContext context) async {
    setRLoading();
    try {
      var response = await http.post(
          Uri.parse("${Environment.appBaseUrl}/auth/users/"),
          headers: {"Content-Type": 'application/json'},
          body: data);
      if (response.statusCode == 201) {
        //TODO: Get user info
        //TODO: Get user extras
        setRLoading();
        context.pop();
      } else if (response.statusCode == 400) {
        setRLoading();
        var data = jsonDecode(response.body);
        showErrorPopup(context, data['password'][0], null, null);
      }
    } catch (e) {
      setRLoading();
      showErrorPopup(context, AppText.kErrorLogin, null, null);
    }
  }

  void getUser(String accessToken, BuildContext context) async {
    try {
      var response = await http.get(
        Uri.parse("${Environment.appBaseUrl}/auth/users/me"),
        headers: {
          "Content-Type": 'application/json',
          "Authorization": 'Token $accessToken'
        },
      );
      if (response.statusCode == 200) {
        print('getUser: ${response.body}');
        Storage().setString(accessToken, response.body);
        context.read<TabIndexNotifier>().setIndex(0);
        context.go('/home');
      }
    } catch (e) {
      setLoading();
      showErrorPopup(context, AppText.kErrorLogin, null, null);
    }
  }

  ProfileModel? getUserData() {
    String? accessToken = Storage().getString('accessToken');
    if (accessToken != null) {
      var data = Storage().getString(accessToken);
      if (data != null) {
        return profileModelFromJson(data);
      }
    }
    return null;
  }
}
