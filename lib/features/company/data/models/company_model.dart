class CompanyModel {
  final String id;
  final String name;

  CompanyModel({
    required this.id,
    required this.name,
  });

  factory CompanyModel.fromMap(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
