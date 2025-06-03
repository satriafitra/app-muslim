import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:muslim_app/viewmodel/surat_viewmodel.dart';
import 'package:muslim_app/model/surat_model.dart';
import 'package:muslim_app/view/page/detail_surat_page.dart'; // Pastikan file ini ada

class SuratPage extends StatefulWidget {
  @override
  _SuratPageState createState() => _SuratPageState();
}

class _SuratPageState extends State<SuratPage> with AutomaticKeepAliveClientMixin {
  TextEditingController _searchController = TextEditingController();
  List<Data> _filteredSuratList = [];
  List<Data> _originalSuratList = [];
  int _selectedIndex = -1;
  int _selectedOption = 0;
  bool _isHoveredSurat = false;
  bool _isHoveredJuz = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ChangeNotifierProvider(
      create: (context) => SuratViewModel()..fetchSurat(),
      child: Scaffold(
        body: Consumer<SuratViewModel>(
          builder: (context, viewModel, child) {
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
              decoration: BoxDecoration(color: const Color.fromARGB(255, 9, 35, 20)),
              child: Column(
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    height: 130,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 2, 25, 7),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
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

                  SizedBox(height: 16),

                  // Tab bar: Surat | Juz
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Surat tab
                        MouseRegion(
                          onEnter: (_) => setState(() => _isHoveredSurat = true),
                          onExit: (_) => setState(() => _isHoveredSurat = false),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedOption = 0;
                                _filteredSuratList = _originalSuratList;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                color: _selectedOption == 0 || _isHoveredSurat
                                    ? Color.fromARGB(255, 2, 25, 7)
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
                                      : Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),

                        // Juz tab
                        MouseRegion(
                          onEnter: (_) => setState(() => _isHoveredJuz = true),
                          onExit: (_) => setState(() => _isHoveredJuz = false),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedOption = 1;
                                // Tambahkan logika filter Juz di sini jika ada
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                color: _selectedOption == 1 || _isHoveredJuz
                                    ? Color.fromARGB(255, 2, 25, 7)
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
                                      : Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 14),

                  // ListView Surat
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredSuratList.length,
                      itemBuilder: (context, index) {
                        final surat = _filteredSuratList[index];
                        bool isSelected = _selectedIndex == index;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailSuratPage(
                                  suratNomor: surat.nomor ?? 1,
                                  namaSurat: surat.namaLatin ?? 'Detail Surat',
                                ),
                              ),
                            );
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
          },
        ),
      ),
    );
  }
}
