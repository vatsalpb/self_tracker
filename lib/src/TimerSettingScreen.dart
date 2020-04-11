import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerSettingScreen extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => TimerSettingState();
}

class TimerSettingState extends State<TimerSettingScreen> {
  var value = new Duration(minutes: 25).toString().substring(2, 7);
  int seconds = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Second Route"),
        leading: BackButton(
          onPressed: () => Navigator.pop(context, seconds),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  "$value",
                  style: TextStyle(fontSize: 100, color: Colors.redAccent),
                ),
              ),
            ),
            CupertinoTimerPicker(
              initialTimerDuration: new Duration(minutes: 25),
              mode: CupertinoTimerPickerMode.ms,
              onTimerDurationChanged: (value) {
                setState(() {
                  seconds = value.inSeconds;
                  this.value = value.toString().substring(2, 7);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
