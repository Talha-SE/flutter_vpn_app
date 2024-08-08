// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/server.dart';
import '../widgets/server_card.dart';
import '../services/vpn_service.dart'; // Import your VpnService

class ServerListScreen extends StatefulWidget {
  const ServerListScreen({super.key});

  @override
  _ServerListScreenState createState() => _ServerListScreenState();
}

class _ServerListScreenState extends State<ServerListScreen> {
  final ApiService _apiService = ApiService();
  final VpnService _vpnService = VpnService();
  late Future<List<Server>> _serversFuture;

  @override
  void initState() {
    super.initState();
    _serversFuture = _apiService.fetchServers(); // Fetch the list of servers
  }

  void _selectServer(Server server) async {
    try {
      await _vpnService.disconnect(); // Disconnect from any previous server

      // Navigate back to the HomeScreen and pass the selected server
      Navigator.popUntil(context, ModalRoute.withName('/'));
      Navigator.pushReplacementNamed(
        context,
        '/',
        arguments: server,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to select server: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Server List'),
        backgroundColor: Colors.black87,
        elevation: 4,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [Colors.black54, Colors.black87],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Server>>(
        future: _serversFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 157, 234, 236),
                strokeWidth: 4.0,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 40, color: Colors.red),
                    const SizedBox(height: 10),
                    Text('Error: ${snapshot.error}',
                        style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.info,
                        size: 40, color: Color.fromARGB(255, 235, 11, 11)),
                    SizedBox(height: 10),
                    Text('No servers available',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            );
          } else {
            // Sort the servers alphabetically by name
            List<Server> sortedServers = snapshot.data!;
            sortedServers
                .sort((a, b) => a.countryLong.compareTo(b.countryLong));

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              itemCount: sortedServers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ServerCard(
                    server: sortedServers[index],
                    onSelect: _selectServer, // Handle server selection
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
