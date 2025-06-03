import 'package:flutter/foundation.dart';
import 'package:muslim_app/model/ayat_model.dart';

class DetailSuratViewModel extends ChangeNotifier {
  List<Ayat> _ayatList = [];
  bool _loading = false;
  String? _error;

  List<Ayat> get ayatList => _ayatList;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchDetailSurat(int suratNomor) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      // Contoh data surat Al-Fatihah manual
      _ayatList = [
        Ayat(
          arab: 'بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ',
          terjemah: 'Dengan nama Allah Yang Maha Pengasih, Maha Penyayang.',
        ),
        Ayat(
          arab: 'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
          terjemah: 'Segala puji bagi Allah, Tuhan seluruh alam.',
        ),
        Ayat(
          arab: 'الرَّحْمَـٰنِ الرَّحِيمِ',
          terjemah: 'Yang Maha Pengasih, Maha Penyayang.',
        ),
        Ayat(
          arab: 'مَالِكِ يَوْمِ الدِّينِ',
          terjemah: 'Pemilik hari pembalasan.',
        ),
        Ayat(
          arab: 'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
          terjemah: 'Hanya kepada Engkaulah kami menyembah dan hanya kepada Engkaulah kami mohon pertolongan.',
        ),
        Ayat(
          arab: 'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
          terjemah: 'Tunjukilah kami jalan yang lurus,',
        ),
        Ayat(
          arab: 'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
          terjemah: '(yaitu) jalan orang-orang yang telah Engkau beri nikmat kepada mereka; bukan (jalan) mereka yang dimurkai, dan bukan (pula jalan) mereka yang sesat.',
        ),
      ];
    } catch (e) {
      _error = 'Error: $e';
    }

    _loading = false;
    notifyListeners();
  }
}
