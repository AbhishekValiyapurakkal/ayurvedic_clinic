import 'package:ayurvedic_clinic_app/api_services.dart';
import 'package:ayurvedic_clinic_app/presentation/providers/auth_provider.dart';
import 'package:ayurvedic_clinic_app/presentation/providers/patients_provider.dart';
import 'package:ayurvedic_clinic_app/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, PatientProvider>(
          create: (_) => PatientProvider(ApiService()),
          update: (_, auth, __) => PatientProvider(auth.api),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
