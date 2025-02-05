// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:muslim_app/viewmodel/jadwal_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  String lokasi = '1206'; // ID lokasi

  late String tahun;
  late String bulan;
  late String tanggal;

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

  String getFormattedDate() {
    DateTime now = DateTime.now();
    return DateFormat('EEEE, dd MMM yyyy', 'id_ID').format(now);
  }

  @override
  void initState() {
    super.initState();
    // Inisialisasi tanggal saat ini
    DateTime now = DateTime.now();
    tahun = now.year.toString();
    bulan =
        now.month.toString().padLeft(2, '0'); // Format dua digit, misalnya "02"
    tanggal =
        now.day.toString().padLeft(2, '0'); // Format dua digit, misalnya "04"

    // Memanggil fetchJadwal ketika widget pertama kali dibangun
    Future.microtask(() {
      context
          .read<JadwalViewmodel>()
          .fetchJadwal(lokasi, tahun, bulan, tanggal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Consumer<JadwalViewmodel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.orange,
            ));
          } else if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          } else if (viewModel.jadwal?.data?.jadwal == null) {
            return const Center(child: Text('No schedule available.'));
          } else {
            final jadwal = viewModel.jadwal!.data!.jadwal!;
            final lokasi =
                viewModel.jadwal!.data!.lokasi ?? 'Lokasi tidak tersedia';

            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
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
                                color: const Color.fromARGB(94, 0, 0, 0)
                                    .withOpacity(0.1),
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
                                          color: Color.fromARGB(
                                              255, 126, 126, 126)),
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
                                  fit:
                                      BoxFit.cover, // Agar gambar memenuhi area
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
                                const Icon(Icons.location_on,
                                    size: 20,
                                    color: Color.fromARGB(183, 244, 67, 54)),
                                const SizedBox(width: 4),
                                Text(
                                  lokasi,
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${jadwal.tanggal}',
                                        style: TextStyle(
                                            fontFamily: 'POppins',
                                            color: Color.fromARGB(
                                                255, 163, 163, 163),
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 28,
                                      ),
                                      Text(
                                        '14.41 WIB',
                                        style: TextStyle(
                                            fontFamily: 'POppins',
                                            color: Color.fromARGB(
                                                255, 163, 163, 163),
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Container(
                                          color: Color.fromARGB(
                                              255, 238, 238, 238),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                            child: Row(
                                              children: [
                                                Icon(Icons.timelapse, size: 18,
                                                    color: const Color.fromARGB(
                                                        255, 130, 130, 130)),
                                                SizedBox(
                                                  width: 6,
                                                ),
                                                Text(
                                                  'Ashar in 3m 29s',
                                                  style: TextStyle(
                                                      fontFamily: 'POppins',
                                                      fontSize: 12,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              130,
                                                              130,
                                                              130)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      18), // Menggunakan border radius yang sama dengan Container
                                  child: Image.asset(
                                    'assets/images/mosque.png',
                                    width: 100, // Sesuaikan ukuran gambar
                                    height: 1000,
                                    fit:
                                        BoxFit.cover, // Sesuaikan ukuran gambar
                                  ),
                                )
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(20, 255, 160, 77),
                            borderRadius: BorderRadius.circular(18),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(23, 255, 160, 77),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(children: [
                        _buildJadwalRow(
                            "Fajr", jadwal.subuh ?? "N/A", Icons.wb_twilight),
                        Divider(
                          color: const Color.fromARGB(255, 164, 164, 164),
                          thickness: 0.3,
                        ),
                        _buildJadwalRow("Dhuha", jadwal.dhuha ?? "N/A",
                            Icons.wb_sunny_outlined),
                        Divider(
                          color: const Color.fromARGB(255, 164, 164, 164),
                          thickness: 0.3,
                        ),
                        _buildJadwalRow(
                            "Dzuhur", jadwal.dzuhur ?? "N/A", Icons.sunny),
                        Divider(
                          color: const Color.fromARGB(255, 164, 164, 164),
                          thickness: 0.3,
                        ),
                        _buildJadwalRow(
                            "Asr", jadwal.ashar ?? "N/A", Icons.cloud),
                        Divider(
                          color: const Color.fromARGB(255, 164, 164, 164),
                          thickness: 0.3,
                        ),
                        _buildJadwalRow("Maghrib", jadwal.maghrib ?? "N/A",
                            Icons.nightlight),
                        Divider(
                          color: const Color.fromARGB(255, 164, 164, 164),
                          thickness: 0.3,
                        ),
                        _buildJadwalRow(
                            "Isha", jadwal.isya ?? "N/A", Icons.nights_stay),
                        Divider(
                          color: const Color.fromARGB(255, 164, 164, 164),
                          thickness: 0.3,
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildJadwalRow(String title, String time, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color.fromARGB(255, 161, 161, 161)),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.notifications,
                color: Color(0xffF77C25),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
