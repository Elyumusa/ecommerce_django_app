import 'package:e_commerce_site_django/common/models/api_error_model.dart';
import 'package:e_commerce_site_django/common/services/storage.dart';
import 'package:e_commerce_site_django/common/utils/environment.dart';
import 'package:e_commerce_site_django/common/widgets/error_modal.dart';
import 'package:e_commerce_site_django/src/addresses/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class AddressNotifier with ChangeNotifier {
  AddressModel? address;
  Function refetchA = () {};

  void setRefetch(Function r) {
    refetchA = r;
    print("Lakers");
  }

  void setAddress(AddressModel a) {
    address = a;
    notifyListeners();
  }

  void clearAddress() {
    address = null;
    notifyListeners();
  }

  List<String> adddressTypes = ['Home', 'School', 'Office'];

  String _addressType = '';
  void setAddressType(String a) {
    _addressType = a;
    notifyListeners();
  }

  String get addressType => _addressType;

  void clearAddressType() {
    _addressType = '';
  }

  bool _defaultToggle = false;

  void setDefaultToggle(bool d) {
    _defaultToggle = d;
    notifyListeners();
  }

  bool get defaultToggle => _defaultToggle;

  void clearDefaultToggle(bool d) {
    _defaultToggle = false;
    notifyListeners();
  }

  void setAsDefault(int id, Function refetch, BuildContext context) async {
    String? accessToken = Storage().getString('accessToken');
    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/address/default/?id=$id');
      final response = await http.patch(url, headers: {
        'Authorization': 'Token $accessToken',
        'Content-Type': 'application/json'
      });
      if (response.statusCode == 200) {
        refetch();
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        var data = apiErrorFromJson(response.body);
        showErrorPopup(context, data.message, "Error Changing address", true);
        print("Error $data");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void deleteAddress(int id, Function refetch, BuildContext context) async {
    String? accessToken = Storage().getString('accessToken');
    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/address/delete/?id=$id');
      final response = await http.delete(url, headers: {
        'Authorization': 'Token $accessToken',
        'Content-Type': 'application/json'
      });
      if (response.statusCode == 200) {
        refetch();
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        var data = apiErrorFromJson(response.body);
        showErrorPopup(context, data.message, "Error deleting address", true);
        print("Error $data");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void addAddress(String data, BuildContext context) async {
    String? accessToken = Storage().getString('accessToken');
    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/address/add');
      final response = await http.post(url, body: data, headers: {
        'Authorization': 'Token $accessToken',
        'Content-Type': 'application/json'
      });
      if (response.statusCode == 201) {
        refetchA();
        context.pop();
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        print("Error $data");
      }
    } catch (e) {
      debugPrint(e.toString());
      showErrorPopup(context, e.toString(), "Error deleting address", true);
    }
  }
}
