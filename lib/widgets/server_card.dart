import 'package:flutter/material.dart';
import '../models/server.dart';

class ServerCard extends StatelessWidget {
  final Server server;
  final void Function(Server) onSelect;

  const ServerCard({
    super.key,
    required this.server,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[800],
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          server.countryLong,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Transform.translate(
              offset: const Offset(0, 6), // Move icon and text 4 pixels down
              child: _buildIconText(
                Icons.speed,
                Colors.green, // Ping icon color
                '${server.ping} ms',
              ),
            ),
            Transform.translate(
              offset: const Offset(0, 6), // Move icon and text 4 pixels down
              child: _buildIconText(
                Icons.group,
                Colors.orange, // Load icon color
                '${server.numVpnSessions}',
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.info,
            color: Color.fromARGB(255, 226, 192, 3),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/server_details', arguments: server);
          },
        ),
        onTap: () {
          onSelect(server); // Trigger server selection
        },
      ),
    );
  }

  Widget _buildIconText(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        const SizedBox(width: 6.0),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
