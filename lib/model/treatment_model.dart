class TreatmentModel {
  final int id;
  final String name;

  TreatmentModel({required this.id, required this.name});

  factory TreatmentModel.fromJson(Map<String, dynamic> json) {
    return TreatmentModel(
      id: json['id'],
      name: json['name'] ?? '', 
    );
  }
}


