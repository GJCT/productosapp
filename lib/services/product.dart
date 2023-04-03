import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:productosapp/models/models.dart';
import 'package:http/http.dart' as http;

class ProductServices extends ChangeNotifier{

  final String _baseUrl = 'fluttersapp-f2da6-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectedProduct;

  final storage = const FlutterSecureStorage();
  
  bool loading = true;
  bool save = false;

  File? newPicture;

  ProductServices(){
    loadProduct();
  }

  Future<List<Product>> loadProduct() async{
    loading = true;
    notifyListeners();
    
    final url = Uri.https(_baseUrl, 'products.json',{
      'auth': await storage.read(key: 'idToken') ?? ''
    });
    final resp = await http.get(url);

    final productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) async {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    loading = false;
    notifyListeners();

    return products;


  }

  Future saveProduct(Product product) async{
    save = true;
    notifyListeners();

    if(product.id == null){
      await create(product);
    }else {
      await update(product);
    }

    save = false;
    notifyListeners();

  }

  Future<String> update(Product product) async{
    final url = Uri.https(_baseUrl, 'products/${product.id}.json',{
      'auth': await storage.read(key: 'idToken') ?? ''
    });
    final resp = await http.put(url, body: product.toJson());
    final decodedData = resp.body;

    print(decodedData);

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;

  }

  Future<String> create(Product product) async{
    final url = Uri.https(_baseUrl, 'products.json',{
      'auth': await storage.read(key: 'idToken') ?? ''
    });
    final resp = await http.post(url, body: product.toJson());
    final decodedData = json.decode(resp.body);

    product.id = decodedData['name'];
    print(decodedData);

    //products.add(product);

    return product.id!;

  }

  void updateSelectedImg(String path) {
    
    selectedProduct.picture = path;

    newPicture = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<String?> uploadImg() async{
    if(newPicture == null) return null;

    save = true;
    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dvkwkczpb/image/upload?upload_preset=zj16x4jq');

    final imageRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', newPicture!.path);

    imageRequest.files.add(file);

    final streamResponse = await imageRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode != 200 && resp.statusCode != 201){
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    newPicture = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];

    
  }

}