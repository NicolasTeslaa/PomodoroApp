import 'package:pomodoro/models/pomodoro_status.dart';
import 'package:flutter/material.dart';

const pomodoroTotalTime = 22 * 60;
const shortBreakTime = 5 * 60;
const longBreakTime = 15 * 60;
const pomodoroPerSet = 4;

Map<PomodoroStatus, String> statusDescription = {
  PomodoroStatus.runningPomodoro:
      'O Pomodoro está em andamento, é hora de se concentrar',
  PomodoroStatus.pausedPomodoro: 'Pronto para se concentrar?',
  PomodoroStatus.runningShortBreak:
      'Intervalo curto em andamento, é hora de relaxar',
  PomodoroStatus.pausedShortBreak: 'Vamos fazer um intervalo curto?',
  PomodoroStatus.runningLongBreak:
      'Intervalo longo em andamento, é hora de relaxar',
  PomodoroStatus.pausedLongBreak: 'Vamos fazer um intervalo longo?',
  PomodoroStatus.setFinished:
      'Parabéns, você merece um intervalo longo. Está pronto para começar?',
};

const Map<PomodoroStatus, MaterialColor> statusColor = {
  PomodoroStatus.runningPomodoro: Colors.green,
  PomodoroStatus.pausedPomodoro: Colors.orange,
  PomodoroStatus.runningShortBreak: Colors.red,
  PomodoroStatus.pausedShortBreak: Colors.orange,
  PomodoroStatus.runningLongBreak: Colors.red,
  PomodoroStatus.pausedLongBreak: Colors.orange,
  PomodoroStatus.setFinished: Colors.orange,
};
