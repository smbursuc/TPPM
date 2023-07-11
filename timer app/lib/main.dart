import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:swipedetector/swipedetector.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int hour_value = 0;
  int minute_value = 0;
  int second_value = 0;
  int hold_value = 0;
  bool is_done = false;
  String status = "";
  int total_time = 0;
  int time_passed = 0;
  bool paused = false;
  bool is_running = false;
  int old_total_time = 0;

  late Timer increment_timer;
  Timer timer = Timer(Duration.zero, () {});

  void _startTimer(String what) {
    increment_timer = Timer.periodic(
        Duration(milliseconds: 300),
        (t) => setState(() {
              if (hold_value <= 20) {
                hold_value += 1;
              }
              int increment_val = (0.4 * hold_value).toInt();
              increment(what, increment_val);
            }));
  }

  void _stopTimer() {
    increment_timer.cancel();
    hold_value = 0;
  }

  void increment(String what, int increment_value) {
    setState(() {
      if (what == "hours") {
        hour_value = hour_value + increment_value;
      } else if (what == "minutes") {
        if (minute_value + increment_value <= 59) {
          minute_value += increment_value;
        } else {
          hour_value += 1;
          minute_value = minute_value + increment_value - 60;
        }
      } else {
        if (second_value + increment_value <= 59) {
          second_value += increment_value;
        } else {
          minute_value += 1;
          if (minute_value >= 60) {
            hour_value += 1;
            minute_value = 0;
          }
          second_value = second_value + increment_value - 60;
        }
      }
    });
  }

  void decrement(String what) {
    setState(() {
      if (what == "hours") {
        if (hour_value != 0) {
          hour_value -= 1;
        }
      } else if (what == "minutes") {
        if (minute_value != 0) {
          minute_value -= 1;
        } else if (hour_value != 0) {
          hour_value -= 1;
          minute_value = 59;
        }
      } else {
        if (second_value != 0) {
          second_value -= 1;
        } else if (minute_value != 0) {
          minute_value -= 1;
          second_value = 59;
        } else if (hour_value != 0) {
          hour_value -= 1;
          minute_value = 59;
          second_value = 59;
        } else if (minute_value == 0 && second_value == 0 && timer.isActive) {
          is_done = true;
          is_running = false;
          cancel_timer("reset");
          status = "TIME'S UP!!!";
          playSound();
        }
      }
    });
  }

  void reset() {
    setState(() {
      if (timer.isActive) {
        cancel_timer("reset");
      }
      hour_value = minute_value = second_value = 0;
      status = "";
      player.stop();
      total_time = 0;
      time_passed = 0;
      is_running = false;
      paused = false;
    });
  }

  String display(int value) {
    if (value < 10) {
      return "0$value";
    } else {
      return "$value";
    }
  }

  void timer_start() {
    setState(() {
      time_passed = 0;
      is_running = true;
      old_total_time = second_value + minute_value * 60 + hour_value * 60 * 60;
      total_time = second_value + minute_value * 60 + hour_value * 60 * 60;
    });
    if (player.state == PlayerState.playing) {
      player.stop();
    }
    if ((second_value != 0 || minute_value != 0 || hour_value != 0) &&
        !timer.isActive) {
      setState(() {
        status = "";
      });
      timer = Timer.periodic(
          Duration(seconds: 1),
          (t) => setState(() {
                time_passed += 1;
                decrement("seconds");
              }));
    }
  }

  void cancel_timer(String canceled_by) {
    if (!paused) {
      timer.cancel();
    }
    if (paused) {
      timer = Timer.periodic(
          Duration(seconds: 1),
          (t) => setState(() {
                time_passed += 1;
                decrement("seconds");
              }));
    }
    if (canceled_by == "reset") {
      is_running = false;
    } else if (canceled_by == "pause") {
      if (!paused) {
        old_total_time =
            second_value + minute_value * 60 + hour_value * 60 * 60;
      } else {
        int aux = second_value + minute_value * 60 + hour_value * 60 * 60;
        if (aux - old_total_time < 0) {
          setState(() {
            time_passed += old_total_time - aux;
          });
        } else {
          setState(() {
            time_passed -= aux - old_total_time;
          });
        }
      }
      paused = !paused;
    }
  }

  final player = AudioPlayer();

  Future<void> playSound() async {
    await player.setVolume(0.75);
    await player.play(AssetSource("sounds/trezirea.wav"));
  }

  Widget GetBody() {
    return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      SizedBox(
          child: CircularProgressIndicator(
        backgroundColor: Colors.black,
        valueColor: AlwaysStoppedAnimation(Colors.green),
        value: total_time == 0 ? 0 : time_passed / total_time,
      ),
              height:100, width: 100,
      ),
      Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () => {decrement("hours")}, child: Text("-")),
                Text(display(hour_value)),
                GestureDetector(
                    onTapDown: (_) => {_startTimer("hours")},
                    onTapUp: (_) => {},
                    onPanDown: (_) => {increment("hours", 1)},
                    onTapCancel: () => {_stopTimer()},
                    child:
                        ElevatedButton(onPressed: () => {}, child: Text("+")))
              ]
                  .map((widget) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: widget,
                      ))
                  .toList(),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () => decrement("minutes"), child: Text("-")),
                Text(display(minute_value)),
                GestureDetector(
                    onTapDown: (_) => {_startTimer("minutes")},
                    onTapUp: (_) => {},
                    onPanDown: (_) => {increment("minutes", 1)},
                    onTapCancel: () => {_stopTimer()},
                    child:
                        ElevatedButton(onPressed: () => {}, child: Text("+")))
              ]
                  .map((widget) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: widget,
                      ))
                  .toList(),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () => decrement("seconds"), child: Text("-")),
                Text(display(second_value)),
                GestureDetector(
                    onTapDown: (_) => {_startTimer("seconds")},
                    onTapUp: (_) => {},
                    onPanDown: (_) => {increment("seconds", 1)},
                    onTapCancel: () => {_stopTimer()},
                    child:
                        ElevatedButton(onPressed: () => {}, child: Text("+")))
              ]
                  .map((widget) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: widget,
                      ))
                  .toList(),
            ),
          ])),
      Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(onPressed: reset, child: Text("Reset")),
              ElevatedButton(
                  onPressed: !is_running ? timer_start : () => {},
                  child: Text("Start")),
              ElevatedButton(
                  onPressed: () =>
                      {is_running ? cancel_timer("pause") : () => {}},
                  child: Text("Pause"))
            ]
                .map((widget) => Padding(
                      padding: const EdgeInsets.all(5),
                      child: widget,
                    ))
                .toList(),
          )),
      Padding(padding: EdgeInsets.only(bottom: 16), child: Text("$status"))
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text("Timer App")), body: GetBody()));
  }
}
