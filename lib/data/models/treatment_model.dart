class Treatment {
  final String name;

  Treatment({required this.name});

  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      name: json['name'],
    );
  }

  static List<Treatment> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Treatment.fromJson(json)).toList();
  }
}
