import 'dart:async';

class TimerService {
  Timer? _timer;
  int _secondsPassed = 0;

  int get secondsPassed => _secondsPassed;

  void startTimer(Function onTick) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _secondsPassed++;
      onTick();
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void resetTimer() {
    _secondsPassed = 0;
  }
}
