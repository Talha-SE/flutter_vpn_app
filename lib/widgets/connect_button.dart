import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../services/vpn_service.dart';
import '../models/server.dart';

class ConnectButton extends StatefulWidget {
  final VpnService vpnService;
  final Server? selectedServer;

  const ConnectButton({
    super.key,
    required this.vpnService,
    this.selectedServer,
  });

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
      duration: const Duration(
          milliseconds: 2000), // Adjust duration for slower rotation
      vsync: this,
    )..repeat(); // Continuously rotate

    _connectionStatusSubscription =
        widget.vpnService.connectionStatusStream.listen((status) {
      setState(() {
        _isConnecting = false;
      });
      if (status) {
        _animationController.forward(); // Start rotation when connected
      } else {
        _animationController.reverse(); // Stop rotation when disconnected
      }
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
        setState(() {});
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animationController.value *
                2 *
                3.14, // Use the animation value for rotation
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.vpnService.isConnected
                    ? const Color.fromARGB(255, 255, 255, 255)
                    : const Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: widget.vpnService.isConnected
                        ? const Color.fromARGB(255, 56, 255, 49)
                            .withOpacity(0.6)
                        : const Color.fromARGB(255, 255, 99, 99)
                            .withOpacity(0.6),
                    spreadRadius: 7,
                    blurRadius: 10,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: const Icon(
                Ionicons.power,
                color: Color.fromARGB(255, 0, 0, 0),
                size: 50,
              ),
            ),
          );
        },
      ),
    );
  }
}
