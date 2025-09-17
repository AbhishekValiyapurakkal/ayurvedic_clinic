import 'package:ayurvedic_clinic_app/api_services.dart';
import 'package:flutter/material.dart';

class PatientProvider with ChangeNotifier {
  final ApiService api;

  PatientProvider(this.api);

  List<dynamic> _patients = [];
  List<dynamic> get patients => _patients;

  Future<void> fetchPatients() async {
    _patients = await api.getPatients();
    notifyListeners();
  }
}
