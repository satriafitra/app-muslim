import 'package:flutter/material.dart';

class TentangPage extends StatelessWidget {
  const TentangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 9, 35, 20), // Hijau tua
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 9, 35, 20),
        title: Text(
          'Tentang Aplikasi',
          style: TextStyle(
            fontFamily: 'Amiri',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Muslim App',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 254, 229, 61),
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Aplikasi ini dirancang untuk membantu umat Muslim dalam menjalani kehidupan sehari-hari. '
              'Beberapa fitur utama yang tersedia di antaranya:\n\n'
              '- Membaca Al-Qur\'an\n'
              '- Terjemahan ayat\n'
              '- Jadwal sholat \n'
              '- Arah kiblat \n\n'
              'Semoga aplikasi ini bermanfaat dan menjadi bagian dari ibadah harian Anda.',
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'Arial',
                height: 1.6,
              ),
            ),
            Spacer(),
            Center(
              child: Text(
                'Versi 1.0.0',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
