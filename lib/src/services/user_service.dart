import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:vuelos_fl/src/environment/constants.dart';
import 'package:vuelos_fl/src/models/responses/login_response.dart';
import 'package:vuelos_fl/src/services/notifications_service.dart';

import '../models/user.dart';

class UserService extends ChangeNotifier {
  final serverUrl = Constants.serverUrl;

  bool isLoading = false;
  User? user;

  Future<LoginResponse?> loginWithEmailAndPassword(
      String email, String password) async {
    isLoading = true;
    notifyListeners();

    final Map<String, String> userData = {'email': email, 'password': password};

    try {
      final url = Uri.http(serverUrl, 'user/login');
      final resp = await http.put(url,
          body: jsonEncode(userData),
          encoding: Encoding.getByName('utf-8'),
          headers: {'content-type': 'application/json'});

      LoginResponse loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.data;

      return loginResponse;
    } catch (e) {
      NotificationsService.showSnackbar('Algo ha salido mal');
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
