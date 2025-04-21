import 'package:flutter/material.dart';

class AnggotaPage extends StatelessWidget {
  final List<Map<String, String>> anggota = [
    {
      "nama": "Hikmal Haqiqi",
      "nim": "123220056",
      "kelas": "IF-A",
      "foto": "assets/hikmal.jpg"
    },
    {
      "nama": "I Gede Hariel Dananjaya",
      "nim": "123220069",
      "kelas": "IF-A",
      "foto": "assets/hariel.jpg"
    },
    {
      "nama": "Aisyah Kusumawati",
      "nim": "123220195",
      "kelas": "IF-A",
      "foto": "assets/cica.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text("Daftar Anggota"),
        backgroundColor: Colors.blue[300],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: anggota.length,
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final a = anggota[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 12),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      a["foto"]!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    a["nama"]!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${a["nim"]!}  |  ${a["kelas"]!}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}