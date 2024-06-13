import 'dart:ffi';

import 'package:flutter/material.dart';

class sayfa2 extends StatefulWidget {
 const sayfa2({super.key,  this.plaka, this.mail,this.marka,this.model,this.modelyil,this.yakit,this.km,this.gelistarih});
 final String? plaka;
 final String? mail;
 final String? marka;
 final String? model;
 final int? modelyil;
 final String? yakit;
 final int? km;
 final String? gelistarih;
  @override
  State<sayfa2> createState() => _sayfa2State();
}

class _sayfa2State extends State<sayfa2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        title: Center(child: textBaslik('ARAÇ BİLGİLERİM'),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textBaslik(widget.plaka ?? ""),
          textBaslik('ARACIM'),
          Icon(Icons.car_rental_rounded,size: 100,color: Colors.blueAccent,),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              texth1("PLAKA:"),
              texth1(widget.plaka ?? "")
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              texth1("MARKA:"),
              texth1(widget.marka ?? "")
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              texth1("MODEL:"),
              texth1(widget.model ?? "")
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              texth1("MODEL YILI:"),
              texth1(widget.modelyil.toString() ?? "")
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              texth1("YAKIT:"),
              texth1(widget.yakit ?? "")
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              texth1("KM:"),
              texth1(widget.km.toString() ?? "")
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              texth1("SON BAKIM TARİHİ:"),
              texth1(widget.gelistarih?.substring(0,10) ?? "")
            ],
          ),
          SizedBox(height: 20,),
          //texth1("LASTİK VERİLERİ:"), //  ROW 
          //texth1("LASTİK VERİLERİ:"), //  ROW 
          // SizedBox(height: 20,),
          //Center(child: Row(children: [texth1("KM"),SizedBox(width: 50,),texth1("filtre")],)) 
        ],
      ),
    );
  }

  Widget textBaslik(String text) {
    return Text(text,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }

  Widget texth1(String text) {
    return Text(text,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold));
  }
}
