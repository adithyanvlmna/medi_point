import 'package:flutter/material.dart';
import 'package:medipoint_machine_test/core/utils/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:medipoint_machine_test/core/utils/constants.dart';
import 'package:medipoint_machine_test/core/utils/enum.dart';
import 'dart:convert';
import 'package:medipoint_machine_test/model/dashboard_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardProvider extends ChangeNotifier {
  AppState _setDashBoardState = AppState.noError;
  AppState get setDashBoardState => _setDashBoardState;
  List<PatientModel> _patients = [];

  List<PatientModel> get patients => _patients;
  String? token;

  void setDashBordState(AppState newState) {
    _setDashBoardState = newState;
    notifyListeners();
  }
Future<void> getUsersList() async {
  try {
    final pref = await SharedPreferences.getInstance();
    token = pref.getString("token");
    print("Token from SharedPreferences: $token");

    if (token == null) {
      print("Token not found.");
      return;
    }

    setDashBordState(AppState.loading);

    final url = ApiUrls.baseUrl + ApiUrls.loadPatientList;
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
      final data = json.decode(response.body);
      if (data['status'] == true && data['patient'] != null) {
        _patients = (data['patient'] as List)
            .map((e) => PatientModel.fromJson(e))
            .toList();
        setDashBordState(AppState.success);
      } else {
        setDashBordState(AppState.error);
        print("API returned false status or empty patient list");
      }
    } else {
      setDashBordState(AppState.error);
      print("Error: ${response.statusCode}");
    }
  } catch (e, stackTrace) {
    setDashBordState(AppState.error);
    print("Exception occurred: $e");
    print("StackTrace: $stackTrace");
  } finally {
    setDashBordState(AppState.noError);
  }
}

}
