import 'package:flutter/material.dart';
import 'package:muslim_app/viewmodel/jadwal_viewmodel.dart';
import 'package:muslim_app/view/page/shimmer_loading.dart';
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

  // Fungsi untuk mendapatkan waktu dalam WIB
  String getCurrentTimeInWIB() {
    DateTime now = DateTime.now().toUtc().add(Duration(hours: 7)); // Convert to UTC +7 (WIB)
    return DateFormat('HH:mm').format(now) + " WIB"; // Format as HH:mm WIB
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

  Future<void> _refreshJadwal() async {
    // Memanggil fetchJadwal untuk melakukan refresh
    await context.read<JadwalViewmodel>().fetchJadwal(lokasi, tahun, bulan, tanggal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 35, 20),
body: Consumer<JadwalViewmodel>(
  builder: (context, viewModel, child) {
    if (viewModel.isLoading) {
      return const ShimmerLoading(); // Pakai shimmer loading saat data belum selesai dimuat
    } else if (viewModel.errorMessage != null) {
      return Center(child: Text(viewModel.errorMessage!));
    } else if (viewModel.jadwal?.data?.jadwal == null) {
      return const Center(child: Text('No schedule available.'));
    } else {
      final jadwal = viewModel.jadwal!.data!.jadwal!;
      
      return RefreshIndicator(
        onRefresh: _refreshJadwal,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
                                      color: Color.fromARGB(255, 250, 190, 11)),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  getGreetingMessage(), // Menampilkan pesan berdasarkan waktu
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                      color: Color.fromARGB(255, 239, 217, 108)),
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
                        // Container "Prayer Time" (Dipindahkan ke atas)
                        Container(
                          width: double.infinity,
                          height: 160,
                          decoration: BoxDecoration(
                            // Menambahkan gradient hijau di belakang warna latar belakang
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 0, 128, 0), // Hijau tua
                                Color.fromARGB(255, 162, 250, 162), // Hijau lebih terang
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            color: Color.fromARGB(20, 255, 160, 77), // Menjaga warna latar belakang yang sudah ada
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${jadwal.tanggal}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 28,
                                      ),
                                      // Gunakan StreamBuilder untuk otomatis memperbarui waktu
                                      StreamBuilder(
                                          stream: Stream.periodic(Duration(seconds: 1)),
                                          builder: (context, snapshot) {
                                            return Text(
                                              getCurrentTimeInWIB().split(' ')[0],
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.bold, // Set the font weight to bold
                                                  color: Color.fromARGB(255, 255, 255, 255),
                                                  fontSize: 30),
                                            );
                                          }),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Container(
                                          color: Color.fromARGB(77, 254, 179, 67),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 6,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // Gambar sekarang ada di dalam Expanded agar menyesuaikan ukuran container
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Opacity(
                                      opacity: 0.1, // Mengatur tingkat transparansi gambar
                                      child: Image.asset(
                                        'assets/images/mas.png', // Pastikan path gambar sudah benar
                                        height: double.infinity,  // Mengisi tinggi container
                                        width: double.infinity,   // Mengisi lebar container
                                        fit: BoxFit.cover,        // Agar gambar memenuhi area sesuai ukuran
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),
                        // Container "Read Quran" (Dipindahkan ke bawah)
                       Container(
              width: double.infinity,
              height: 120,
               decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(18),
    gradient: LinearGradient(
      colors: [
        Color.fromARGB(69, 236, 255, 69),   // Hitam
        Color.fromARGB(133, 3, 96, 30), // Hijau
        Color.fromARGB(121, 9, 40, 0),   // Hitam
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
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
                  'Read Quran',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: Colors.white,
                  size: 18,
                )
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Last read Al Fatihah',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Colors.white),
            ),
            SizedBox(height: 15),
            // Progress bar

            Container(
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(19),
                child: LinearProgressIndicator(
                  value: 0.6, // Ubah sesuai progres, misalnya 60%
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(const Color.fromARGB(255, 255, 219, 18)),
                  minHeight: 9,
                ),
              ),
            ),
          ],
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.asset(
          'assets/images/quran.png',
          height: 150,
          width: 120,
          fit: BoxFit.cover,
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
                                  color: Color.fromARGB(255, 227, 227, 227),
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
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontFamily: 'POppins'),
                                ),
                                Icon(Icons.keyboard_arrow_down_rounded,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(139, 60, 95, 15),
                                Color.fromARGB(130, 5, 56, 14),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 12,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              _buildJadwalRow(
                                  "Fajr", "04:30", Icons.wb_twilight), // Contoh jadwal
                              Divider(
                                color: Color.fromARGB(255, 255, 255, 255),
                                thickness: 0.3,
                              ),
                              _buildJadwalRow("Dhuha", "06:00", Icons.wb_sunny_outlined),
                              Divider(
                                color: Color.fromARGB(255, 255, 255, 255),
                                thickness: 0.3,
                              ),
                              _buildJadwalRow("Dzuhur", "12:00", Icons.sunny),
                              Divider(
                                color: Color.fromARGB(255, 255, 255, 255),
                                thickness: 0.3,
                              ),
                              _buildJadwalRow("Asr", "15:30", Icons.cloud),
                              Divider(
                                color: Color.fromARGB(255, 164, 164, 164),
                                thickness: 0.3,
                              ),
                              _buildJadwalRow("Maghrib", "18:00", Icons.nightlight),
                              Divider(
                                color: Color.fromARGB(255, 164, 164, 164),
                                thickness: 0.3,
                              ),
                              _buildJadwalRow("Isha", "19:30", Icons.nights_stay),
                              Divider(
                                color: Color.fromARGB(255, 164, 164, 164),
                                thickness: 0.3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _buildJadwalRow(String title, String time, IconData icon) {
    return InkWell(
      onTap: () {
        // Action when the row is tapped
        print('$title tapped');
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 1.0, end: 1.2),
              duration: const Duration(milliseconds: 300),
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: Text(
                    time,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
