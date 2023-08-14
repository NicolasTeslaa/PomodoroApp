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

String _btnTextStart = 'COMEÇAR';
String _btnTextResumePomodoro = 'VOLTAR AO FOCO';
String _btnTextResumeBreak = 'RETOMAR INTERVALO';
String _btnTextStartShortBreak = 'FAZER INTERVALO CURTO';
String _btnTextStartLongBreak = 'FAZER INTERVALO LONGO';
String _btnTextStartNewSet = 'INICIAR NOVA BATALHA';
String _btnTextPause = 'PAUSAR';
String _btnTextReset = 'REINICIAR';

Timer? _timer;

class _MyHomePageState extends State<MyHomePage> {
  // static AudioCache player = AudioCache();
  int remainingTime = pomodoroTotalTime;
  String mainBtnText = _btnTextStart;
  int pomodoroNum = 0;
  int setNum = 0;
  PomodoroStatus pomodoroStatus = PomodoroStatus.pausedPomodoro;

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   player.load('bell.mp3');
  // }

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
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20), // Espaçamento superior

          // ignore: prefer_const_constructors
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // ignore: prefer_const_constructors
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      children: [
                        // TextButton.icon(
                        //   icon: const Icon(Icons.alarm),
                        //   label: const Text('Tempo de foco'),
                        //   onPressed: () async {
                        //     final TimeOfDay? selectedTime =
                        //         await showTimePicker(
                        //       context: context,
                        //       initialTime: TimeOfDay.now(),
                        //       builder: (BuildContext context, Widget? child) {
                        //         return MediaQuery(
                        //           data: MediaQuery.of(context)
                        //               .copyWith(alwaysUse24HourFormat: true),
                        //           child: child!,
                        //         );
                        //       },
                        //     );

                        //     if (selectedTime != null) {
                        //       String formattedTime =
                        //           selectedTime.format(context);

                        //       showModalBottomSheet<void>(
                        //         context: context,
                        //         builder: (BuildContext context) {
                        //           return Column(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: <Widget>[
                        //               const ListTile(
                        //                 title: Text('Definir tempo de foco'),
                        //               ),
                        //               const SizedBox(height: 8),
                        //               Text(
                        //                 'Tempo selecionado: $formattedTime',
                        //                 style: TextStyle(fontSize: 16),
                        //               ),
                        //               const SizedBox(height: 8),
                        //               ElevatedButton(
                        //                 onPressed: () {
                        //                   // Processar o tempo selecionado (formattedTime)
                        //                   Navigator.pop(context);
                        //                 },
                        //                 child: const Text('Confirmar'),
                        //               ),
                        //             ],
                        //           );
                        //         },
                        //       );
                        //     }
                        //   },
                        // )
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    CircularPercentIndicator(
                      radius: 110,
                      lineWidth: 5,
                      percent: _getPomodoroPercentage(),
                      circularStrokeCap: CircularStrokeCap.round,
                      // ignore: prefer_const_constructors
                      center: Text(_secondsToFormatedString(remainingTime),
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.w900)),
                      progressColor: statusColor[pomodoroStatus],
                      backgroundColor: Colors.deepPurple.shade100,
                      // ignore: prefer_const_constructors
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    // ignore: prefer_const_constructors
                    ProgressIcons(
                      total: pomodoroPerSet,
                      done: pomodoroNum - (setNum * pomodoroPerSet),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      statusDescription[pomodoroStatus]!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly, // Espaço igual entre os botões
                      children: [
                        CustomButtom(
                            onTap: _mainButtonPressed, text: mainBtnText),
                        CustomButtom(
                            onTap: _resumeButtonPressed, text: _btnTextReset),
                      ],
                    ),
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
        _pausePomodoroCountdown();
        break;
      case PomodoroStatus.pausedShortBreak:
        _startShortBreak();
        break;
      case PomodoroStatus.runningLongBreak:
        _pauseLongBreakCountdown();
        break;
      case PomodoroStatus.pausedLongBreak:
        _startLongBreak();
        break;
      case PomodoroStatus.setFinished:
        setNum++;
        _startPomodoroCountdown();
        break;
      default:
    }
  }

  _startLongBreak() {
    pomodoroStatus = PomodoroStatus.runningShortBreak;
    setState(() {
      mainBtnText = _btnTextPause;
    });
    _cancelTimer();
    _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => {
              if (remainingTime > 0)
                {
                  setState(() {
                    remainingTime--;
                  }),
                }
              else
                {
                  _playSound(),
                  remainingTime = pomodoroTotalTime,
                  _cancelTimer(),
                  pomodoroStatus = PomodoroStatus.setFinished,
                  setState(() {
                    mainBtnText = _btnTextStartNewSet;
                  })
                }
            });
  }

  _startShortBreak() {
    pomodoroStatus = PomodoroStatus.runningShortBreak;
    setState(() {
      mainBtnText = _btnTextPause;
    });
    _cancelTimer();
    _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => {
              if (remainingTime > 0)
                {
                  setState(() {
                    remainingTime--;
                  }),
                }
              else
                {
                  _playSound(),
                  remainingTime = pomodoroTotalTime,
                  _cancelTimer(),
                  pomodoroStatus = PomodoroStatus.pausedPomodoro,
                  setState(() {
                    mainBtnText = _btnTextStart;
                  })
                }
            });
  }

  _getPomodoroPercentage() {
    int totalTime = pomodoroTotalTime;
    switch (pomodoroStatus) {
      case PomodoroStatus.pausedPomodoro:
        totalTime = pomodoroTotalTime;
        break;
      case PomodoroStatus.runningPomodoro:
        totalTime = pomodoroTotalTime;
        break;
      case PomodoroStatus.pausedShortBreak:
        totalTime = shortBreakTime;
        _startShortBreak();
        break;
      case PomodoroStatus.runningLongBreak:
        totalTime = longBreakTime;
        break;
      case PomodoroStatus.pausedLongBreak:
        totalTime = longBreakTime;
        break;
      case PomodoroStatus.setFinished:
        totalTime = pomodoroTotalTime;
        break;
      default:
    }
    double percentage = (totalTime - remainingTime) / totalTime;
    return percentage;
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
                  _playSound(),
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

  _pausePomodoroCountdown() {
    pomodoroStatus = PomodoroStatus.pausedPomodoro;
    _cancelTimer();
    setState(() {
      mainBtnText = _btnTextResumePomodoro;
    });
  }

  _pauseLongBreakCountdown() {
    pomodoroStatus = PomodoroStatus.pausedLongBreak;
    _pausedBreakCountdown();
  }

  // _pauseShortBreakCountdown() {
  //   pomodoroStatus = PomodoroStatus.pausedShortBreak;
  //   _pausedBreakCountdown();
  // }

  _pausedBreakCountdown() {
    _cancelTimer();
    setState(() {
      mainBtnText = _btnTextResumeBreak;
    });
  }

  _resumeButtonPressed() {
    pomodoroNum = 0;
    setNum = 0;
    _cancelTimer();
    _stopCountdown();
  }

  _stopCountdown() {
    pomodoroStatus = PomodoroStatus.pausedPomodoro;
    setState(() {
      mainBtnText = _btnTextStart;
      remainingTime = pomodoroTotalTime;
    });
  }

  _cancelTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }
  }
}

_playSound() {
  // player.play('bell.mp3');
  // print('som');
}
