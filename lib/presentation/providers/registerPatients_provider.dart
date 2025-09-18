import 'package:ayurvedic_clinic_app/data/models/register_patients_model.dart';
import 'package:ayurvedic_clinic_app/data/models/treatment_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPatientProvider with ChangeNotifier {
  final Dio _dio;
  String? _token;

  RegisterPatientProvider({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: "https://flutter-amr.noviindus.in/api/",
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30),
            ),
          ) {
    _initializeToken();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _success = false;
  bool get success => _success;

  Future<void> _initializeToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? savedToken = prefs.getString('auth_token');
      if (savedToken != null && savedToken.isNotEmpty) {
        _token = savedToken;
        _dio.options.headers["Authorization"] = "Bearer $savedToken";
      }
    } catch (e) {
      print("Error initializing token: $e");
    }
  }

  void setToken(String token) {
    _token = token;
    _dio.options.headers["Authorization"] = "Bearer $token";
    _persistToken(token);
  }

  Future<void> _persistToken(String token) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
    } catch (e) {
      print("Error persisting token: $e");
    }
  }

  Future<void> registerPatient(RegisterPatientRequest request) async {
    _isLoading = true;
    _success = false;
    _errorMessage = null;
    notifyListeners();

    try {
      if (_token == null) {
        await _initializeToken();

        if (_token == null) {
          _errorMessage = "Authentication required. Please login first.";
          _isLoading = false;
          notifyListeners();
          return;
        }
      }

      final response = await _dio.post(
        "PatientUpdate",
        data: request.toJson(),
        options: Options(
          headers: {
            "Authorization": "Bearer $_token",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          _success = true;
        } else {
          _errorMessage = response.data["message"] ?? "Registration failed";
        }
      } else {
        _errorMessage = "Server error: ${response.statusCode}";
      }
    } on DioException catch (e) {
      if (e.response != null) {
        _errorMessage =
            "Server error: ${e.response?.statusCode} - ${e.response?.data}";

        if (e.response?.statusCode == 401) {
          _token = null;
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove('auth_token');
        }
      } else {
        _errorMessage = "Network error: ${e.message}";
      }
    } catch (e) {
      _errorMessage = "Unexpected error: $e";
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  
  List<Treatment> _treatments = [];
  List<Treatment> get treatments => _treatments;
  
  String? _treatmentError;
  String? get treatmentError => _treatmentError;
  
  bool _isLoadingTreatments = false;
  bool get isLoadingTreatments => _isLoadingTreatments;

  Future<void> fetchTreatments() async {
    _isLoadingTreatments = true;
    _treatmentError = null;
    notifyListeners();

    try {
      final response = await _dio.get("TreatmentList");

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData = response.data;
        
        if (responseData['status'] == true) {
          final List<dynamic> treatmentsData = responseData['treatments'] ?? [];
          _treatments = Treatment.fromJsonList(treatmentsData);
        } else {
          _treatmentError = responseData['message'] ?? "Failed to load treatments";
        }
      } else {
        _treatmentError = "Failed to load treatments: ${response.statusCode}";
      }
    } on DioException catch (e) {
      _treatmentError = "Network error: ${e.message}";
    } catch (e) {
      _treatmentError = "Unexpected error: $e";
    }


    _isLoadingTreatments = false;
    notifyListeners();
  }
}
