import 'package:flutter/material.dart';
import 'package:muslim_app/view/page/home.dart';
import 'package:muslim_app/view/page/jadwal_page.dart';
import 'package:muslim_app/view/page/month_jadwal_page.dart';
import 'package:muslim_app/view/page/navbar.dart';
import 'package:muslim_app/view/page/shimmer_loading.dart';
import 'package:muslim_app/view/page/splash.dart';
import 'package:muslim_app/view/page/surat_page.dart';
import 'package:muslim_app/viewmodel/doa_viewmodel.dart';
import 'package:muslim_app/view/page/doa_page.dart';
import 'package:muslim_app/view/page/navbar.dart';
import 'package:muslim_app/viewmodel/jadwal_viewmodel.dart';
import 'package:muslim_app/viewmodel/month_schedule_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl_standalone.dart';
import 'package:muslim_app/view/page/surat_page.dart'; // Import this
import 'package:muslim_app/view/page/qibla_page.dart'; // Import this
import 'package:muslim_app/viewmodel/qibla_viewmodel.dart'; // Import this
import 'package:muslim_app/model/qibla_model.dart';
import 'package:muslim_app/view/page/splash.dart'; // Import this

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
         debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        initialRoute: '/doa',
        routes: {
          '/doa': (context) => SplashScreen(),
        },
      ),
    );
  }
}
