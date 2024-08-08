import 'dart:async';
import '../models/server.dart';
import '../widgets/connection_timer.dart'; // Import your ConnectionTimer class
import '../utils/speed_measurement.dart'; // Import your SpeedMeasurement class

class VpnService {
  bool _isConnected = false;
  Server? _currentServer;
  final ConnectionTimer _connectionTimerService = ConnectionTimer();
  final SpeedMeasurement _speedMeasurementService = SpeedMeasurement();

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
      // Simulate a connection attempt
      bool connectionSuccessful = await _simulateConnection(server);
      if (connectionSuccessful) {
        _isConnected = true;
        _currentServer = server;
        _serverController.add(server); // Notify server change
        _connectionStatusController.add(true); // Notify connection status

        // Start services for connection timer and speed measurement
        _connectionTimerService.start();
        _speedMeasurementService.startMonitoring();

        // Update streams for duration and speeds
        _connectionTimerService.durationStream.listen((duration) {
          _connectionDurationController.add(duration);
        });

        _speedMeasurementService.uploadSpeedStream.listen((speed) {
          _uploadSpeedController.add(speed);
        });

        _speedMeasurementService.downloadSpeedStream.listen((speed) {
          _downloadSpeedController.add(speed);
        });
      } else {
        throw Exception('Failed to connect to server');
      }
    } catch (e) {
      _connectionStatusController.add(false); // Notify connection failure
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<void> disconnect() async {
    // Simulate disconnection logic
    _isConnected = false;
    _currentServer = null;
    _serverController.add(null); // Notify server change
    _connectionStatusController.add(false); // Notify disconnection status

    // Stop services for connection timer and speed measurement
    _connectionTimerService.stop();
    _speedMeasurementService.stopMonitoring();
  }

  Future<bool> _simulateConnection(Server server) async {
    // Simulate a delay for connection establishment
    await Future.delayed(const Duration(seconds: 2));
    return true; // Simulate a successful connection
  }

  void dispose() {
    _serverController.close();
    _connectionStatusController.close();
    _connectionDurationController.close();
    _uploadSpeedController.close();
    _downloadSpeedController.close();
    _connectionTimerService.dispose();
    _speedMeasurementService.dispose();
  }
}
