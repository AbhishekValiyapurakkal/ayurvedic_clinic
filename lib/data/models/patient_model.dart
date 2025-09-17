class Patient {
  final int id;
  final String name;
  final String whatsappNumber;
  final String address;
  final String location;
  final String branch;
  final String treatments;
  final double totalAmount;
  final double discountAmount;
  final String paymentOption;
  final double advanceAmount;
  final double balanceAmount;
  final String treatmentDate;
  final String treatmentTime;

  Patient({
    required this.id,
    required this.name,
    required this.whatsappNumber,
    required this.address,
    required this.location,
    required this.branch,
    required this.treatments,
    required this.totalAmount,
    required this.discountAmount,
    required this.paymentOption,
    required this.advanceAmount,
    required this.balanceAmount,
    required this.treatmentDate,
    required this.treatmentTime,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      whatsappNumber: json['whatsapp_number'],
      address: json['address'],
      location: json['location'],
      branch: json['branch'],
      treatments: json['treatments'],
      totalAmount: double.tryParse(json['total_amount'].toString()) ?? 0.0,
      discountAmount: double.tryParse(json['discount_amount'].toString()) ?? 0.0,
      paymentOption: json['payment_option'],
      advanceAmount: double.tryParse(json['advance_amount'].toString()) ?? 0.0,
      balanceAmount: double.tryParse(json['balance_amount'].toString()) ?? 0.0,
      treatmentDate: json['treatment_date'],
      treatmentTime: json['treatment_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'name': name,
      'whatsapp_number': whatsappNumber,
      'address': address,
      'location': location,
      'branch': branch,
      'treatments': treatments,
      'total_amount': totalAmount.toString(),
      'discount_amount': discountAmount.toString(),
      'payment_option': paymentOption,
      'advance_amount': advanceAmount.toString(),
      'balance_amount': balanceAmount.toString(),
      'treatment_date': treatmentDate,
      'treatment_time': treatmentTime,
    };
  }

  static List<Patient> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Patient.fromJson(json)).toList();
  }
}
