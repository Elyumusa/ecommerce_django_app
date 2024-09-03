import 'package:meta/meta.dart';
import 'dart:convert';

CreateCartModel createCartModelFromJson(String str) => CreateCartModel.fromJson(json.decode(str));

String createCartModelToJson(CreateCartModel data) => json.encode(data.toJson());

class CreateCartModel {
    final int product;
    final int quantity;
    final String color;
    final String size;

    CreateCartModel({
        required this.product,
        required this.quantity,
        required this.color,
        required this.size,
    });

    factory CreateCartModel.fromJson(Map<String, dynamic> json) => CreateCartModel(
        product: json["product"],
        quantity: json["quantity"],
        color: json["color"],
        size: json["size"],
    );

    Map<String, dynamic> toJson() => {
        "product": product,
        "quantity": quantity,
        "color": color,
        "size": size,
    };
}