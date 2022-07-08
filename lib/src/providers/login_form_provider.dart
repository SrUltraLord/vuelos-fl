import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  String email = 'dareyes6@espe.edu.ec';
  String password = 'david123';

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
