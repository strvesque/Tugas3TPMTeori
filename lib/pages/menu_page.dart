import 'package:flutter/material.dart';
import 'stopwatch_page.dart';
import 'bilangan_page.dart';
import 'tracking_page.dart';
import 'konversi_waktu_page.dart';
import 'rekomendasi_page.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text("Menu Utama"),
        backgroundColor: Colors.blue[300],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MenuButton(title: "Stopwatch", page: StopwatchPage()),
              MenuButton(title: "Jenis Bilangan", page: BilanganPage()),
              MenuButton(title: "Tracking LBS", page: TrackingPage()),
              MenuButton(title: "Konversi Waktu", page: KonversiWaktuPage()),
              MenuButton(title: "Rekomendasi Situs", page: RekomendasiPage()),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final Widget page;

  const MenuButton({required this.title, required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[400],
          foregroundColor: Colors.white,
          shadowColor: Colors.blueGrey[200],
          elevation: 5,
          minimumSize: Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Text(title),
      ),
    );
  }
}