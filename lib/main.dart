import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'pages/bantuan_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Tugas',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/bantuan': (context) => BantuanPage(),
      },
    );
  }
}