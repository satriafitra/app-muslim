import 'package:flutter/foundation.dart';
import 'package:muslim_app/model/ayat_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailSuratViewModel extends ChangeNotifier {
  List<Ayat> _ayatList = [];
  bool _loading = false;
  String? _error;

  List<Ayat> get ayatList => _ayatList;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchDetailSurat(int suratNomor) async {
    _loading = true;
    _error = null;
    notifyListeners();

    final url = Uri.parse('https://equran.id/api/v2/surat/$suratNomor');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> ayatJson = jsonData['data']['ayat'];

        _ayatList = ayatJson.map((e) => Ayat.fromJson(e)).toList();
      } else {
        _error = 'Gagal memuat data: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Terjadi kesalahan: $e';
    }

    _loading = false;
    notifyListeners();
  }
}