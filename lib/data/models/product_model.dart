// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    ProductModel({
        this.id,
        this.name = 'Ej. Camisa',
        this.value = 0,
        this.disponible = true,
        this.fotoUrl,
    });

    String? id;
    String? name;
    int? value;
    bool? disponible;
    String? fotoUrl;

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        value: json["valor"],
        disponible: json["disponible"],
        fotoUrl: json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "valor": value,
        "disponible": disponible,
        "fotoUrl": fotoUrl,
    };
}
