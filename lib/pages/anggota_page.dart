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
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(a["foto"]!),
              ),
              title: Text(
                a["nama"]!,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text("NIM: ${a["nim"]!} - Kelas: ${a["kelas"]!}"),
            ),
          );
        },
      ),
    );
  }
}
