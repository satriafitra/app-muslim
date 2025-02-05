import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:muslim_app/viewmodel/month_schedule_viewmodel.dart';

class MonthSchedulePage extends StatelessWidget {
  final String lokasi;
  final String tahun;
  final String bulan;

  MonthSchedulePage({
    this.lokasi = '1206',
    this.tahun = '2025',
    this.bulan = '02',
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          MonthScheduleViewModel()..fetchMonthSchedule(lokasi, tahun, bulan),
      child: Scaffold(
        body: Consumer<MonthScheduleViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (viewModel.errorMessage != null) {
              return Center(child: Text(viewModel.errorMessage!));
            } else if (viewModel.monthSchedule?.data?.jadwal != null) {
              final jadwalList = viewModel.monthSchedule!.data!.jadwal!;

              return ListView.builder(
                itemCount: jadwalList.length,
                itemBuilder: (context, index) {
                  final jadwal = jadwalList[index];

                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        '${jadwal.tanggal}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 84, 84, 84),
                        ),
                      ),
                      leading:
                          Icon(Icons.calendar_today, color: Color(0xffE1753D)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildJadwalRow(
                                  'Imsak', jadwal.imsak, Icons.access_alarm),
                              Divider(
                                color: Color(0xffd9d9d9),
                              ),
                              _buildJadwalRow(
                                  'Subuh', jadwal.subuh, Icons.wb_twilight),
                              Divider(
                                color: Color(0xffd9d9d9),
                              ),
                              _buildJadwalRow(
                                  'Dzuhur', jadwal.dzuhur, Icons.wb_sunny),
                              Divider(
                                color: Color(0xffd9d9d9),
                              ),
                              _buildJadwalRow(
                                  'Ashar', jadwal.ashar, Icons.cloud),
                              Divider(
                                color: Color(0xffd9d9d9),
                              ),
                              _buildJadwalRow('Maghrib', jadwal.maghrib,
                                  Icons.nightlight_round),
                              Divider(
                                color: Color(0xffd9d9d9),
                              ),
                              _buildJadwalRow(
                                  'Isya', jadwal.isya, Icons.nights_stay),
                              Divider(
                                color: Color(0xffd9d9d9),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('Tidak ada data jadwal.'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildJadwalRow(String label, String? waktu, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color.fromARGB(255, 188, 188, 188)),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
              ),
            ],
          ),
          Text(
            waktu ?? '-',
            style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
