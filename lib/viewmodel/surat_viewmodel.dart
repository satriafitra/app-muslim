import 'dart:convert';  // Untuk jsonDecode
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import http package
import 'package:muslim_app/model/surat_model.dart'; // Import SuratModel

class SuratViewModel extends ChangeNotifier {
  SuratModel? _suratModel;
  bool isLoading = false;
  String errorMessage = '';

  SuratModel? get suratModel => _suratModel;

  // Fungsi untuk memuat data surat dari API
  Future<void> fetchSurat() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    final url = 'https://equran.id/api/v2/surat'; // URL API

    try {
      // Mengambil data dari API
      final response = await http.get(Uri.parse(url));

      // Mengecek status code untuk memastikan data diterima dengan sukses
      if (response.statusCode == 200) {
        // Parsing response JSON
        final data = jsonDecode(response.body);

        if (data['code'] == 200) {
          // Jika response sukses, simpan data surat
          _suratModel = SuratModel.fromJson(data);
        } else {
          errorMessage = 'Error: ${data['message']}';
        }
      } else {
        errorMessage = 'Failed to load data. Status code: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage = 'Error: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
