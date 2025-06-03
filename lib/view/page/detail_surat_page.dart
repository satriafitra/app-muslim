import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:muslim_app/viewmodel/detail_surat_viewmodel.dart';

class DetailSuratPage extends StatelessWidget {
  final int suratNomor;
  final String namaSurat;

  const DetailSuratPage({Key? key, required this.suratNomor, required this.namaSurat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final vm = DetailSuratViewModel();
        vm.fetchDetailSurat(suratNomor);
        return vm;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 6, 48, 41), // hijau tua gelap
          title: Text(
            namaSurat,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: 1.2,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: const Color.fromARGB(255, 9, 35, 20), // background hijau tua gelap
        body: Consumer<DetailSuratViewModel>(
          builder: (context, vm, _) {
            if (vm.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.amber[700],
                ),
              );
            }

            if (vm.error != null) {
              return Center(
                child: Text(
                  vm.error!,
                  style: TextStyle(color: Colors.redAccent, fontSize: 16),
                ),
              );
            }

            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              itemCount: vm.ayatList.length,
              separatorBuilder: (context, index) => Divider(
                color: const Color.fromARGB(255, 0, 82, 18),
                thickness: 1.5,
                height: 30,
              ),
              itemBuilder: (context, index) {
                final ayat = vm.ayatList[index];
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(0, 27, 94, 31), // hijau tua sedikit lebih terang
                    borderRadius: BorderRadius.circular(12),

                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        ayat.arab,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 232, 182, 31),
                          fontFamily: 'Amiri',
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        ayat.terjemah,
                        style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: const Color.fromARGB(255, 224, 224, 224),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
