import 'package:flutter/material.dart';

class BilanganPage extends StatefulWidget {
  @override
  _BilanganPageState createState() => _BilanganPageState();
}

class _BilanganPageState extends State<BilanganPage> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";

  void _checkBilangan() {
    String input = _controller.text.trim();
    if (input.isEmpty) return;

    double? number = double.tryParse(input);
    if (number == null) {
      setState(() {
        _result = "Input bukan angka yang valid.";
      });
      return;
    }

    List<String> types = [];

    if (number == number.roundToDouble()) {
      int intNumber = number.toInt();

      // Prima
      if (intNumber > 1 && isPrima(intNumber)) {
        types.add("Bilangan Prima");
      }

      // Cacah
      if (intNumber >= 0) {
        types.add("Bilangan Cacah");
      }

      // Bulat Positif / Negatif
      if (intNumber > 0) {
        types.add("Bilangan Bulat Positif");
      } else if (intNumber < 0) {
        types.add("Bilangan Bulat Negatif");
      } else {
        types.add("Nol");
      }
    } else {
      types.add("Bilangan Desimal");
    }

    setState(() {
      _result = types.join(", ");
    });
  }

  bool isPrima(int number) {
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
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Masukkan angka",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkBilangan,
              child: Text("Cek Jenis Bilangan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20),
            Visibility(
              visible: _result.isNotEmpty,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _result,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}