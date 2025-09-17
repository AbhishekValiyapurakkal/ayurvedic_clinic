import 'package:ayurvedic_clinic_app/api_services.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _api = ApiService();

  String? _token;
  bool _isLoading = false;

  String? get token => _token;
  bool get isLoading => _isLoading;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    final token = await _api.login(username, password);
    _isLoading = false;

    if (token != null) {
      _token = token;
      notifyListeners();
      return true;
    }
    return false;
  }

  ApiService get api => _api;
}
