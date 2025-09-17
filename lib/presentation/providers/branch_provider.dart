import 'package:ayurvedic_clinic_app/api_services.dart';
import 'package:flutter/material.dart';

class BranchProvider extends ChangeNotifier {
  final ApiService api;

  BranchProvider(this.api);

  List<dynamic> _branches = [];
  List<dynamic> get branches => _branches;

  Future<void> fetchBranches() async {
    _branches = await api.getBranches();
    notifyListeners();
  }
}
