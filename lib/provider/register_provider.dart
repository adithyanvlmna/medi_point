import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:medipoint_machine_test/core/utils/api_urls.dart';
import 'package:medipoint_machine_test/core/utils/date_time_convert.dart';

import 'package:medipoint_machine_test/model/treatment_model.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

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

  String paymentType = "Cash";
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
  List<TreatmentModel> selectedTreatments = [];
  String? selectedValue;
  String? selectedid;

  void saveTreatment(int male, int female, String title) {
    maleCount = male;
    femaleCount = female;
    selectedValue = title;
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

  void updateSelectedTreatments(List<TreatmentModel> selected) {
    selectedTreatments = selected;
    print(selectedTreatments.first.id);

    notifyListeners();
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
    selectedValue = "";
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

  Future<void> generateReceiptPdf({
    required String name,
    required String address,
    required String whatsapp,
    required DateTime bookedOn,
    required String treatmentDate,
    required String treatmentTime,
    required List<Map<String, dynamic>> treatments,
    int discount = 500,
    int advance = 1200,
  }) async {
    final pdf = pw.Document();

    final bgImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/pdf_bg.png')).buffer.asUint8List(),
    );
    final logo = pw.MemoryImage(
      (await rootBundle.load(
        'assets/images/app_icon.png',
      )).buffer.asUint8List(),
    );

    final totalAmount = treatments.fold<int>(
      0,
      (sum, item) =>
          sum +
          (item['price'] as int) * (item['male'] as int) +
          (item['price'] as int) * (item['female'] as int),
    );

    final balance = totalAmount - discount - advance;

    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.zero,
        build: (context) {
          return pw.Stack(
            children: [
              pw.Positioned.fill(
                child: pw.Image(bgImage, fit: pw.BoxFit.cover),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 30,
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Image(logo, height: 50),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.SizedBox(height: 20),
                            pw.Text(
                              "Amitha Ayurveda",
                              style: pw.TextStyle(
                                fontSize: 18,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 5),
                            pw.Text("KUMARAKOM"),
                            pw.Text(
                              "Cheepunkal P.O, Kumarakom, Kottayam, Kerala - 686563",
                            ),
                            pw.Text("Email: sunilamr@gmail.com"),
                            pw.Text("Phone: +91 98956 32156 / +91 98956 32150"),
                            pw.Text("GST No: 32AABCJ9603R1ZW"),
                            pw.SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                    pw.Container(
                      color: PdfColors.grey300,
                      width: double.infinity,
                      height: 1,
                    ),
                    pw.SizedBox(height: 10),

                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        "Patient Details",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.green,
                        ),
                      ),
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(height: 10),
                            pw.Text("Name:  $name"),
                            pw.Text("Address: $address"),
                            pw.Text("WhatsApp Number:  $whatsapp"),
                          ],
                        ),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(height: 10),
                            pw.Text(
                              "Booked On: ${DateFormat('dd/MM/yyyy  hh:mm a').format(bookedOn)}",
                            ),
                            pw.Text("Treatment Date:   $treatmentDate"),
                            pw.Text("Treatment Time:   $treatmentTime"),
                          ],
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 30),

                    pw.Table(
                      border: pw.TableBorder(),
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text(
                                "Treatment",
                                style: pw.TextStyle(color: PdfColors.green),
                              ),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text(
                                "Price",
                                style: pw.TextStyle(color: PdfColors.green),
                              ),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text(
                                "Male",
                                style: pw.TextStyle(color: PdfColors.green),
                              ),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text(
                                "Female",
                                style: pw.TextStyle(color: PdfColors.green),
                              ),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text(
                                "Total",
                                style: pw.TextStyle(color: PdfColors.green),
                              ),
                            ),
                          ],
                        ),
                        ...treatments.map((e) {
                          final total =
                              (e['price'] as int) * (e['male'] as int) +
                              (e['price'] as int) * (e['female'] as int);
                          return pw.TableRow(
                            children: [
                              pw.Padding(
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Text(e['name'] ?? ''),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Text("₹${e['price']}"),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Text("${e['male']}"),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Text("${e['female']}"),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Text("$total"),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),

                    pw.SizedBox(height: 30),

                    pw.Text("Total Amount: ₹$totalAmount"),
                    pw.Text("Discount: ₹$discount"),
                    pw.Text("Advance: ₹$advance"),
                    pw.Text(
                      "Balance: ₹$balance",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),

                    pw.SizedBox(height: 20),
                    pw.Text(
                      "Thank you for choosing us",
                      style: pw.TextStyle(color: PdfColors.green800),
                    ),
                    pw.SizedBox(height: 40),
                    pw.Text("Signature", style: pw.TextStyle(fontSize: 16)),
                    pw.Text("________________"),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  Future<void> updatePatient() async {
    Map<dynamic, dynamic> toJson = {
      "name": nameController.text.trim(),
      "payment": paymentType,
      "phone": wNumberController.text.trim(),
      "address": wNumberController.text.trim(),
      "total_amount": double.parse(totalController.text.trim()),
      "discount_amount": double.parse(discountController.text.trim()),
      "advance_amount": double.parse(advAmountController.text.trim()),
      "balance_amount": double.parse(bAmountController.text.trim()),
      "date_nd_time": formatSelectedDateTimeFromSingle(
        dateStr: tDateController.text,
        hourPeriod: selectedHour!,
        minuteStr: selectedMinute!,
      ),
      "id": "",
      "male": selectedid,
      "female": selectedid,
      "branch": selectedBranchName,
      "treatments": selectedid,
    };
    final pref = await SharedPreferences.getInstance();
    token = pref.getString("token");
    print("Token from SharedPreferences: $token");

    if (token == null) {
      print("Token not found.");
      return;
    }

    final url = ApiUrls.baseUrl + ApiUrls.patientUpdate;
    print("Fetching from: $url");
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(toJson),
    );
    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");
  }
}
