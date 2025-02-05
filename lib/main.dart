import 'package:flutter/material.dart';
import 'package:muslim_app/view/page/home.dart';
import 'package:muslim_app/view/page/jadwal_page.dart';
import 'package:muslim_app/view/page/month_jadwal_page.dart';
import 'package:muslim_app/viewmodel/doa_viewmodel.dart';
import 'package:muslim_app/view/page/doa_page.dart';
import 'package:muslim_app/viewmodel/jadwal_viewmodel.dart';
import 'package:muslim_app/viewmodel/month_schedule_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JadwalViewmodel()),
      ],
      child: MaterialApp(
        title: 'Muslim App',
        theme: ThemeData(primarySwatch: Colors.green),
        initialRoute: '/doa',
        routes: {
          '/doa': (context) => JadwalPage(),
        },
      ),
    );
  }
}
