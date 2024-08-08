// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../services/vpn_service.dart';

class ConnectionStats extends StatefulWidget {
  final VpnService vpnService;

  const ConnectionStats({Key? key, required this.vpnService}) : super(key: key);

  @override
  _ConnectionStatsState createState() => _ConnectionStatsState();
}

class _ConnectionStatsState extends State<ConnectionStats> {
  @override
  void initState() {
    super.initState();
    // Add listeners to streams to update the UI
    widget.vpnService.connectionDurationStream.listen((duration) {
      if (mounted) {
        setState(() {});
      }
    });

    widget.vpnService.uploadSpeedStream.listen((speed) {
      if (mounted) {
        setState(() {});
      }
    });

    widget.vpnService.downloadSpeedStream.listen((speed) {
      if (mounted) {
        setState(() {});
      }
    });

    widget.vpnService.serverStream.listen((server) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: widget.vpnService.connectionDurationStream,
      builder: (context, durationSnapshot) {
        return StreamBuilder<double>(
          stream: widget.vpnService.uploadSpeedStream,
          builder: (context, uploadSpeedSnapshot) {
            return StreamBuilder<double>(
              stream: widget.vpnService.downloadSpeedStream,
              builder: (context, downloadSpeedSnapshot) {
                return Column(
                  children: [
                    Text(
                      'Connection Duration: ${durationSnapshot.data ?? 0} seconds',
                    ),
                    Text(
                      'Upload Speed: ${uploadSpeedSnapshot.data?.toStringAsFixed(2) ?? 0.0} Mbps',
                    ),
                    Text(
                      'Download Speed: ${downloadSpeedSnapshot.data?.toStringAsFixed(2) ?? 0.0} Mbps',
                    ),
                    if (widget.vpnService.currentServer != null) ...[
                      Text(
                          'Server: ${widget.vpnService.currentServer!.countryLong}'),
                      Text('IP: ${widget.vpnService.currentServer!.ip}'),
                      Text('Ping: ${widget.vpnService.currentServer!.ping} ms'),
                    ],
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
