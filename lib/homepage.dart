import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
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
  CircleColorPickerController? colorController;
  bool startToFix = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        overlayOpacity: 0,
        backgroundColor: Colors.black,
        animatedIcon: AnimatedIcons.play_pause,
        children: [
          SpeedDialChild(
              child: Icon(Icons.stop),
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
                  startTimer(1000);
                });
              }),
          SpeedDialChild(
              child: Text(StringItems.speedDialButon2),
              onTap: () {
                timer?.cancel();
                sayacSwitch = true;
                startTimer(3000);
              }),
          SpeedDialChild(
              child: const Text(StringItems.speedDialButon3),
              onTap: () {
                timer?.cancel();
                sayacSwitch = true;
                startTimer(5000);
              }),
          SpeedDialChild(
              child: textVisibility ? Icon(Icons.visibility_off) : Icon(Icons.remove_red_eye_sharp),
              onTap: () {
                setState(() {
                  TextVisibilityChanger();
                });
              }),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          timer?.cancel();
          sayacSwitch = true;
          screenColor = randomColorCreater();
          if (startToFix) {
            textVisibility = true;
          }
          startToFix = false;

          setState(() {});
        },
        child: Container(
          alignment: Alignment.center,
          color: screenColor,
          child: Visibility(
            visible: textVisibility,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'RGB(${screenColor.red}, ${screenColor.green}, ${screenColor.blue})',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                    height: 280,
                    child: CircleColorPicker(
                      textStyle: TextStyle(color: Colors.white, fontSize: 20),
                      onChanged: (value) {
                        screenColor = value;
                        setState(() {});
                      },

                      controller: colorController,
                      size: const Size(260, 260),
                      strokeWidth: 5, //cember kalinligi
                      thumbSize: 34,
                    )),
                ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black)),
                    onPressed: () {
                      startToFix = true;
                      textVisibility = false;
                      startTimer(100);
                    },
                    child: Text("Start to Fix")),
                SizedBox(
                  height: 35,
                )
              ],
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
      timer = Timer.periodic(Duration(milliseconds: repeatSeconds), (timer) {
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
