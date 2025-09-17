class PatientDetail {
  final int id;
  final String male;
  final String female;
  final int patientId;
  final String? treatment;

  PatientDetail({
    required this.id,
    required this.male,
    required this.female,
    required this.patientId,
    this.treatment,
  });

  factory PatientDetail.fromJson(Map<String, dynamic> json) {
    return PatientDetail(
      id: json['id'] is String
          ? int.tryParse(json['id']) ?? 0
          : (json['id'] ?? 0),
      male: json['male']?.toString() ?? "",
      female: json['female']?.toString() ?? "",
      patientId: json['patient'] is String
          ? int.tryParse(json['patient']) ?? 0
          : (json['patient'] ?? 0),
      treatment: json['treatment']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'male': male,
      'female': female,
      'patient': patientId,
      'treatment': treatment,
    };
  }
}

class Patient {
  final int id;
  final List<PatientDetail> patientDetails;
  final String? branch;
  final String user;
  final String payment;
  final String name;
  final String phone;
  final String address;
  final double? price;
  final double totalAmount;
  final double discountAmount;
  final double advanceAmount;
  final double balanceAmount;
  final String? dateAndTime;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  Patient({
    required this.id,
    required this.patientDetails,
    this.branch,
    required this.user,
    required this.payment,
    required this.name,
    required this.phone,
    required this.address,
    this.price,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    this.dateAndTime,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] is String
          ? int.tryParse(json['id']) ?? 0
          : (json['id'] ?? 0),
      patientDetails:
          (json['patientdetails_set'] as List<dynamic>?)
              ?.map((e) => PatientDetail.fromJson(e))
              .toList() ??
          [],
      branch: json['branch']?.toString(),
      user: json['user'] ?? "",
      payment: json['payment'] ?? "",
      name: json['name'] ?? "",
      phone: json['phone'] ?? "",
      address: json['address'] ?? "",
      price: json['price'] != null
          ? double.tryParse(json['price'].toString())
          : null,
      totalAmount: double.tryParse(json['total_amount'].toString()) ?? 0.0,
      discountAmount:
          double.tryParse(json['discount_amount'].toString()) ?? 0.0,
      advanceAmount: double.tryParse(json['advance_amount'].toString()) ?? 0.0,
      balanceAmount: double.tryParse(json['balance_amount'].toString()) ?? 0.0,
      dateAndTime: json['date_nd_time']?.toString(),
      isActive: (json['is_active'] is bool)
          ? json['is_active']
          : (json['is_active']?.toString() == '1' ||
                json['is_active']?.toString().toLowerCase() == 'true'),
      createdAt: json['created_at']?.toString() ?? "",
      updatedAt: json['updated_at']?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientdetails_set': patientDetails.map((e) => e.toJson()).toList(),
      'branch': branch,
      'user': user,
      'payment': payment,
      'name': name,
      'phone': phone,
      'address': address,
      'price': price,
      'total_amount': totalAmount,
      'discount_amount': discountAmount,
      'advance_amount': advanceAmount,
      'balance_amount': balanceAmount,
      'date_nd_time': dateAndTime,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  static List<Patient> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Patient.fromJson(json)).toList();
  }
}
