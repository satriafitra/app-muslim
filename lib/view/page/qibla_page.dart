import 'package:flutter/material.dart';
import 'package:muslim_app/model/qibla_model.dart';
import 'package:muslim_app/viewmodel/qibla_viewmodel.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math'; // Untuk fungsi matematika seperti sin, cos, dll.

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arah Kiblat',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.dark, // Tema gelap untuk tampilan modern
        fontFamily: 'Poppins', // Menetapkan font Poppins sebagai default
      ),
      home: KiblatPage(),
    );
  }
}

class KiblatPage extends StatefulWidget {
  @override
  _KiblatPageState createState() => _KiblatPageState();
}

class _KiblatPageState extends State<KiblatPage> {
  final KiblatViewModel _viewModel = KiblatViewModel();
  double? _arahKiblat;
  bool _isLoading = false;
  String _direction = "Tidak Diketahui"; // Menyimpan arah
  String _confirmationMessage = ""; // Pesan konfirmasi

  void _fetchArahKiblat() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await _viewModel.getArahKiblat(6.2088, 106.8456); // Contoh latitude dan longitude (Jakarta)
      setState(() {
        _arahKiblat = result?.arahKiblat;
        _isLoading = false;
        _direction = "Arah Kiblat: ${_arahKiblat?.toStringAsFixed(2)}°";
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _direction = "Gagal Mengambil Arah";
      });
      print("Error: $e");
    }
  }

  void _setDirection(String direction) {
    setState(() {
      _direction = direction;
    });
  }

  double? heading = 0; // Menyimpan arah kompas

  // Koordinat Mekkah
  final double mekkaLatitude = 21.4225;
  final double mekkaLongitude = 39.8262;

  // Fungsi untuk menghitung arah Kiblat
  double calculateKiblatDirection(double userLatitude, double userLongitude) {
    double deltaLongitude = mekkaLongitude - userLongitude;

    double x = sin(deltaLongitude) * cos(mekkaLatitude);
    double y = cos(userLatitude) * sin(mekkaLatitude) - 
        sin(userLatitude) * cos(mekkaLatitude) * cos(deltaLongitude);

    double angle = atan2(x, y);
    double degree = (angle * 180 / pi); // Konversi dari radian ke derajat

    return (degree + 360) % 360; // Mengatur agar nilai tetap dalam rentang 0-360 derajat
  }

  // Fungsi untuk memeriksa apakah arah yang dipilih pengguna sudah benar
  bool isCorrectKiblatDirection(double userDirection, double correctDirection) {
    // Toleransi 5 derajat untuk memastikan pengguna berada di arah Kiblat yang benar
    const tolerance = 5.0;
    double difference = (userDirection - correctDirection).abs();
    return difference <= tolerance || (360 - difference) <= tolerance;
  }

  @override
  void initState() {
    super.initState();
    FlutterCompass.events!.listen((event) {
      setState(() {
        heading = event.heading;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 35, 20), // Latar belakang hijau tua
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Judul dengan tombol kembali di atas
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // Aksi kembali
                    },
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Arah Kiblat',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Gambar Kiblat dengan border radius dan warna hijau
                          Container(
                            width: 220,
                            height: 220,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(168, 2, 104, 5), // Hijau transparan
                                  const Color.fromARGB(223, 13, 24, 0), // Hitam
                                ],
                                begin: Alignment.topLeft, // Menentukan arah gradien
                                end: Alignment.bottomRight, // Arah gradien ke sudut kanan bawah
                              ),
                              borderRadius: BorderRadius.circular(110), // Memberikan sudut membulat penuh untuk container
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 229, 254, 63).withOpacity(0.3), // Bayangan dengan transparansi
                                  blurRadius: 15, // Menambahkan blur agar bayangan lebih halus
                                  offset: Offset(0, 5), // Posisi bayangan (horizontal, vertikal)
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(110), // Memastikan gambar mengikuti border radius yang sama
                              child: Image.asset(
                                'assets/images/kiblat.png', // Pastikan menambahkan gambar di folder assets
                                width: 220,
                                height: 220,
                                fit: BoxFit.cover, // Agar gambar memenuhi container dengan proporsional
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          // Menampilkan arah Kiblat yang didapat dari GPS atau pilihan arah
                          AnimatedDefaultTextStyle(
                            duration: Duration(milliseconds: 300), // Durasi animasi
                            style: TextStyle(
                              fontSize: 28, // Ukuran font lebih besar
                              fontWeight: FontWeight.bold, // Menebalkan font
                              fontFamily: 'Poppins', // Menggunakan font Poppins
                              color: Colors.white, // Warna teks putih
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0, // Efek bayangan
                                  color: Colors.black.withOpacity(0.5), // Bayangan hitam transparan
                                  offset: Offset(2.0, 2.0), // Posisi bayangan
                                ),
                              ],
                            ),
                            child: Text(_direction),
                          ),
                          SizedBox(height: 20),
                          // Pesan konfirmasi arah Kiblat
                          if (_confirmationMessage.isNotEmpty)
                            Text(
                              _confirmationMessage,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0, // Efek bayangan
                                    color: Colors.black.withOpacity(0.5), // Bayangan hitam transparan
                                    offset: Offset(2.0, 2.0), // Posisi bayangan
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(height: 20),
                          // Tombol dengan desain lebih menarik
                          ElevatedButton(
                            onPressed: () {
                              _fetchArahKiblat();
                              // Setelah mendapatkan arah Kiblat, periksa apakah pengguna menghadap ke arah Kiblat yang benar
                              if (_arahKiblat != null && heading != null) {
                                // Periksa apakah arah kompas sesuai dengan arah Kiblat
                                bool isCorrect = isCorrectKiblatDirection(heading!, _arahKiblat!);
                                setState(() {
                                  _confirmationMessage = isCorrect
                                      ? "Ya, ini arah Kiblat-nya"
                                      : "Arah yang Anda pilih masih salah, coba lagi!";
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, // Warna teks tombol menjadi putih
                              backgroundColor: const Color.fromARGB(255, 186, 135, 5), // Warna latar belakang tombol
                              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 36),
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                              elevation: 8, // Menambahkan efek elevasi
                              shadowColor: Colors.black.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30), // Sudut melengkung tombol
                              ),
                            ),
                            child: Text('Ambil Arah Kiblat dengan GPS'),
                          ),
                          SizedBox(height: 40),
                          // Kompas
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 280,
                                height: 280,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [const Color.fromARGB(255, 1, 79, 46), Colors.teal],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.6),
                                      blurRadius: 12,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/compass.png', // Gambar latar belakang kompas
                                    width: 250,
                                    height: 250,
                                  ),
                                ),
                              ),
                              Transform.rotate(
                                angle: (heading ?? 0) * (3.14159265359 / 180),
                                child: Icon(
                                  Icons.navigation,
                                  size: 60,
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                          // Opsi arah manual (Timur, Barat, Selatan, Utara)
                          Text('Atau Pilih Arah:'),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
