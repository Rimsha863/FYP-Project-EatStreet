import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:lottie/lottie.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  CountDownController _controller = CountDownController();
  bool _isPause = false;
  Duration _duration = Duration(minutes: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularCountDownTimer(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 2,
          duration: 14,
          fillColor: Colors.amber,
          color: Colors.white,
          controller: _controller,
          backgroundColor: Colors.white,
          strokeWidth: 10.0,
          strokeCap: StrokeCap.round,
          isTimerTextShown: true,
          isReverse: false,
          onComplete: () {
            // Alert(
            //         context: context,
            //         title: 'Done',
            //         style: AlertStyle(
            //             isCloseButton: true,
            //             isButtonVisible: false,
            //             titleStyle:
            //                 TextStyle(color: Colors.white, fontSize: 30.0)),
            //         type: AlertType.success)
            //     .show();
          },
          textStyle: TextStyle(fontSize: 50.0, color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              if (_isPause) {
                _isPause = false;
                _controller.resume();
              } else {
                _isPause = true;
                _controller.pause();
              }
            });
          },
          icon: Icon(_isPause ? Icons.play_arrow : Icons.pause),
          label: Text(_isPause ? "Resume" : "Pause")),
    );
  }
}

// class Timer extends StatefulWidget {
//   @override
//   _TimerState createState() => _TimerState();
// }

// class _TimerState extends State<Timer> {
//   CountDownController _controller = CountDownController();
//   bool _isPause = false;

//   //int initalValue = 60;
//   //Timer _timer;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //  _timer = Timer.periodic(duration, callback) {
//   //     // });
//   //   });
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.asset(
//               'assets/logo1.png',
//               width: 200.0,
//               height: 200.0,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Lottie.asset('assets/clock.json'),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               initalValue?.toString() ?? "",
//               style: TextStyle(fontSize: 72),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class Timer extends StatefulWidget {
// //   @override
// //   _timerState createState() => _timerState();
// // }

// // class _timerState extends State<timer> {
// //   int _counter = 0;
// //   int _counter2 = 20;
// //   Timer _timer;

// //   void _startTimer() {
// //     _counter = 0;
// //     if (_timer != null) {
// //       _timer.cancel();
// //     }
// //     _timer = Timer.periodic(Duration(minutes: 1), (timer) {
// //       setState(() {
// //         if (_counter2 > 0) {
// //           _counter2--;
// //         } else {
// //           _timer.cancel();
// //         }
// //       });
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Column(
// //         children: [
// //           Align(
// //             alignment: Alignment.center,
// //             child: Image.asset(
// //               'assets/logo1.png',
// //               width: 200.0,
// //               height: 200.0,
// //             ),
// //           ),
// //           SizedBox(
// //             height: 10,
// //           ),
// //           (_counter2 > 0)
// //               ? Text("")
// //               : Text(
// //                   "Your Food Is Ready",
// //                   style: TextStyle(
// //                       color: Colors.green,
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 20),
// //                 ),
// //           Text(
// //             '$_counter' + " - " + '$_counter2' + 'mins',
// //             style: TextStyle(
// //               fontWeight: FontWeight.bold,
// //               fontSize: 20,
// //             ),
// //           ),
// //           SizedBox(
// //             height: 10,
// //           ),
// //           Column(
// //             children: [
// //               Lottie.asset('assets/cook.json'),
// //               SizedBox(
// //                 height: 5,
// //               ),
// //               Column(
// //                 children: [
// //                   Lottie.asset('assets/loader.json'),
// //                 ],
// //               )
// //             ],
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }
