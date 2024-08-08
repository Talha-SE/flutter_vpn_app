import 'dart:async';

class ConnectionTimer {
  Timer? _timer;
  int _seconds = 0;
  final StreamController<int> _durationController =
      StreamController<int>.broadcast();

  Stream<int> get durationStream => _durationController.stream;

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds++;
      _durationController.add(_seconds);
    });
  }

  void stop() {
    _timer?.cancel();
    _seconds = 0;
    _durationController.add(_seconds);
  }

  void dispose() {
    _timer?.cancel();
    _durationController.close();
  }
}
