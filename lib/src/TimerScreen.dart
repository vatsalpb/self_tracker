import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'package:selftracker/src/TimerSettingScreen.dart';

class TimerScreen extends StatefulWidget {
  createState() {
    return AppStateKeeper();
  }
}

class AppStateKeeper extends State<TimerScreen> {
  final barColor = Colors.redAccent;
  final bgColor = Colors.white;
  String time = "25:00";
  int _currentTime = 0;
  int timePassedIn = 1500;
  CountdownTimer countDownTimer;

  Widget build(context) {
    return Scaffold(
      body: Center(
        child: Text(
          '$time',
          style: TextStyle(fontSize: 100, color: barColor),
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.bottomCenter,
              child: timedFloatingActionButton(barColor, timePassedIn, 'WORK')),
        ],
      ),
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('Self Tracker'),
        backgroundColor: barColor,
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                //Navigator.pushNamed(context, '/second');
                countDownTimer?.cancel();
                _navigateAndDisplaySelection(context);
              })
        ],
      ),
    );
  }

  /// Starts a timer based on the second passed in.
  void startTimer(int _start) {
    countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    StreamSubscription sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _currentTime = _start - duration.elapsed.inSeconds;
        String minute = (_currentTime ~/ 60).toString();
        String seconds = (_currentTime % 60).toString();
        if (minute.length == 1) {
          minute = "0" + minute;
        }
        if (seconds.length == 1) {
          seconds = "0" + seconds;
        }
        time = minute + ":" + seconds;
      });
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }

  /// Takes color and time and starts timer and returns the button.
  FloatingActionButton timedFloatingActionButton(
      Color color, int time, String buttonTag) {
    return FloatingActionButton.extended(
      icon: Icon(
        Icons.play_circle_outline,
      ),
      label: Text(buttonTag),
      backgroundColor: color,
      onPressed: () {
        if (countDownTimer == null) {
          startTimer(time);
        } else {
          countDownTimer.cancel();
          startTimer(time);
        }
      },
    );
  }

  // A method that launches the SelectionScreen and awaits the result from
  // Navigator.pop.
  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TimerSettingScreen()),
    );
    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      timePassedIn = result;
      String minute = (timePassedIn ~/ 60).toString();
      String seconds = (timePassedIn % 60).toString();
      if (minute.length == 1) {
        minute = "0" + minute;
      }
      if (seconds.length == 1) {
        seconds = "0" + seconds;
      }
      time = minute + ":" + seconds;
    });
  }
}
