import 'package:ayurvedic_clinic_app/api_services.dart';
import 'package:ayurvedic_clinic_app/data/models/treatment_model.dart';
import 'package:flutter/material.dart';

class TreatmentProvider with ChangeNotifier {
  final ApiService apiService;

  TreatmentProvider({required this.apiService});

  List<Treatment> _treatments = [];
  List<Treatment> get treatments => _treatments;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  // Fetch treatment list
  Future<void> fetchTreatments() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _treatments = await apiService.getTreatments();
    } catch (e) {
      _error = "Failed to load treatments: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
