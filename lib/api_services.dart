import 'package:ayurvedic_clinic_app/data/models/patient_model.dart';
import 'package:ayurvedic_clinic_app/data/models/treatment_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://flutter-amr.noviindus.in/api/"));

  String? _token;

  void setToken(String token) {
    _token = token;
    _dio.options.headers["Authorization"] = "Bearer $token";
  }

  Future<String?> login(String username, String password) async {
    try {
      final response = await _dio.post(
        "Login",
        data: FormData.fromMap({
          "username": username,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final token = response.data["token"];
        setToken(token);
        return token;
      }
    } catch (e) {
      print("Login error: $e");
    }
    return null;
  }

   Future<List<Patient>> getPatients() async {
    try {
      final response = await _dio.get("PatientList");

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> data = response.data;
        return Patient.fromJsonList(data);
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching patients: $e");
      return [];
    }
  }

  Future<bool> updatePatient(Map<String, dynamic> patientData) async {
    final response = await _dio.post(
      "PatientUpdate",
      data: FormData.fromMap(patientData),
    );
    return response.statusCode == 200;
  }

  Future<List<dynamic>> getBranches() async {
    final response = await _dio.get("BranchList");
    return response.data ?? [];
  }

  Future<List<Treatment>> getTreatments() async {
  try {
    final response = await _dio.get("TreatmentList");
    if (response.statusCode == 200 && response.data != null) {
      return Treatment.fromJsonList(response.data);
    } else {
      return [];
    }
  } catch (e) {
    print("Error fetching treatments: $e");
    return [];
  }
}

}
