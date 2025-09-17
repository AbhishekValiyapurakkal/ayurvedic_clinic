class Branch {
  final int id;
  final String name;
  final int patientsCount;
  final String location;
  final String phone;
  final String mail;
  final String address;
  final String gst;
  final bool isActive;

  Branch({
    required this.id,
    required this.name,
    required this.patientsCount,
    required this.location,
    required this.phone,
    required this.mail,
    required this.address,
    required this.gst,
    required this.isActive,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      patientsCount: json['patients_count'] as int? ?? 0,
      location: json['location'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      mail: json['mail'] as String? ?? '',
      address: json['address'] as String? ?? '',
      gst: json['gst'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? false,
    );
  }

  static List<Branch> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Branch.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'patients_count': patientsCount,
      'location': location,
      'phone': phone,
      'mail': mail,
      'address': address,
      'gst': gst,
      'is_active': isActive,
    };
  }

  @override
  String toString() {
    return 'Branch{id: $id, name: $name, patientsCount: $patientsCount, location: $location, phone: $phone, mail: $mail, address: $address, gst: $gst, isActive: $isActive}';
  }
}