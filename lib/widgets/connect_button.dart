import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../services/vpn_service.dart';
import '../models/server.dart';

class ConnectButton extends StatefulWidget {
  final VpnService vpnService;
  final Server? selectedServer;

  const ConnectButton({
    Key? key,
    required this.vpnService,
    this.selectedServer,
  }) : super(key: key);

  @override
  _ConnectButtonState createState() => _ConnectButtonState();
}

class _ConnectButtonState extends State<ConnectButton>
    with SingleTickerProviderStateMixin {
  late StreamSubscription<bool> _connectionStatusSubscription;
  late AnimationController _animationController;
  bool _isConnecting = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500), // Smoother rotation
      vsync: this,
    )..repeat(); // Continuously rotate

    _connectionStatusSubscription =
        widget.vpnService.connectionStatusStream.listen((status) {
      setState(() {
        _isConnecting = false;
        if (status) {
          _animationController.forward(); // Start rotation when connected
        } else {
          _animationController.reverse(); // Stop rotation when disconnected
        }
      });
    });
  }

  Future<void> _connectToSelectedServer() async {
    if (widget.selectedServer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No server selected')),
      );
      return;
    }

    setState(() {
      _isConnecting = true;
    });

    try {
      await widget.vpnService.connect(widget.selectedServer);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Connected to ${widget.selectedServer!.countryLong}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to connect: $e')),
      );
    }
  }

  @override
  void dispose() {
    _connectionStatusSubscription.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.vpnService.isConnected) {
          widget.vpnService.disconnect();
        } else if (!_isConnecting) {
          _connectToSelectedServer();
        }
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animationController.value * 2 * 3.14, // Full rotation
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: widget.vpnService.isConnected
                      ? [Colors.green, Colors.lightGreen]
                      : [Colors.red, Colors.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.vpnService.isConnected
                        ? Colors.green.withOpacity(0.5)
                        : Colors.red.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 4), // Slight shadow offset
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Ionicons.power,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
