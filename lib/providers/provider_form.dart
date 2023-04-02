import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email    = '';
  String password = '';

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }


  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}