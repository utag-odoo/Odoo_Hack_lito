import 'package:flutter/material.dart';
import 'dart:async';

Widget garbageCollectorTimer() {
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      final timerKey = GlobalKey<_TimerContentState>();

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: 200,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 73, 10, 84), Color.fromARGB(255, 146, 66, 160)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: TimerContent(key: timerKey),
        ),
      );
    },
  );
}

class TimerContent extends StatefulWidget {
  const TimerContent({Key? key}) : super(key: key);

  @override
  _TimerContentState createState() => _TimerContentState();
}

class _TimerContentState extends State<TimerContent> {
  late Timer _timer;
  String _timeRemaining = '';

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    setState(() {
      _timeRemaining = _getTimeRemaining();
    });
  }

  String _getTimeRemaining() {
    final now = DateTime.now();
    var nineAM = DateTime(now.year, now.month, now.day, 9, 0);
    
    if (now.isAfter(nineAM)) {
      nineAM = nineAM.add(const Duration(days: 1));
    }

    final remaining = nineAM.difference(now);
    final hours = remaining.inHours;
    final minutes = remaining.inMinutes % 60;
    final seconds = remaining.inSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Garbage Collector Coming In:',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          _timeRemaining,
          style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}