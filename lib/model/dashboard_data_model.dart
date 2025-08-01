class PatientModel {
  final int id;
  final List<PatientDetails> patientDetails;
  final Branch branch;
  final String? user;
  final String? payment;
  final String name;
  final String phone;
  final String address;
  final double totalAmount;
  final double discountAmount;
  final double advanceAmount;
  final double balanceAmount;
  final DateTime? dateTime;

  PatientModel({
    required this.id,
    required this.patientDetails,
    required this.branch,
    required this.user,
    required this.payment,
    required this.name,
    required this.phone,
    required this.address,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    required this.dateTime,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'] ?? 0,
      patientDetails: (json['patientdetails_set'] as List? ?? [])
          .map((e) => PatientDetails.fromJson(e))
          .toList(),
      branch: Branch.fromJson(json['branch'] ?? {}),
      user: json['user']?.toString(),
      payment: json['payment']?.toString(),
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      discountAmount: (json['discount_amount'] as num?)?.toDouble() ?? 0.0,
      advanceAmount: (json['advance_amount'] as num?)?.toDouble() ?? 0.0,
      balanceAmount: (json['balance_amount'] as num?)?.toDouble() ?? 0.0,
      dateTime: json['date_nd_time'] != null
          ? DateTime.tryParse(json['date_nd_time'])
          : null,
    );
  }
}

class PatientDetails {
  final int id;
  final String male;
  final String female;
  final int treatment;
  final String treatmentName;

  PatientDetails({
    required this.id,
    required this.male,
    required this.female,
    required this.treatment,
    required this.treatmentName,
  });

  factory PatientDetails.fromJson(Map<String, dynamic> json) {
    return PatientDetails(
      id: json['id'] ?? 0,
      male: json['male'] ?? '',
      female: json['female'] ?? '',
      treatment: json['treatment'] ?? 0,
      treatmentName: json['treatment_name'] ?? '',
    );
  }
}

class Branch {
  final int id;
  final String name;
  final String location;
  final String phone;
  final String mail;
  final String address;

  Branch({
    required this.id,
    required this.name,
    required this.location,
    required this.phone,
    required this.mail,
    required this.address,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      phone: json['phone'] ?? '',
      mail: json['mail'] ?? '',
      address: json['address'] ?? '',
    );
  }
}
