import 'package:ayurvedic_clinic_app/services/api_services.dart';
import 'package:ayurvedic_clinic_app/presentation/providers/branch_provider.dart';
import 'package:ayurvedic_clinic_app/presentation/providers/patients_provider.dart';
import 'package:ayurvedic_clinic_app/presentation/providers/registerPatients_provider.dart';
import 'package:ayurvedic_clinic_app/presentation/providers/treatment_provider.dart';
import 'package:ayurvedic_clinic_app/presentation/providers/auth_provider.dart';
import 'package:ayurvedic_clinic_app/presentation/screens/splash_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService();

  MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(apiService: apiService),
        ),
        ChangeNotifierProvider(
          create: (_) => PatientProvider(apiService: apiService),
        ),
        ChangeNotifierProvider(
          create: (_) => BranchProvider(apiService: apiService),
        ),
        ChangeNotifierProvider(
          create: (_) => TreatmentProvider(apiService: apiService),
        ),
        ChangeNotifierProvider(
      create: (context) => RegisterPatientProvider(
        dio: Dio(BaseOptions(
          baseUrl: "https://flutter-amr.noviindus.in/api/",
        )),
      ),
    ),
      ],
      child: MaterialApp(
        title: 'Ayurvedic Clinic App',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(apiService: apiService),
      ),
    );
  }
}
