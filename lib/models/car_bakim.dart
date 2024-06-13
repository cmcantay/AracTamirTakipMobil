class CarBakim {
  final String islemAd;
  final double birimFiyat;
  final int adet;
  final double araToplam;

  CarBakim({
    required this.islemAd,
    required this.birimFiyat,
    required this.adet,
    required this.araToplam,
  });

  factory CarBakim.fromJson(Map<String, dynamic> json) {
    return CarBakim(
      islemAd: json['islemAd'],
      birimFiyat: json['birimFiyat'].toDouble(),
      adet: json['adet'],
      araToplam: json['araToplam'].toDouble(),
    );
  }
}
