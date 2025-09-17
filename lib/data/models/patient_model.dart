class Patient {
  final int id;
  final String name;
  final int age;
  final String treatment;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.treatment,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      treatment: json['treatment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'name': name,
      'age': age.toString(),
      'treatment': treatment,
    };
  }

  static List<Patient> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Patient.fromJson(json)).toList();
  }
}
