import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:muslim_app/model/doa_model.dart';

class DoaViewModel extends ChangeNotifier {
  DoaModel? _doa;
  bool _isLoading = false;
  String? _errorMessage;

  DoaModel? get doa => _doa;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchDoa(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final url = "https://doa-doa-api-ahmadramadhan.fly.dev/api/$id";
      final response = await http.get(Uri.parse(url));

      print(response);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Memastikan respons berupa array JSON
        if (jsonData is List && jsonData.isNotEmpty) {
          _doa = DoaModel.fromJson(jsonData.first); // Ambil index pertama
        } else {
          _errorMessage = "Data tidak valid atau kosong.";
        }
      } else {
        _errorMessage =
            "Failed to load schedule. Status code: ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = "An error occurred: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
