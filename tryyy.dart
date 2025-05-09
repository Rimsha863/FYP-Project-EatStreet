import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:lottie/lottie.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class SampleApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SampleAppState();
  }
}

class SampleAppState extends State<SampleApp> {
  DateTime alert;

  @override
  void initState() {
    super.initState();
    alert = DateTime.now().add(Duration(minutes: 1));
    print("sunnnnnnyyyyyy");
    print(alert);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Food Status'),
        ),
        body: SizedBox.expand(
          child: DraggableScrollableSheet(
              // initialChildSize: 0.2,
              // minChildSize: 0.6,
              // maxChildSize: 0.8,
              builder: (BuildContext c, s) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                    )
                  ]),
              child: ListView(controller: s, children: [
                Center(
                  child: Container(
                    height: 8,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/logo1.png',
                      width: 100.0,
                      height: 100.0,
                    ),
                    TimerBuilder.scheduled([alert], builder: (context) {
                      // This function will be called once the alert time is reached
                      var now = DateTime.now();
                      var reached = now.compareTo(alert) >= 0;
                      final textStyle = Theme.of(context).textTheme.title;
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // Lottie.asset('assets/clock.json'),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Icon(
                            //   reached ? Icons.alarm_on: Icons.alarm,
                            //   color: reached ? Colors.red: Colors.green,
                            //   size: 48,
                            // ),
                            !reached
                                ? TimerBuilder.periodic(Duration(seconds: 1),
                                    alignment: Duration.zero,
                                    builder: (context) {
                                    // This function will be called every second until the alert time
                                    var now = DateTime.now();
                                    var remaining = alert.difference(now);
                                    return Column(
                                      children: [
                                        Lottie.asset('assets/clock.json',
                                            width: 80, height: 80),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          formatDuration(remaining),
                                          style: textStyle,
                                        ),
                                        Row(
                                          children: [
                                            Column(children: [
                                              Lottie.asset('assets/cook.json',
                                                  width: 80, height: 80),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Lottie.asset('assets/chain.json',
                                                  width: 50, height: 50),
                                            ]),
                                            alert == 19.00
                                                ? Lottie.asset(
                                                    'assets/cook.json',
                                                    width: 80,
                                                    height: 80)
                                                : Lottie.asset(
                                                    'assets/chain.json',
                                                    width: 50,
                                                    height: 50),
                                          ],
                                        )
                                      ],
                                    );
                                  })
                                : TimerBuilder.periodic(Duration(seconds: 1),
                                    alignment: Duration.zero,
                                    builder: (context) {
                                    // This function will be called every second until the alert time
                                    var now = DateTime.now();
                                    var remaining = alert.difference(now);
                                    return Column(
                                      children: [
                                        Lottie.asset('assets/clock.json',
                                            width: 80, height: 80),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          formatDuration(remaining),
                                          style: textStyle,
                                        ),
                                        Row(
                                          children: [
                                            Column(children: [
                                              Lottie.asset('assets/cook.json',
                                                  width: 80, height: 80),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Lottie.asset('assets/chain.json',
                                                  width: 50, height: 50),
                                            ]),
                                            alert == 19.00
                                                ? Lottie.asset(
                                                    'assets/cook.json',
                                                    width: 80,
                                                    height: 80)
                                                : Lottie.asset(
                                                    'assets/chain.json',
                                                    width: 50,
                                                    height: 50),
                                          ],
                                        )
                                      ],
                                    );
                                  })
                            //Text("Alert", style: textStyle),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ]),
              //theme: ThemeData(backgroundColor: Colors.white),
            );
          }),
        ),
      ),
    );
  }

  String formatDuration(Duration d) {
    String f(int n) {
      return n.toString().padLeft(2, '0');
    }

    // We want to round up the remaining time to the nearest second
    d += Duration(microseconds: 999999);
    return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
  }
}
