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

  Future<List<dynamic>> getPatients() async {
    final response = await _dio.get("PatientList");
    return response.data ?? [];
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

  Future<List<dynamic>> getTreatments() async {
    final response = await _dio.get("TreatmentList");
    return response.data ?? [];
  }
}
