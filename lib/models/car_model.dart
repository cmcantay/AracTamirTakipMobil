import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

class CarModel {
  String? plaka;
  String? mail;
  String? marka;
  String? model;
  int? modelyil;
  String? yakit;
  int? km;
  String? gelistarih;
  CarModel({this.plaka, this.mail,this.gelistarih,this.km,this.marka,this.model,this.modelyil,this.yakit});

  CarModel.fromJson(Map<String, dynamic> json) {
    plaka = json['plaka'];
    mail = json['mail'];
    marka = json['markaAd'];
     model = json['modelAd'];
      modelyil = json['modelYil']; 
      yakit = json['yakitTuru'];
       km = json['aracKm'];
        gelistarih = json['gelisTarihi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plaka'] = this.plaka;
    data['mail'] = this.mail;
    data['markaAd'] = this.marka;
    data['modelAd'] = this.model;
    data['modelYil'] = this.modelyil;
    data['yakitTuru'] = this.yakit;
    data['aracKm'] = this.km;
    data['gelisTarihi'] = this.gelistarih;
    return data;
  }
}
