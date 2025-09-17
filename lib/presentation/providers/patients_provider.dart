import 'package:ayurvedic_clinic_app/api_services.dart';
import 'package:ayurvedic_clinic_app/data/models/patient_model.dart';
import 'package:flutter/material.dart';

class PatientProvider with ChangeNotifier {
  final ApiService apiService;

  PatientProvider({required this.apiService});

  List<Patient> _patients = [];
  List<Patient> get patients => _patients;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchPatients() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final patientsList = await apiService.getPatients();

      if (patientsList.isEmpty) {
        _error = "No patients found"; 
      }

      _patients = patientsList;
    } catch (e, stack) {
      _error = "Failed to load patients: $e";
      debugPrint("Error in fetchPatients: $e");
      debugPrint("Stack trace: $stack"); 
      _patients = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
