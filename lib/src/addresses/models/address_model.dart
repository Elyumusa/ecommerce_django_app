import 'dart:convert';

List<AddressModel> addressListModelFromJson(String str) =>
    List<AddressModel>.from(
        json.decode(str).map((x) => AddressModel.fromJson(x)));

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

class AddressModel {
  final int id;
  final double lat;
  final double log;
  final bool isDefault;
  final String address;
  final String phone;
  final String addressType;
  final int userId;

  AddressModel({
    required this.id,
    required this.lat,
    required this.log,
    required this.isDefault,
    required this.address,
    required this.phone,
    required this.addressType,
    required this.userId,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        lat: json["lat"]?.toDouble(),
        log: json["log"]?.toDouble(),
        isDefault: json["isDefault"],
        address: json["address"],
        phone: json["phone"],
        addressType: json["addressType"],
        userId: json["userId"],
      );
}
