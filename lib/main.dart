
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serav2/bottomnavigator.dart';
import 'package:serav2/login.dart';
import 'package:serav2/models/car_bakim.dart';
import 'package:serav2/models/car_model.dart';
import 'package:serav2/providers/usuario_provider.dart';
import 'package:http/http.dart' as http;

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
  //runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Usuario_provider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        routes: {
          'login': (_) =>  const LoginScreen(),
          'home': (_) => const BottomNavigatorPage(),
        },
        initialRoute: 'login', //buraya home
      ),
    );
  }
}

// ignore: camel_case_types
class homepage extends StatefulWidget {
  const homepage({super.key, this.plaka});
  final String? plaka;
  @override
  State<homepage> createState() => _homepageState();
}
Future<List<CarBakim>> getBakim(String plaka) async {
  var response = await http.get(Uri.parse('https://172.20.10.2:5001/api/Values/GetIsemri?plaka=$plaka'));

  List<CarBakim> servisVerileri = [];

  if (response.statusCode == 200) {
    List<dynamic> responseData = json.decode(response.body);
    servisVerileri = responseData.map((aracJson) => CarBakim.fromJson(aracJson)).toList();
  } else {
    throw Exception('Failed to load data');
  }

  return servisVerileri;
}
class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar:AppBar(
      backgroundColor: Colors.yellow[800],
      title: Center(child: textBaslik('GEÇMİŞ BAKIM BİLGİLERİ'),),
    ),body: Center(
      child: FutureBuilder<List<CarBakim>>(
        future: getBakim(widget.plaka ??""),
        builder: (context, snapshot) {
          //snapshot.data.
          if (snapshot.hasData) {
               return ListView.builder(
                 itemCount: snapshot.data?.length,
                 itemBuilder: (context, index) {
                   return Column(
                               children: [
                                 //textBaslik('06BC1545'),
                               textBaslik('GEÇMİŞ BAKIM VERİLERİ'),
                               Icon(Icons.car_rental_rounded,size: 100,color: Colors.blueAccent,),
                               SizedBox(height: 20,),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   texth1("Yapılan İşlem:"),
                                    texth1(snapshot.data?[index].islemAd ?? "")
                                 ],
                               ),
                              // texth1("YAĞ DEĞİŞİMİ"),
                                SizedBox(height: 20,),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   texth1("Birim Fiyat:"),
                                    texth1(snapshot.data?[index].birimFiyat.toString() ?? "")

                                 ],
                               ), 
                                // texth1("500.00"), 
                                SizedBox(height: 20,),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   texth1("Adet:"),
                                    texth1(snapshot.data?[index].adet.toString() ?? "")
                                   

                                 ],
                               ), 
                              //   texth1("3"), 
                                SizedBox(height: 20,),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   texth1("Toplam Fiyat:"),
                                    texth1(snapshot.data?[index].araToplam.toString() ?? "")

                                 ],
                               ), 
                               //  texth1("1500.00"), // 
                                SizedBox(height: 20,),
                               
                               
                               
                               
                               
                               
                               
                               
                               ],
                             
                             );
                 }
               );
    
          }
       
       else 
       return Text("Veri bulunamadı");
       }
      ),
    ),);
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