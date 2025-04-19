import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  List<Duration> _laps = [];
  List<Duration> _lapDurations = [];

  bool _isStopped = false;

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
  }

  void _startStopwatch() {
    _stopwatch.start();
    _startTimer();
    setState(() {
      _isStopped = false;
    });
  }

  void _stopStopwatch() {
    _stopwatch.stop();
    _timer?.cancel();
    setState(() {
      _isStopped = true;
    });
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    _stopwatch.stop();
    _timer?.cancel();
    _laps.clear();
    _lapDurations.clear();
    setState(() {
      _isStopped = false;
    });
  }

  void _recordLap() {
    final now = _stopwatch.elapsed;
    final lastLapTime = _laps.isNotEmpty ? _laps.first : Duration.zero;
    final lapTime = now - lastLapTime;

    setState(() {
      _laps.insert(0, now);
      _lapDurations.insert(0, lapTime);
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final ms = (duration.inMilliseconds % 1000).toString().padLeft(3, '0').substring(0, 2);
    return "${twoDigits(duration.inMinutes % 60)}:${twoDigits(duration.inSeconds % 60)},$ms";
  }

  @override
  void dispose() {
    _timer?.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isRunning = _stopwatch.isRunning;
    bool isReset = _stopwatch.elapsedMilliseconds == 0;

    String mainButtonText;
    VoidCallback? mainButtonAction;

    if (isRunning) {
      mainButtonText = "Stop";
      mainButtonAction = _stopStopwatch;
    } else if (!isReset && _isStopped) {
      mainButtonText = "Lanjutkan";
      mainButtonAction = _startStopwatch;
    } else {
      mainButtonText = "Start";
      mainButtonAction = _startStopwatch;
    }

    Duration? fastest = _lapDurations.isNotEmpty ? _lapDurations.reduce((a, b) => a < b ? a : b) : null;
    Duration? slowest = _lapDurations.isNotEmpty ? _lapDurations.reduce((a, b) => a > b ? a : b) : null;

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text('Stopwatch'),
        backgroundColor: Colors.blue[300],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 60),
          Center(
            child: Text(
              _formatDuration(_stopwatch.elapsed),
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: isRunning ? _recordLap : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text('Lap'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: mainButtonAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isRunning ? Colors.orangeAccent : Colors.blue[400],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(mainButtonText),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _resetStopwatch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text('Reset'),
              ),
            ],
          ),
          SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: _lapDurations.length,
              itemBuilder: (context, index) {
                final lapDuration = _lapDurations[index];

                Color textColor;
                if (lapDuration == fastest) {
                  textColor = Colors.green;
                } else if (lapDuration == slowest) {
                  textColor = Colors.red;
                } else {
                  textColor = Colors.black;
                }

                return ListTile(
                  title: Text(
                    'Lap ${_lapDurations.length - index}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  trailing: Text(
                    _formatDuration(lapDuration),
                    style: TextStyle(
                      fontFamily: 'Courier', // Samakan font untuk semua
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}