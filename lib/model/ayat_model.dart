class Ayat {
  final String arab;
  final String terjemah;

  Ayat({required this.arab, required this.terjemah});

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      arab: json['teksArab'] ?? '',
      terjemah: json['teksIndonesia'] ?? '',
    );
  }
}
