import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RekomendasiPage extends StatefulWidget {
  @override
  _RekomendasiPageState createState() => _RekomendasiPageState();
}

class _RekomendasiPageState extends State<RekomendasiPage> {
  final List<Map<String, String>> sites = [
    {
      "nama": "TXT Discography",
      "url": "https://ibighit.com/txt/eng/discography/",
      "image":
          "assets/txt.png"
    },
    {
      "nama": "Youtube",
      "url": "https://www.youtube.com/",
      "image":
          "assets/yt.jpg"
    },
    {
      "nama": "Numuki",
      "url": "https://www.numuki.com/",
      "image":
          "assets/numuki.jpg"
    },
    {
      "nama": "Chat GPT",
      "url": "https://chatgpt.com/",
      "image":
          "assets/gpt.png"
    },
    {
      "nama": "Wikipedia",
      "url": "https://www.wikipedia.org",
      "image":
          "assets/wikipedia.png"
    },
  ];

  final Set<String> favoriteUrls = Set();

  Future<void> _launchUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tidak bisa membuka URL: $url')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan saat membuka URL: $url')),
      );
    }
  }

  void _toggleFavorite(String url) {
    setState(() {
      if (favoriteUrls.contains(url)) {
        favoriteUrls.remove(url);
      } else {
        favoriteUrls.add(url);
      }
    });
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
          final site = sites[index];
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    site["image"]!,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 160,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Icon(Icons.broken_image,
                          size: 60, color: Colors.grey[600]),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    site["nama"]!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue[800]),
                  ),
                  subtitle: InkWell(
                    child: Text(
                      site["url"]!,
                      style: TextStyle(
                          color: Colors.blue[600],
                          decoration: TextDecoration.underline),
                    ),
                    onTap: () => _launchUrl(site["url"]!),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      favoriteUrls.contains(site["url"]!)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favoriteUrls.contains(site["url"]!)
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onPressed: () => _toggleFavorite(site["url"]!),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
