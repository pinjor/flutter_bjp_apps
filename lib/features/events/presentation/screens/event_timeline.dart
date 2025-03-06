import 'dart:async';

import 'package:flutter/material.dart';


class ProgramTimeline extends StatefulWidget {
  const ProgramTimeline({super.key});


  @override
  State<ProgramTimeline> createState() => _ProgramTimelineState();
}

class _ProgramTimelineState extends State<ProgramTimeline> {
  int _remainingSeconds = 3600; // 1 hour countdown
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--; // Decrease time by 1 second
        });
      } else {
        _timer.cancel(); // Stop timer when it reaches zero
      }
    });
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'প্রোগ্রামের সময়সূচী',
          //style: TextStyle(color: Colors.cyan),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Image.asset(
              'assets/images/picture_of_mans.png',
              height: 250,
              width: 400,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
