import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:muslim_app/viewmodel/surat_viewmodel.dart'; // Import ViewModel
import 'package:muslim_app/model/surat_model.dart'; // Import model Surat

class SuratPage extends StatefulWidget {
  @override
  _SuratPageState createState() => _SuratPageState();
}

class _SuratPageState extends State<SuratPage> with AutomaticKeepAliveClientMixin {
  TextEditingController _searchController = TextEditingController();
  List<Data> _filteredSuratList = [];
  List<Data> _originalSuratList = [];
  int _selectedIndex = -1; // Menyimpan index card yang dipilih
  int _selectedOption = 0; // Menyimpan opsi yang dipilih: 0 untuk Surat, 1 untuk Juz
  bool _isHoveredSurat = false; // Menyimpan status hover untuk Surat
  bool _isHoveredJuz = false; // Menyimpan status hover untuk Juz

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // WAJIB dipanggil agar halaman tetap tersimpan

    return ChangeNotifierProvider(
      create: (context) => SuratViewModel()..fetchSurat(),
      child: Scaffold(
        body: Consumer<SuratViewModel>(builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage.isNotEmpty) {
            return Center(child: Text(viewModel.errorMessage));
          }

          if (viewModel.suratModel == null || viewModel.suratModel!.data == null) {
            return Center(child: Text('No data available'));
          }

          _originalSuratList = viewModel.suratModel!.data!;
          _filteredSuratList = _originalSuratList;

          return Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 9, 35, 20),
            ),
            child: Column(
              children: [
                // Container sebagai AppBar di atas card
                Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 2, 25, 7), // Hijau tua
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                  alignment: Alignment.center,
                 child: Padding(
    padding: const EdgeInsets.only(top: 30), // Memberikan sedikit ruang di bawah
    child: Text(
      'Al-Quran',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        fontSize: 29,
        color: const Color.fromARGB(255, 6, 126, 80),
      ),
    ),
  ),
),
                SizedBox(height: 16), // Memberikan sedikit jarak antara container dan list card
                
                // Baris untuk opsi Surat dan Juz
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Opsi Surat dengan animasi hover
                      MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _isHoveredSurat = true; // Surat dihover
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _isHoveredSurat = false; // Surat keluar dari hover
                          });
                        },
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedOption = 0; // Pilih Surat
                              _filteredSuratList = _originalSuratList; // Menampilkan Surat
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: _selectedOption == 0 || _isHoveredSurat
                                  ? Color.fromARGB(255, 2, 25, 7)// Hijau tua jika dipilih atau dihover
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Surat',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: _selectedOption == 0 || _isHoveredSurat
                                    ? const Color.fromARGB(255, 251, 217, 45)
                                    : const Color.fromARGB(179, 255, 255, 255), // Ganti warna teks jika dipilih atau dihover
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16), // Jarak antar opsi

                      // Opsi Juz dengan animasi hover
                      MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _isHoveredJuz = true; // Juz dihover
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _isHoveredJuz = false; // Juz keluar dari hover
                          });
                        },
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedOption = 1; // Pilih Juz
                              // Update list sesuai dengan Juz jika diperlukan
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: _selectedOption == 1 || _isHoveredJuz
                                  ? Color.fromARGB(255, 2, 25, 7) // Hijau tua jika dipilih atau dihover
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Juz',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: _selectedOption == 1 || _isHoveredJuz
                                    ? const Color.fromARGB(255, 245, 216, 50)
                                    : Colors.white70, // Ganti warna teks jika dipilih atau dihover
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 14), // Memberikan sedikit jarak antara opsi dan list
                
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredSuratList.length,
                    itemBuilder: (context, index) {
                      final surat = _filteredSuratList[index];
                      bool isSelected = _selectedIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = (_selectedIndex == index) ? -1 : index;
                          });
                        },
                        child: AnimatedScale(
                          scale: isSelected ? 1.05 : 1.0,
                          duration: Duration(milliseconds: 200),
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            elevation: isSelected ? 8 : 4,
                            color: const Color.fromARGB(255, 4, 53, 38),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 40),
                                          Text(
                                            surat.namaLatin ?? 'No Name',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_right_rounded,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        surat.nama ?? 'No Latin Name',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          color: const Color.fromARGB(255, 254, 254, 15),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        surat.arti ?? 'No Translation Available',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.blueGrey[100],
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 9,
                                  left: 8,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 32, 84, 43),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 8,
                                          offset: Offset(4, 4),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: const Color.fromARGB(255, 244, 194, 15),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Opacity(
                                    opacity: 0.3,
                                    child: Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/quran.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: Row(
                                    children: [
                                      Icon(Icons.text_snippet, size: 16, color: Colors.grey),
                                      SizedBox(width: 5),
                                      Text(
                                        '${surat.jumlahAyat ?? 0} Ayat',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
