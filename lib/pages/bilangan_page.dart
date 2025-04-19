import 'package:flutter/material.dart';

class BilanganPage extends StatefulWidget {
  @override
  _BilanganPageState createState() => _BilanganPageState();
}

class _BilanganPageState extends State<BilanganPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> hasilJenisBilangan = [];

  void _cekJenisBilangan() {
    String input = _controller.text.trim();
    if (input.isEmpty) return;

    double? number = double.tryParse(input);
    if (number == null) {
      setState(() {
        hasilJenisBilangan = ["Input bukan angka yang valid."];
      });
      return;
    }

    List<String> jenis = [];

    bool isDesimal = number % 1 != 0;

    if (!isDesimal) {
      int intNumber = number.toInt();

      // Cacah
      if (intNumber >= 0) jenis.add("Cacah");

      // Bulat Positif / Negatif / Nol
      if (intNumber > 0) {
        jenis.add("Bulat Positif");
      } else if (intNumber < 0) {
        jenis.add("Bulat Negatif");
      } else {
        jenis.add("Nol");
      }

      // Prima
      if (intNumber > 1 && _isPrima(intNumber)) {
        jenis.add("Prima");
      }
    } else {
      jenis.add("Desimal");
    }

    setState(() {
      hasilJenisBilangan = jenis;
    });
  }

  bool _isPrima(int number) {
    for (int i = 2; i <= number ~/ 2; i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text('Jenis Bilangan'),
        backgroundColor: Colors.blue[300],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: "Masukkan Angka",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _cekJenisBilangan,
              child: Text("Cek Bilangan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 30),
            if (hasilJenisBilangan.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: hasilJenisBilangan.map((jenis) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Icon(Icons.circle, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          jenis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue[900],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}