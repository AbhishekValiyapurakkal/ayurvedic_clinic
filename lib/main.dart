import 'package:ayurvedic_clinic_app/api_services.dart';
import 'package:ayurvedic_clinic_app/presentation/providers/branch_provider.dart';
import 'package:ayurvedic_clinic_app/presentation/providers/patients_provider.dart';
import 'package:ayurvedic_clinic_app/presentation/providers/treatment_provider.dart';
import 'package:ayurvedic_clinic_app/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService(); // shared instance

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PatientProvider(apiService: apiService),
        ),
        ChangeNotifierProvider(
          create: (_) => BranchProvider(apiService: apiService),
        ),
        ChangeNotifierProvider(
          create: (_) => TreatmentProvider(apiService: apiService),
        ),
      ],
      child: MaterialApp(
        title: 'Ayurvedic Clinic App',
        home: SplashScreen(),
      ),
    );
  }
}