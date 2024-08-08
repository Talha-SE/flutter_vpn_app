// ignore_for_file: prefer_const_constructors

import 'dart:async';

class SpeedMeasurement {
  Timer? _speedTimer;
  double _uploadSpeed = 0.0;
  double _downloadSpeed = 0.0;
  final StreamController<double> _uploadSpeedController =
      StreamController<double>.broadcast();
  final StreamController<double> _downloadSpeedController =
      StreamController<double>.broadcast();

  Stream<double> get uploadSpeedStream => _uploadSpeedController.stream;
  Stream<double> get downloadSpeedStream => _downloadSpeedController.stream;

  void startMonitoring() {
    _speedTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _uploadSpeed = _simulateUploadSpeed();
      _downloadSpeed = _simulateDownloadSpeed();
      _uploadSpeedController.add(_uploadSpeed);
      _downloadSpeedController.add(_downloadSpeed);
    });
  }

  void stopMonitoring() {
    _speedTimer?.cancel();
    _uploadSpeed = 0.0;
    _downloadSpeed = 0.0;
    _uploadSpeedController.add(_uploadSpeed);
    _downloadSpeedController.add(_downloadSpeed);
  }

  double _simulateUploadSpeed() {
    // Simulate the real upload speed measurement
    return 5.0; // Example value in Mbps
  }

  double _simulateDownloadSpeed() {
    // Simulate the real download speed measurement
    return 50.0; // Example value in Mbps
  }

  void dispose() {
    _speedTimer?.cancel();
    _uploadSpeedController.close();
    _downloadSpeedController.close();
  }
}
