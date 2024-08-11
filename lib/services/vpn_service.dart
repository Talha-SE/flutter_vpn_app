import 'dart:async';
import 'package:flutter/services.dart';
import '../models/server.dart';

class VpnService {
  static const MethodChannel _channel =
      MethodChannel('com.example.vpn_app/vpn');

  bool _isConnected = false;
  Server? _currentServer;

  final StreamController<Server?> _serverController =
      StreamController<Server?>.broadcast();
  final StreamController<bool> _connectionStatusController =
      StreamController<bool>.broadcast();
  final StreamController<int> _connectionDurationController =
      StreamController<int>.broadcast();
  final StreamController<double> _uploadSpeedController =
      StreamController<double>.broadcast();
  final StreamController<double> _downloadSpeedController =
      StreamController<double>.broadcast();

  Timer? _durationTimer;
  int _connectionDuration = 0;

  bool get isConnected => _isConnected;
  Server? get currentServer => _currentServer;

  Stream<Server?> get serverStream => _serverController.stream;
  Stream<bool> get connectionStatusStream => _connectionStatusController.stream;
  Stream<int> get connectionDurationStream =>
      _connectionDurationController.stream;
  Stream<double> get uploadSpeedStream => _uploadSpeedController.stream;
  Stream<double> get downloadSpeedStream => _downloadSpeedController.stream;

  Future<void> connect(Server? server) async {
    if (server == null) {
      throw Exception('No server selected');
    }

    try {
      await _channel.invokeMethod('startVpn');
      _isConnected = true;
      _currentServer = server;
      _serverController.add(server);
      _connectionStatusController.add(true);

      _startConnectionTimer();
      _startSpeedMeasurement();
    } catch (e) {
      _isConnected = false;
      _currentServer = null;
      _connectionStatusController.add(false);
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<void> disconnect() async {
    try {
      await _channel.invokeMethod('stopVpn');
      _isConnected = false;
      _currentServer = null;
      _serverController.add(null);
      _connectionStatusController.add(false);

      _stopConnectionTimer();
      _stopSpeedMeasurement();
    } catch (e) {
      throw Exception('Failed to disconnect: $e');
    }
  }

  void _startConnectionTimer() {
    _connectionDuration = 0;
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _connectionDuration++;
      _connectionDurationController.add(_connectionDuration);
    });
  }

  void _stopConnectionTimer() {
    _durationTimer?.cancel();
    _connectionDuration = 0;
    _connectionDurationController.add(_connectionDuration);
  }

  void _startSpeedMeasurement() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isConnected) {
        timer.cancel();
        return;
      }
      _uploadSpeedController.add(_generateRandomSpeed());
      _downloadSpeedController.add(_generateRandomSpeed());
    });
  }

  void _stopSpeedMeasurement() {
    _uploadSpeedController.add(0);
    _downloadSpeedController.add(0);
  }

  double _generateRandomSpeed() {
    return (DateTime.now().millisecondsSinceEpoch % 100).toDouble();
  }

  void dispose() {
    _serverController.close();
    _connectionStatusController.close();
    _connectionDurationController.close();
    _uploadSpeedController.close();
    _downloadSpeedController.close();
    _durationTimer?.cancel();
  }
}
