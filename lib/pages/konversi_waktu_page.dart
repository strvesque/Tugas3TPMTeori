import 'package:flutter/material.dart';

class KonversiWaktuPage extends StatefulWidget {
  @override
  _KonversiWaktuPageState createState() => _KonversiWaktuPageState();
}

class _KonversiWaktuPageState extends State<KonversiWaktuPage> {
  final TextEditingController detikController = TextEditingController();
  final TextEditingController jamController = TextEditingController();
  final TextEditingController menitController = TextEditingController();
  final TextEditingController detik2Controller = TextEditingController();

  String hasilKonversi1 = "";
  String hasilKonversi2 = "";

  void konversiKeWaktu() {
    int? detik = int.tryParse(detikController.text);
    if (detik == null || detik < 0) {
      setState(() {
        hasilKonversi1 = "Input tidak valid.";
      });
      return;
    }

    int jam = detik ~/ 3600;
    int menit = (detik % 3600) ~/ 60;
    int sisaDetik = detik % 60;

    setState(() {
      hasilKonversi1 = "$jam jam, $menit menit, $sisaDetik detik";
    });
  }

  void konversiKeDetik() {
    int? jam = int.tryParse(jamController.text);
    int? menit = int.tryParse(menitController.text);
    int? detik = int.tryParse(detik2Controller.text);

    if (jam == null || menit == null || detik == null || jam < 0 || menit < 0 || detik < 0) {
      setState(() {
        hasilKonversi2 = "Input tidak valid.";
      });
      return;
    }

    int total = (jam * 3600) + (menit * 60) + detik;

    setState(() {
      hasilKonversi2 = "$total detik";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text("Konversi Waktu"),
        backgroundColor: Colors.blue[300],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Detik → Jam:Menit:Detik",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: detikController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Masukkan detik",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: konversiKeWaktu,
                      child: Text("Konversi"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[400],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    if (hasilKonversi1.isNotEmpty) ...[
                      SizedBox(height: 10),
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            hasilKonversi1,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Jam:Menit:Detik → Detik",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: jamController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Jam",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: menitController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Menit",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: detik2Controller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Detik",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: konversiKeDetik,
                      child: Text("Konversi"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[400],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    if (hasilKonversi2.isNotEmpty) ...[
                      SizedBox(height: 10),
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            hasilKonversi2,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}