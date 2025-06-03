import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:muslim_app/model/qibla_model.dart';

class KiblatViewModel {
  // Fungsi untuk mengambil arah kiblat berdasarkan latitude dan longitude
  Future<KiblatModel?> getArahKiblat(double latitude, double longitude) async {
    final String url = 'http://localhost:5000/api/kiblat/getArahKiblat?latitude=$latitude&longitude=$longitude';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Jika server mengembalikan response dengan kode 200
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return KiblatModel.fromJson(jsonData);
    } else {
      // Jika terjadi error
      throw Exception('Gagal mengambil data arah kiblat');
    }
  }
}
