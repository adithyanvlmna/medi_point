import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:medipoint_machine_test/core/utils/api_urls.dart';
import 'package:medipoint_machine_test/model/treatment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medipoint_machine_test/core/utils/api_urls.dart';
import 'package:http/http.dart' as http;

class RegisterProvider extends ChangeNotifier {
  int maleCount = 0;
  int femaleCount = 0;

  final formKey = GlobalKey<FormState>();
  String date = "";
  String? token;
  String? _selectedHour;
  String? get selectedHour => _selectedHour;

  String? _selectedMinute;
  String? get selectedMinute => _selectedMinute;

  String paymentType = "";
  String? _selectedLocation;
  String? get selectedLocation => _selectedLocation;

  String? selectedBranchName;

  TextEditingController nameController = TextEditingController();
  TextEditingController wNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController bAmountController = TextEditingController();
  TextEditingController advAmountController = TextEditingController();
  TextEditingController tDateController = TextEditingController();
  bool? isLoading;

  List<String> keralaLocations = [
    'Thiruvananthapuram',
    'Kollam',
    'Pathanamthitta',
    'Alappuzha',
    'Kottayam',
    'Idukki',
    'Ernakulam',
    'Thrissur',
    'Palakkad',
    'Malappuram',
    'Kozhikode',
    'Wayanad',
    'Kannur',
    'Kasaragod',
    'Nedumangad',
    'Varkala',
    'Kottarakkara',
    'Kayamkulam',
    'Chengannur',
    'Changanassery',
    'Pala',
    'Muvattupuzha',
    'Perumbavoor',
    'Aluva',
    'Kothamangalam',
    'Angamaly',
    'Thriprayar',
    'Guruvayur',
    'Ottapalam',
    'Manjeri',
    'Nilambur',
    'Feroke',
    'Vadakara',
    'Kalpetta',
    'Thalassery',
    'Payyannur',
    'Kanhangad',
    'Bekal',
  ];

  List<String> hours12 = [
    '12 AM',
    '1 AM',
    '2 AM',
    '3 AM',
    '4 AM',
    '5 AM',
    '6 AM',
    '7 AM',
    '8 AM',
    '9 AM',
    '10 AM',
    '11 AM',
    '12 PM',
    '1 PM',
    '2 PM',
    '3 PM',
    '4 PM',
    '5 PM',
    '6 PM',
    '7 PM',
    '8 PM',
    '9 PM',
    '10 PM',
    '11 PM',
  ];
  List<String> minutesList = List.generate(
    60,
    (index) => index.toString().padLeft(2, '0'),
  );
  List<dynamic> branchList = [];
  List<TreatmentModel> treatmentList = [];
  TreatmentModel? selectedTreatment;
  int? selectedTreatmentId;

  void setSelectedTreatment(TreatmentModel? treatment) {
    selectedTreatment = treatment;
    selectedTreatmentId = treatment?.id;
    notifyListeners();
  }

  void setSelectedLocation(String? val) {
    _selectedLocation = val;
    notifyListeners();
  }

  void setSelectedHour(String? value) {
    _selectedHour = value;
    notifyListeners();
  }

  void setSelectedMinute(String? value) {
    _selectedMinute = value;
    notifyListeners();
  }

  void setSelectedBranch(String? value) {
    selectedBranchName = value;
    notifyListeners();
  }

  Future<void> getTreatmentList() async {
    final pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    if (token == null) {
      print("Token not found.");
      return;
    }

    final url = ApiUrls.baseUrl + ApiUrls.loadTreatmentList;
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["status"] == true && data["treatments"] != null) {
        treatmentList =
            (data["treatments"] as List)
                .map((e) => TreatmentModel.fromJson(e))
                .toList();
        notifyListeners();
      }
    } else {
      print("Failed to fetch treatments: ${response.body}");
    }
  }

  Future<void> getBranchList() async {
    final pref = await SharedPreferences.getInstance();
    token = pref.getString("token");
    print("Token from SharedPreferences: $token");

    if (token == null) {
      print("Token not found.");
      return;
    }

    final url = ApiUrls.baseUrl + ApiUrls.loadBranchList;
    print("Fetching from: $url");

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == true && data['branches'] != null) {
        branchList = data['branches'];
        notifyListeners();
      }
    } else {
      print("Failed to load branches.");
    }
  }

  void incrementMale() {
    maleCount++;
    notifyListeners();
  }

  void decrementMale() {
    if (maleCount > 0) {
      maleCount--;
      notifyListeners();
    }
  }

  void incrementFemale() {
    femaleCount++;
    notifyListeners();
  }

  void decrementFemale() {
    if (femaleCount > 0) {
      femaleCount--;
      notifyListeners();
    }
  }

  void onButtonClear() {
    maleCount = 0;
    femaleCount = 0;
    notifyListeners();
  }

  void clearAllValues() {
    nameController.clear();
    wNumberController.clear();
    addressController.clear();
    advAmountController.clear();
    totalController.clear();
    discountController.clear();
    bAmountController.clear();
    tDateController.clear();

    maleCount = 0;
    femaleCount = 0;
    date = "";
    _selectedHour = "";
    _selectedMinute = "";
    paymentType = "";
    _selectedLocation = null;
    selectedBranchName = null;

    isLoading = false;

    notifyListeners();
  }
}
