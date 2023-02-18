class Contact {
  String? phone;
  String? fullName;
  int? id;
  Contact({required this.phone, required this.fullName});

  Contact.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    fullName = json['fullName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['fullName'] = this.fullName;
    return data;
  }
}
