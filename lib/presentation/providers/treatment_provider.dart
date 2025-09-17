import 'package:ayurvedic_clinic_app/api_services.dart';
import 'package:flutter/material.dart';

class TreatmentProvider with ChangeNotifier {
  final ApiService api;

  TreatmentProvider(this.api);

  List<dynamic> _treatments = [];
  List<dynamic> get treatments => _treatments;

  Future<void> fetchPatients() async {
    _treatments = await api.getPatients();
    notifyListeners();
  }
}
