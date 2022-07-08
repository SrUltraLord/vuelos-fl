import 'package:flutter/material.dart';

class SearchFlightFormProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  String cityOrigin = '';
  String cityDestination = '';
  String dateFrom = '';
  String dateTo = '';

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
