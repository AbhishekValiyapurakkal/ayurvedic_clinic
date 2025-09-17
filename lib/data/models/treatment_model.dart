import 'package:ayurvedic_clinic_app/data/models/branch_model.dart';

class Treatment {
  final int id;
  final List<Branch> branches;
  final String name;
  final String duration;
  final String price;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Treatment({
    required this.id,
    required this.branches,
    required this.name,
    required this.duration,
    required this.price,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      id: json['id'] as int? ?? 0,
      branches: (json['branches'] as List<dynamic>?)
          ?.map((branchJson) => Branch.fromJson(branchJson))
          .toList() ?? [],
      name: json['name'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      price: json['price'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? false,
      createdAt: json['created_at'] != null 
          ? DateTime.tryParse(json['created_at']) 
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.tryParse(json['updated_at']) 
          : null,
    );
  }

  static List<Treatment> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Treatment.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'branches': branches.map((branch) => branch.toJson()).toList(),
      'name': name,
      'duration': duration,
      'price': price,
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Treatment{id: $id, name: $name, duration: $duration, price: $price}';
  }
}

class TreatmentResponse {
  final bool status;
  final String message;
  final List<Treatment> treatments;

  TreatmentResponse({
    required this.status,
    required this.message,
    required this.treatments,
  });

  factory TreatmentResponse.fromJson(Map<String, dynamic> json) {
    return TreatmentResponse(
      status: json['status'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      treatments: (json['treatments'] as List<dynamic>?)
          ?.map((treatmentJson) => Treatment.fromJson(treatmentJson))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'treatments': treatments.map((treatment) => treatment.toJson()).toList(),
    };
  }
}