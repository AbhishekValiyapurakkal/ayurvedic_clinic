import 'package:ayurvedic_clinic_app/data/models/branch_model.dart';
import 'package:ayurvedic_clinic_app/data/models/patient_model.dart';
import 'package:ayurvedic_clinic_app/data/models/register_patients_model.dart';
import 'package:ayurvedic_clinic_app/data/models/treatment_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: "https://flutter-amr.noviindus.in/api/"),
  );

  String? _token;

  void setToken(String token) {
    _token = token;
    _dio.options.headers["Authorization"] = "Bearer $token";
  }

  Future<String?> getToken() async {
    return _token;
  }

  Future<String?> login(String username, String password) async {
    try {
      final response = await _dio.post(
        "Login",
        data: FormData.fromMap({"username": username, "password": password}),
      );

      if (response.statusCode == 200) {
        final token = response.data["token"];
        if (token != null) {
          setToken(token);
          return token;
        }
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
        final List<dynamic> data = response.data["patient"] ?? [];
        return Patient.fromJsonList(data);
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching patients: $e");
      return [];
    }
  }

  Future<bool> registerPatient(RegisterPatientRequest request) async {
    try {
      final token = _token;
      if (token == null) {
        print("Register patient error: no token found. Please login first.");
        return false;
      }

      final response = await _dio.post(
        "PatientUpdate",
        data: FormData.fromMap(request.toJson()),
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        final status = response.data["status"];
        if (status == true) {
          print("Patient registered successfully");
          return true;
        } else {
          print("Registration failed: ${response.data["message"]}");
          return false;
        }
      } else {
        print("Error: ${response.statusCode} - ${response.statusMessage}");
        return false;
      }
    } catch (e) {
      print("Register patient error: $e");
      return false;
    }
  }

  Future<List<Branch>> getBranches() async {
    try {
      final response = await _dio.get("BranchList");

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData = response.data;

        if (responseData['status'] == true) {
          final List<dynamic> branchesData = responseData['branches'] ?? [];
          return Branch.fromJsonList(branchesData);
        } else {
          throw Exception(
            'API returned false status: ${responseData['message']}',
          );
        }
      } else {
        throw Exception('Failed to load branches: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print("Error fetching branches: $e");
      if (e.response != null) {
        throw Exception('Server error: ${e.response?.statusCode}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      print("Unexpected error fetching branches: $e");
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<Treatment>> getTreatments() async {
  try {
    final response = await _dio.get("TreatmentList");

    if (response.statusCode == 200 && response.data != null) {
      final Map<String, dynamic> responseData = response.data;
      
      final treatmentResponse = TreatmentResponse.fromJson(responseData);
      
      if (treatmentResponse.status) {
        return treatmentResponse.treatments;
      } else {
        throw Exception('API returned false status: ${treatmentResponse.message}');
      }
    } else {
      throw Exception('Failed to load treatments: ${response.statusCode}');
    }
  } on DioException catch (e) {
    print("Error fetching treatments: $e");
    if (e.response != null) {
      throw Exception('Server error: ${e.response?.statusCode} - ${e.response?.data}');
    } else {
      throw Exception('Network error: ${e.message}');
    }
  } catch (e) {
    print("Unexpected error fetching treatments: $e");
    throw Exception('Unexpected error: $e');
  }
}
}
