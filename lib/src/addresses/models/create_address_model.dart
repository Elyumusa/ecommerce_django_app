// To parse this JSON data, do
//
//     final createAddress = createAddressFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateAddress createAddressFromJson(String str) => CreateAddress.fromJson(json.decode(str));

String createAddressToJson(CreateAddress data) => json.encode(data.toJson());

class CreateAddress {
    final double lat;
    final double log;
    final bool isDefault;
    final String address;
    final String phone;
    final String addressType;

    CreateAddress({
        required this.lat,
        required this.log,
        required this.isDefault,
        required this.address,
        required this.phone,
        required this.addressType,
    });

    factory CreateAddress.fromJson(Map<String, dynamic> json) => CreateAddress(
        lat: json["lat"]?.toDouble(),
        log: json["log"]?.toDouble(),
        isDefault: json["isDefault"],
        address: json["address"],
        phone: json["phone"],
        addressType: json["addressType"],
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "log": log,
        "isDefault": isDefault,
        "address": address,
        "phone": phone,
        "addressType": addressType,
    };
}
