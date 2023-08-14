// ignore_for_file: constant_pattern_never_matches_value_type

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro/models/pomodoro_status.dart';
import 'package:pomodoro/utils/constants.dart';
import 'widget/progress_icons.dart';
import 'widget/custom_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const MaterialColor primaryBlack = MaterialColor(
    _blackPrimaryValue,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(_blackPrimaryValue),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
  static const int _blackPrimaryValue = 0xFF000000;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'PomodoroAPP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const _btnTextStart = 'START POMODORO';
const _btnTextResumePomodoro = 'RESUME POMODORO';
const _btnTextResumeBreak = 'RESUME BREAK';
const _btnTextStartShortBreak = 'TAKE SHORT BREAK';
const _btnTextStartLongBreak = 'TAKE LONG BREAK';
const _btnTextStartNewSet = ' START NEW SET';
const _btnTextPause = 'PAUSE';
const _btnTextReset = 'RESET';
Timer? _timer;

class _MyHomePageState extends State<MyHomePage> {
  int remainingTime = pomodoroTotalTime;
  String mainBtnText = _btnTextStart;
  int pomodoroNum = 0;
  int setNum = 0;
  PomodoroStatus pomodoroStatus = PomodoroStatus.pausedPomodoro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyApp.primaryBlack,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyApp.primaryBlack,
        // ignore: prefer_const_constructors
        title: Text(
          'SEJA MAIS PRODUTIVO',
          style:
              // ignore: prefer_const_constructors
              TextStyle(color: Color(0xffffffff), fontWeight: FontWeight.w900),
        ),
      ),
      // ignore: prefer_const_constructors
      body: SafeArea(
        // ignore: prefer_const_constructors
        child: Center(
          // ignore: prefer_const_constructors
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Sequencia do Pomodoro $pomodoroNum',
                style: const TextStyle(fontSize: 22, color: Colors.white),
              ),
              // ignore: prefer_const_constructors
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 120.0,
                      lineWidth: 5.0,
                      percent: 0.3,
                      circularStrokeCap: CircularStrokeCap.round,
                      // ignore: prefer_const_constructors
                      center: Text(_secondsToFormatedString(remainingTime),
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.w900)),
                      progressColor: statusColor[pomodoroStatus],
                      // ignore: prefer_const_constructors
                    ),
                    // ignore: prefer_const_constructors
                    ProgressIcons(
                      total: pomodoroPerSet,
                      done: pomodoroNum - (setNum * pomodoroPerSet),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      statusDescription[pomodoroStatus]!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButtom(onTap: _mainButtonPressed, text: mainBtnText),
                    CustomButtom(onTap: () {}, text: 'Zerar'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _secondsToFormatedString(int seconds) {
    int roundedMinutes = seconds ~/ 60;
    int remainingSeconds = seconds - (roundedMinutes * 60);
    String remainingSecondsFormated;

    if (remainingSeconds < 10) {
      remainingSecondsFormated = '0$remainingSeconds';
    } else {
      remainingSecondsFormated = remainingSeconds.toString();
    }
    return '$roundedMinutes:$remainingSecondsFormated';
  }

  _mainButtonPressed() {
    switch (pomodoroStatus) {
      case PomodoroStatus.pausedPomodoro:
        _startPomodoroCountdown();
        break;
      case PomodoroStatus.runningPomodoro:
        {}
        break;
      case PomodoroStatus.pausedShortBreak:
        {}
        break;
      case PomodoroStatus.runningLongBreak:
        {}
        break;
      case PomodoroStatus.pausedLongBreak:
        {}
        break;
      case PomodoroStatus.setFinished:
        {}
        break;
      default:
    }
  }

  _startPomodoroCountdown() {
    pomodoroStatus = PomodoroStatus.runningPomodoro;

    _cancelTimer();
    _timer = Timer.periodic(
        // ignore: prefer_const_constructors
        Duration(seconds: 1),
        (timer) => {
              if (remainingTime > 0)
                {
                  setState(() {
                    remainingTime--;
                    mainBtnText = _btnTextPause;
                  })
                }
              else
                {
                  //playSound(),
                  pomodoroNum++,
                  _cancelTimer(),
                  if (pomodoroNum % pomodoroPerSet == 0)
                    {
                      pomodoroStatus = PomodoroStatus.pausedLongBreak,
                      setState(() {
                        remainingTime = longBreakTime;
                        mainBtnText = _btnTextStartLongBreak;
                      }),
                    }
                  else
                    {
                      pomodoroStatus = PomodoroStatus.pausedShortBreak,
                      setState(() {
                        remainingTime = shortBreakTime;
                        mainBtnText = _btnTextStartShortBreak;
                      }),
                    }
                }
            });
  }

  _cancelTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }
  }
}
