import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:muslim_app/model/month_schedule_model.dart';


class MonthScheduleViewModel extends ChangeNotifier {
  MonthScheduleSholat? _monthSchedule;
  bool _isLoading = false;
  String? _errorMessage;

  MonthScheduleSholat? get monthSchedule => _monthSchedule;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchMonthSchedule(String lokasi, String tahun, String bulan) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final url = "https://api.myquran.com/v2/sholat/jadwal/$lokasi/$tahun/$bulan";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData != null && jsonData is Map<String, dynamic>) {
          _monthSchedule = MonthScheduleSholat.fromJson(jsonData);
        } else {
          _errorMessage = "Data tidak valid atau kosong.";
        }
      } else {
        _errorMessage =
            "Gagal memuat jadwal. Kode status: ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = "Terjadi kesalahan: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
