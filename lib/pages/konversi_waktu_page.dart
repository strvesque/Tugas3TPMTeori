import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KonversiWaktuPage extends StatefulWidget {
  @override
  State<KonversiWaktuPage> createState() => _KonversiWaktuPageState();
}

class _KonversiWaktuPageState extends State<KonversiWaktuPage> {
  final tahunController = TextEditingController();
  final jamController = TextEditingController();
  final menitController = TextEditingController();
  final detikController = TextEditingController();

  final formatter = NumberFormat("#.#############################");

  bool isEditing = false;

  void updateFromTahun(String value) {
    if (isEditing) return;
    isEditing = true;
    final tahun = double.tryParse(value);
    if (tahun != null) {
      final totalJam = tahun * 8760;
      final totalMenit = tahun * 525600;
      final totalDetik = tahun * 31536000;

      jamController.text = formatter.format(totalJam);
      menitController.text = formatter.format(totalMenit);
      detikController.text = formatter.format(totalDetik);
    } else {
      jamController.clear();
      menitController.clear();
      detikController.clear();
    }
    isEditing = false;
  }

  void updateFromJam(String value) {
    if (isEditing) return;
    isEditing = true;
    final jam = double.tryParse(value);
    if (jam != null) {
      final tahun = jam / 8760;
      final totalMenit = tahun * 525600;
      final totalDetik = tahun * 31536000;

      tahunController.text = formatter.format(tahun);
      menitController.text = formatter.format(totalMenit);
      detikController.text = formatter.format(totalDetik);
    } else {
      tahunController.clear();
      menitController.clear();
      detikController.clear();
    }
    isEditing = false;
  }

  void updateFromMenit(String value) {
    if (isEditing) return;
    isEditing = true;
    final menit = double.tryParse(value);
    if (menit != null) {
      final tahun = menit / 525600;
      final totalJam = tahun * 8760;
      final totalDetik = tahun * 31536000;

      tahunController.text = formatter.format(tahun);
      jamController.text = formatter.format(totalJam);
      detikController.text = formatter.format(totalDetik);
    } else {
      tahunController.clear();
      jamController.clear();
      detikController.clear();
    }
    isEditing = false;
  }

  void updateFromDetik(String value) {
    if (isEditing) return;
    isEditing = true;
    final detik = double.tryParse(value);
    if (detik != null) {
      final tahun = detik / 31536000;
      final totalJam = tahun * 8760;
      final totalMenit = tahun * 525600;

      tahunController.text = formatter.format(tahun);
      jamController.text = formatter.format(totalJam);
      menitController.text = formatter.format(totalMenit);
    } else {
      tahunController.clear();
      jamController.clear();
      menitController.clear();
    }
    isEditing = false;
  }

  @override
  void dispose() {
    tahunController.dispose();
    jamController.dispose();
    menitController.dispose();
    detikController.dispose();
    super.dispose();
  }

  Widget buildInput(String label, TextEditingController controller,
      Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text("Konversi Waktu Otomatis"),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Silahkan isi salah satu kolom dibawah ini. Hasil konversi akan muncul secara otomatis.",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            buildInput("Tahun", tahunController, updateFromTahun),
            buildInput("Jam", jamController, updateFromJam),
            buildInput("Menit", menitController, updateFromMenit),
            buildInput("Detik", detikController, updateFromDetik),
          ],
        ),
      ),
    );
  }
}