import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  // Fungsi untuk menampilkan pesan yang sesuai dengan waktu
  String getGreetingMessage() {
    int hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning!";
    } else if (hour < 18) {
      return "Good Afternoon!";
    } else {
      return "Good Evening!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Assalamu'alaikum,",
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          color: Color(0xff636363)),
                    ),
                    SizedBox(height: 4),
                    Text(
                      getGreetingMessage(), // Menampilkan pesan berdasarkan waktu
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Color(0xff494949)),
                    ),
                  ],
                ),
                Icon(
                  Icons.menu,
                  color: Color.fromARGB(255, 255, 132, 0),
                  size: 28,
                )
              ],
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(94, 0, 0, 0).withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Read Qur`an',
                              style: TextStyle(
                                  color: Color(0xff464646),
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              size: 18,
                            )
                          ],
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Last read Al Fatihah',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Color.fromARGB(255, 126, 126, 126)),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      'assets/images/quran.png',
                      height: 150,
                      width: 120, // Sesuaikan tinggi gambar
                      fit: BoxFit.cover, // Agar gambar memenuhi area
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Prayer Time",
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff494949),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 20,color: Color.fromARGB(183, 244, 67, 54)),
                    const SizedBox(width: 4),
                    Text(
                      "KAB CIANJUR",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 125, 125, 125),
                          fontFamily: 'POppins'),
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded,
                        color: Color.fromARGB(255, 125, 125, 125))
                  ],
                ),
              ],
            ),
            const SizedBox(height: 22),
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                  color: Color.fromARGB(20, 255, 160, 77),
                  borderRadius: BorderRadius.circular(18)),
            )
          ],
        ),
      ),
    );
  }
}
