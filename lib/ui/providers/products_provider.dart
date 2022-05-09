import 'dart:convert';

import 'package:cann_app/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductsProvider {
  final url = 'https://productsdb-2b599-default-rtdb.firebaseio.com';

  Future<bool> addProduct(ProductModel productModel) async {
    final uri = Uri.parse('$url/product.json');
    final resp = await http.post(
      uri,
      body: productModelToJson(productModel),
    );
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<List<ProductModel>> getProduct() async {
    final uri = Uri.parse('$url/product.json');
    final resp = await http.get(uri);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductModel> productList = [];

    decodedData.forEach((key, i) {
      final tempProduct = ProductModel.fromJson(i);
      tempProduct.id = key;
      productList.add(tempProduct);
    });
    return productList;
  }

  Future<bool> deleteProduct(String id) async {
    final uri = Uri.parse('$url/product/$id.json');
    final resp = await http.delete(uri);
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<bool> updateProduct(ProductModel productModel, String id) async {
    final uri = Uri.parse('$url/product/$id.json');
    final resp = await http.put(
      uri,
      body: productModelToJson(productModel),
    );
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

}
