import 'package:serav2/bottomnavigator.dart';
import 'package:serav2/models/car_model.dart';
import 'package:serav2/providers/usuario_provider.dart';
import 'package:serav2/widgets/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final TextEditingController txtCorreo = TextEditingController();
    final TextEditingController txtPassword = TextEditingController();

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            first(size),
            iconopersona(),
            loginform(context, txtCorreo, txtPassword)
          ],
        ),
      ),
    );
  }
  Future<List<dynamic>?> _login(String sifre,String eposta) async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    // Servise kullanıcı adı ve parolayı gönder
    var response = await http.get(Uri.parse('http://172.20.10.2:5000/api/Values/GetMusteriLogin?plaka=$sifre&eposta=$eposta'));

 
print(response.body);
    if (response.statusCode == 200) {
      // Servisten gelen veriyi JSON'dan çöz
      var data = jsonDecode(response.body);
      // Servisten dönen sonucu kontrol et
  var responseData = jsonDecode(response.body);
    // JSON dizisini Arac nesneleri listesine dönüştürme
  List<dynamic> araclar = responseData.map((aracJson) => CarModel.fromJson(aracJson)).toList();

  // Dönüştürülen araç listesini kontrol etmek için ekrana yazdırma
  araclar.forEach((arac) {
    print('Plaka: ${arac.plaka}, Mail: ${arac.marka}');
  });
    return araclar;
      // Giriş başarılı, home ekranına git
    
    }else {
  // Servise erişim başarısız
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text('Failed to connect to the server.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Dialogu kapat
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
  // Giriş sayfasına geri dön
  Navigator.pop(context);
}
 
  }
  
  SingleChildScrollView loginform(BuildContext context,
      TextEditingController txtCorreo, TextEditingController txtPassword) {
    final usuarioProvider = Provider.of<Usuario_provider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 250),
          Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              // height: 350,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    )
                  ]),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text('Giriş Yap', style: Theme.of(context).textTheme.headline4),
                  const SizedBox(height: 30),
                  Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          // controller: txtCorreo,
                          onChanged: (value) => usuarioProvider.email = value,
                          decoration: InputDecorations.inputDecoration(
                              hintext: 'Lütfen e-posta adresinizi giriniz.',
                              labeltext: 'E-Posta',
                              icono: const Icon(Icons.alternate_email_rounded)),
                          validator: (value) {
                            String pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regExp = new RegExp(pattern);
                            return regExp.hasMatch(value ?? '')
                                ? null
                                : 'Hatalı e-posta girişi';
                          },
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          autocorrect: false,
                          obscureText: true,
                          // controller: txtPassword,
                          onChanged: (value) =>
                              usuarioProvider.password = value,
                          decoration: InputDecorations.inputDecoration(
                              hintext: '******',
                              labeltext: 'Plaka',
                              icono: const Icon(Icons.lock_outline)),
                          validator: (value) {
                            return (value != null && value.length >= 6)
                                ? null
                                : 'Şifre boş veya 6 karakterden az olamaz.';
                          },
                        ),
                        const SizedBox(height: 30),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          disabledColor: Colors.grey,
                          color: Colors.deepPurple,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 15),
                            child: const Text(
                              'GİRİŞ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            print("object");
                            _login(usuarioProvider.password,usuarioProvider.email).then((value) {
                   /*        if( value?.first.plaka == "") {
                            showDialog(context: context, builder:(context) {
                              return Text("Bilgilerinizi Kontrol Edin");
                            },);
                           }*/
                            {
                             Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => BottomNavigatorPage(
                              plaka: value?.first.plaka ?? "",
                              marka: value?.first.marka ?? "",
                              model: value?.first.model ?? "",
                              modelyil:value?.first.modelyil ?? 0,
                              yakit: value?.first.yakit ?? "",
                              km: value?.first.km ?? 0,
                              gelistarih: value?.first.gelistarih ?? "",
                              )),
      );
                           }
                            });
                          },
                        )
                      ],
                    ),
                  )
                ],
              )),
          const SizedBox(height: 50),
          
        ],
      ),
    );
  }

  SafeArea iconopersona() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child: const Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }

  Container first(Size size) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 70, 178, 1),
      ])),
      width: double.infinity,
      height: size.height * 0.4,
      child: Stack(
        children: [
          Positioned(child: burbuja(), top: 90, left: 30),
          Positioned(child: burbuja(), top: -40, left: -30),
          Positioned(child: burbuja(), top: -50, right: -20),
          Positioned(child: burbuja(), bottom: -50, left: 10),
          Positioned(child: burbuja(), bottom: 120, right: 20)
        ],
      ),
    );
  }

  Container burbuja() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}
