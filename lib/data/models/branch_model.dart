class Branch {
  final String name;

  Branch({required this.name});

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      name: json['name'],
    );
  }

  static List<Branch> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Branch.fromJson(json)).toList();
  }
}
