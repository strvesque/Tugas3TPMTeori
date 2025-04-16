import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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
    LocationPermission permission;

    // Cek apakah lokasi aktif
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _status = "Layanan lokasi tidak aktif.";
      });
      return;
    }

    // Cek permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _status = "Izin lokasi ditolak.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _status = "Izin lokasi ditolak permanen.";
      });
      return;
    }

    // Ambil posisi saat ini
    Geolocator.getPositionStream(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    ).listen((Position pos) {
      setState(() {
        _position = pos;
        _status = "Lokasi berhasil didapat.";
      });
    });
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