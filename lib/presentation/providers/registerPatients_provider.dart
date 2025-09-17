import 'package:ayurvedic_clinic_app/data/models/register_patients_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class RegisterPatientProvider with ChangeNotifier {
  final Dio _dio = Dio(
  BaseOptions(baseUrl: "https://flutter-amr.noviindus.in/api/"),
);


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _success = false;
  bool get success => _success;

  Future<void> registerPatient(RegisterPatientRequest request) async {
  _isLoading = true;
  _success = false;
  _errorMessage = null;
  notifyListeners();

  try {
    final response = await _dio.post("PatientUpdate", data: request.toJson());


    if (response.statusCode == 200 && response.data["status"] == true) {
      _success = true;
    } else {
      _errorMessage = response.data["message"] ??
          "Failed with status: ${response.statusCode}";
    }
  } catch (e) {
    _errorMessage = "Error: $e";
  }

  _isLoading = false;
  notifyListeners();
}

}
