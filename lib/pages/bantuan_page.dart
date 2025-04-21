import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BantuanPage extends StatelessWidget {
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text("Konfirmasi Logout"),
          content: Text("Apakah Anda yakin ingin keluar dari aplikasi?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(), // Batal
              child: Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // Tutup dialog
                _logout(context); // Panggil fungsi logout
              },
              child: Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text("Bantuan"),
        backgroundColor: Colors.blue[300],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bantuan Penggunaan Aplikasi",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 16),
            Text(
              "1. Gunakan menu utama untuk memilih fitur.\n"
              "2. Gunakan tiap fitur sesuai dengan petunjuk dari masing - masing fitur.\n"
              "3. Gunakan tombol navigasi untuk kembali ke Menu Utama.\n"
              "4. Untuk keluar, tekan tombol Logout di bawah.",
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            Spacer(),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.logout),
                label: Text("Logout"),
                onPressed: () => _showLogoutConfirmation(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}