import 'package:flutter/material.dart';
import 'package:muslim_app/view/page/jadwal_page.dart';
import 'package:muslim_app/view/page/qibla_page.dart';
import 'package:muslim_app/view/page/surat_page.dart';
import 'package:muslim_app/view/page/about.dart';

class AnimatedNavBar extends StatefulWidget {
  @override
  _AnimatedNavBarState createState() => _AnimatedNavBarState();
}

class _AnimatedNavBarState extends State<AnimatedNavBar> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [JadwalPage(), SuratPage(), KiblatPage(), TentangPage()],
      ),
      bottomNavigationBar: ClipRRect(
        child: Material(
          color: Color(0xFF0F341E), // Warna navbar hijau gelap
          elevation: 10, // Tambahkan elevasi agar terlihat lebih premium
          child: Container(
            height: 70, // Pastikan tinggi cukup agar padding tidak bocor
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (index) {
                bool isSelected = _selectedIndex == index;
                List<IconData> icons = [
                  Icons.home,
                  Icons.menu_book,
                  Icons.gps_fixed,
                  Icons.info_outline
                ];
                return GestureDetector(
                  onTap: () => _onItemTapped(index),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: 50, // Ukuran tetap agar padding tidak bocor
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withOpacity(0.2)
                          : Colors.transparent,
                      shape: BoxShape.circle, // Jadi bentuk lebih natural
                    ),
                    child: Icon(
                      icons[index],
                      color: Colors.white,
                      size: isSelected ? 30 : 24,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
