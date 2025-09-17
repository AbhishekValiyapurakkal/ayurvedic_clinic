import 'package:ayurvedic_clinic_app/api_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final ApiService apiService;

  AuthProvider({required this.apiService});

  String? _token;
  bool _isLoading = false;

  String? get token => _token;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _token != null && _token!.isNotEmpty;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    final token = await apiService.login(username, password);
    _isLoading = false;

    if (token != null) {
      _token = token;
      apiService.setToken(token);
      await _persistToken(token);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedToken = prefs.getString('auth_token');
    if (savedToken != null && savedToken.isNotEmpty) {
      _token = savedToken;
      apiService.setToken(savedToken);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _token = null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    notifyListeners();
  }

  Future<void> _persistToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  ApiService get api => apiService;
}
