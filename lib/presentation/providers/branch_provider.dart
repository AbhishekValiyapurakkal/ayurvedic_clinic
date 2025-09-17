import 'package:ayurvedic_clinic_app/api_services.dart';
import 'package:ayurvedic_clinic_app/data/models/branch_model.dart';
import 'package:flutter/material.dart';

class BranchProvider with ChangeNotifier {
  final ApiService apiService;

  BranchProvider({required this.apiService});

  List<Branch> _branches = [];
  List<Branch> get branches => _branches;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchBranches() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _branches = await apiService.getBranches();
    } catch (e) {
      _error = "Failed to load branches: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
