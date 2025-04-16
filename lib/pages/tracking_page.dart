import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class TrackingPage extends StatefulWidget {
  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  Position? _position;
  String _status = "Mengambil lokasi...";

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;

    // Cek apakah layanan lokasi aktif
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _status = "Layanan lokasi tidak aktif.";
      });
      return;
    }

    // Meminta izin lokasi menggunakan permission_handler
    PermissionStatus permissionStatus = await Permission.location.request();

    if (permissionStatus != PermissionStatus.granted) {
      setState(() {
        _status = "Izin lokasi ditolak.";
      });
      return;
    }

    // Jika izin diberikan, lanjutkan mengambil lokasi
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _position = position;
        _status = "Lokasi berhasil didapat.";
      });

      // Setelah mendapatkan posisi pertama, mulai stream lokasi
      Geolocator.getPositionStream(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      ).listen((Position pos) {
        setState(() {
          _position = pos;
        });
      });
    } catch (e) {
      setState(() {
        _status = "Gagal mendapatkan lokasi: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String locationText = _position != null
        ? "Latitude: ${_position!.latitude}\nLongitude: ${_position!.longitude}"
        : _status;

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text("Tracking Lokasi"),
        backgroundColor: Colors.blue[300],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, size: 48, color: Colors.blue[700]),
                SizedBox(height: 16),
                Text(
                  "Informasi Lokasi",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  locationText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}