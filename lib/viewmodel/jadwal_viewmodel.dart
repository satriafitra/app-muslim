import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:muslim_app/model/jadwal_model.dart';

class JadwalViewmodel extends ChangeNotifier {
  JadwalModel? _jadwal;
  bool _isLoading = false;
  String? _errorMessage;

  JadwalModel? get jadwal => _jadwal;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchJadwal(String lokasi, String tahun, String bulan, String tanggal) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final url = "https://api.myquran.com/v2/sholat/jadwal/$lokasi/$tahun/$bulan/$tanggal";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        
        if (jsonData != null && jsonData is Map<String, dynamic>) {
          _jadwal = JadwalModel.fromJson(jsonData); 
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