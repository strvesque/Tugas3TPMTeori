import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RekomendasiPage extends StatelessWidget {
  final List<Map<String, String>> sites = [
    {"nama": "Khan Academy", "url": "https://www.khanacademy.org"},
    {"nama": "Coursera", "url": "https://www.coursera.org"},
    {"nama": "Dicoding", "url": "https://www.dicoding.com"},
    {"nama": "Flutter", "url": "https://flutter.dev"},
    {"nama": "Wikipedia", "url": "https://www.wikipedia.org"},
  ];

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Tidak bisa membuka URL: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text("Rekomendasi Situs"),
        backgroundColor: Colors.blue[300],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: sites.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              title: Text(
                sites[index]["nama"]!,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[800]),
              ),
              subtitle: Text(sites[index]["url"]!),
              trailing: Icon(Icons.open_in_browser, color: Colors.blue[600]),
              onTap: () => _launchUrl(sites[index]["url"]!),
            ),
          );
        },
      ),
    );
  }
}