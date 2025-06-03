class KiblatModel {
  double latitude;
  double longitude;
  double arahKiblat;

  KiblatModel({
    required this.latitude,
    required this.longitude,
    required this.arahKiblat,
  });

  // Dari JSON ke objek
  factory KiblatModel.fromJson(Map<String, dynamic> json) {
    return KiblatModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
      arahKiblat: json['arahKiblat'],
    );
  }

  // Ke format JSON
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'arahKiblat': arahKiblat,
    };
  }
}
