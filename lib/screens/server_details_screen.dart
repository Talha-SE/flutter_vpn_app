import 'package:flutter/material.dart';
import '../models/server.dart';

class ServerDetailsScreen extends StatelessWidget {
  const ServerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Server server = ModalRoute.of(context)!.settings.arguments as Server;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Server Details'),
        backgroundColor: Colors.blueGrey[900],
        elevation: 0, // Flat app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildFlagCard(server),
            const SizedBox(
                height: 16.0), // Space between the flag card and the details
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blueGrey[800]!,
                    Colors.blueGrey[900]!,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(context, 'Hostname', server.hostname),
                  _buildDetailRow(context, 'IP Address', server.ip),
                  _buildDetailRow(context, 'Score', server.score.toString()),
                  _buildDetailRow(context, 'Ping', '${server.ping} ms'),
                  _buildDetailRow(context, 'Speed', '${server.speed} Mbps'),
                  _buildDetailRow(context, 'Active Sessions',
                      server.numVpnSessions.toString()),
                  _buildDetailRow(
                      context, 'Uptime', '${server.uptime} seconds'),
                  _buildDetailRow(
                      context, 'Total Users', server.totalUsers.toString()),
                  _buildDetailRow(
                      context, 'Total Traffic', server.totalTraffic),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlagCard(Server server) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 5,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/flags/${server.countryShort.toLowerCase()}.png', // Update with the path to your flag images
              fit: BoxFit.cover,
              height: 200, // Adjust height as needed
              width: double.infinity,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${server.countryLong} (${server.countryShort})',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
