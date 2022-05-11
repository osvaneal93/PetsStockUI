import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:cann_app/data/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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

  Future<String> uploadImage(XFile image) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/de5chleeg/image/upload?upload_preset=x9zheq8h');
    final List mimetype = mime(image.path)!.split('/');
    final uploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath(
      'file',
      image.path,
      contentType: MediaType(
        mimetype[0],
        mimetype[1],
      ),
    );
    uploadRequest.files.add(file);
    
    final streamResponse = await uploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201){
      print ('algo salio maaaaaaaaaaal');
      print (resp.body);
    }
    final respData = json.decode(resp.body);
    print(respData['secure_url']);
    return respData['secure_url'];
  }
}
