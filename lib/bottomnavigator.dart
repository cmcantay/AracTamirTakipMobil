import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:serav2/main.dart';
import 'package:serav2/sayfa3.dart';
import 'sayfa2.dart';

class BottomNavigatorPage extends StatefulWidget {
  const BottomNavigatorPage({super.key,  this.plaka, this.mail,this.marka,this.model,this.modelyil,this.yakit,this.km,this.gelistarih});
 final String? plaka;
 final String? mail;
 final String? marka;
 final String? model;
 final int? modelyil;
 final String? yakit;
 final int? km;
 final String? gelistarih;
  @override
  State<BottomNavigatorPage> createState() => _BottomNavigatorPageState();
}


int secilenindex = 0;

class _BottomNavigatorPageState extends State<BottomNavigatorPage> {
 
  @override
  Widget build(BuildContext context) {
     var sayfaListesi = [homepage(plaka: widget.plaka,), sayfa2(plaka:widget.plaka ,marka:widget.marka,model:widget.model,modelyil:widget.modelyil,yakit:widget.yakit,km:widget.km, gelistarih:widget.gelistarih,),sayfa3(plaka:widget.plaka,km:widget.km,gelistarih:widget.gelistarih,)];
    return Scaffold(
      body: sayfaListesi[secilenindex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Geçmiş Bakımlar"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Aracım"),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: "Gelecek Bakımlar")
        ],
        elevation: 0,
        selectedItemColor: Colors.amber,
        iconSize: 30,
        currentIndex: secilenindex,
        onTap: (value) {
          setState(() {
            secilenindex = value;
          });
        },
      ),
    );
  }
}
