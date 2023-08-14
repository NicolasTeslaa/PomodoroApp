import 'package:pomodoro/models/pomodoro_status.dart';
import 'package:flutter/material.dart';

const pomodoroTotalTime = 5;
const shortBreakTime = 3;
const longBreakTime = 6;
const pomodoroPerSet = 4;

Map<PomodoroStatus, String> statusDescription = {
  PomodoroStatus.runningPomodoro: 'Se concentre guerreiro ',
  PomodoroStatus.pausedPomodoro: 'Pronto para ir a batalha ??',
  PomodoroStatus.runningShortBreak:
      'Hora das distrações e prazeres momentâneos',
  PomodoroStatus.pausedShortBreak: 'Vamos fazer um intervalo curto?',
  PomodoroStatus.runningLongBreak:
      'Intervalo longo em andamento, é hora de relaxar',
  PomodoroStatus.pausedLongBreak: 'Agora descanse para a próxima luta',
  PomodoroStatus.setFinished: 'Você venceu suas distrações, agora continue ...',
};

const Map<PomodoroStatus, MaterialColor> statusColor = {
  PomodoroStatus.runningPomodoro: Colors.deepPurple,
  PomodoroStatus.pausedPomodoro: Colors.orange,
  PomodoroStatus.runningShortBreak: Colors.grey,
  PomodoroStatus.pausedShortBreak: Colors.orange,
  PomodoroStatus.runningLongBreak: Colors.orange,
  PomodoroStatus.pausedLongBreak: Colors.orange,
  PomodoroStatus.setFinished: Colors.orange,
};
