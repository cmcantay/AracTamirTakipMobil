import 'package:flutter/material.dart';

class sayfa3 extends StatefulWidget {
  const sayfa3({Key? key, this.plaka, this.km, this.gelistarih}) : super(key: key);
  final String? plaka;
  final int? km;
  final String? gelistarih;

  @override
  State<sayfa3> createState() => _sayfa3State();
}

class _sayfa3State extends State<sayfa3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        title: Center(child: textBaslik('GELECEK BAKIMLAR')),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20), // Boşluk ekledim
            textBaslik(widget.plaka ?? ""),
            SizedBox(height: 10), // Boşluk ekledim
            textBaslik('ARACIM'),
            SizedBox(height: 10), // Boşluk ekledim
            Icon(Icons.car_rental_rounded, size: 100, color: Colors.blueAccent),
            SizedBox(height: 20), // Boşluk ekledim
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                texth1("SONRAKİ BAKIM KM si:"),
                texth1((widget.km! + 10000).toString() ?? "")
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                texth1("SONRAKİ BAKIM TARİHİ:"),
                texth1(increaseYear(widget.gelistarih) ?? "")
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Tarihi bir yıl artıran yardımcı fonksiyon
  String? increaseYear(String? dateStr) {
    if (dateStr == null) return null;

    // Tarih stringini DateTime nesnesine dönüştür
    DateTime date = DateTime.parse(dateStr);

    // Bir yıl ekleyerek yeni tarihi al
    DateTime newDate = date.add(Duration(days: 365));

    // Yeni tarihi string olarak formatla ve geri döndür
    return formatDate(newDate);
  }

  // Tarih formatını ayarlayan yardımcı fonksiyon
  String formatDate(DateTime date) {
    // Yıl, ay ve gün bilgilerini alarak formatla
    String year = date.year.toString();
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');

    // Yıl-ay-gün formatında tarihi oluştur ve geri döndür
    return '$year-$month-$day';
  }

  Widget textBaslik(String text) {
    return Text(text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }

  Widget texth1(String text) {
    return Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold));
  }
}
