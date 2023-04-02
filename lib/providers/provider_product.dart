import 'package:flutter/material.dart';
import 'package:productosapp/models/models.dart';

class ProductFormProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  Product product;

  ProductFormProvider(this.product);

  updateAvailability(bool value){
    print(value);
    product.available = value;
    notifyListeners();
  }

  bool validForm(){
    print(product.name);
    print(product.price);
    print(product.available);
    
    return formKey.currentState?.validate() ?? false;
  }
}