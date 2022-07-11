import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gokkusagiapp/variables.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color screenColor = ColorItems.startColor;
  bool textVisibility = true;
  Timer? timer;
  bool sayacSwitch = true;
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        overlayOpacity: 0,
        backgroundColor: Colors.black,
        animatedIcon: AnimatedIcons.play_pause,
        children: [
          SpeedDialChild(
              child: const Text("X"),
              onTap: () {
                timer?.cancel();
                sayacSwitch = true;
                setState(() {});
              }),
          SpeedDialChild(
              child: const Text(StringItems.speedDialButon1),
              onTap: () {
                setState(() {
                  timer?.cancel();
                  sayacSwitch = true;
                  startTimer(1);
                });
              }),
          SpeedDialChild(
              child: Text(StringItems.speedDialButon2),
              onTap: () {
                timer?.cancel();
                sayacSwitch = true;
                startTimer(3);
              }),
          SpeedDialChild(
              child: const Text(StringItems.speedDialButon3),
              onTap: () {
                timer?.cancel();
                sayacSwitch = true;
                startTimer(5);
              }),
          SpeedDialChild(
              child: Icon(Icons.remove_red_eye_sharp),
              onTap: () {
                setState(() {
                  TextVisibilityChanger();
                });
              }),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          screenColor = randomColorCreater();
          setState(() {});
        },
        child: Container(
          alignment: Alignment.center,
          color: screenColor,
          child: Visibility(
            visible: textVisibility,
            child: Text(
              'RGB(${screenColor.red}, ${screenColor.green}, ${screenColor.blue})',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  Color randomColorCreater() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  void startTimer(int repeatSeconds) {
    if (sayacSwitch) {
      timer = Timer.periodic(Duration(seconds: repeatSeconds), (timer) {
        sayacSwitch = false;
        setState(() {
          screenColor = randomColorCreater();
        });
      });
    }
  }

  void TextVisibilityChanger() {
    textVisibility = !textVisibility;
  }
}
