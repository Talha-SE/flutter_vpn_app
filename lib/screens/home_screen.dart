import 'package:flutter/material.dart';
import '../services/vpn_service.dart';
import '../widgets/connect_button.dart';
import '../widgets/connection_stats.dart';
import '../models/server.dart';
import 'server_list_screen.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final VpnService _vpnService = VpnService();
  Server? _selectedServer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _vpnService.serverStream.listen((server) {
      setState(() {
        if (server != _selectedServer) {
          _selectedServer = server;
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final server = ModalRoute.of(context)!.settings.arguments as Server?;
    if (server != null) {
      setState(() {
        _selectedServer = server;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Turbo Stream'),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.info_circle),
            onPressed: () {
              // Navigate to information screen
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeContent(),
          const ServerListScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_list),
            label: 'Servers',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueGrey.shade900,
            Colors.black,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 60,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Server:',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  _selectedServer?.countryLong ?? 'None',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  'IP: ${_selectedServer?.ip ?? 'None'}',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.grey[400]),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            top: 60,
            right: 20,
            child: ConnectButton(
              vpnService: _vpnService,
              selectedServer: _selectedServer,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              margin: EdgeInsets.zero,
              height: 400.0, // Adjust height for visual balance
              width: double.infinity,
              decoration: BoxDecoration(
                image: _selectedServer != null
                    ? DecorationImage(
                        image: AssetImage(
                            'assets/flags/${_selectedServer!.countryShort.toLowerCase()}.png'), // Flag image
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.6),
                            BlendMode
                                .darken), // Darken the image for gradient effect
                      )
                    : DecorationImage(
                        image: const AssetImage(
                            'assets/flags/planet-earth-flag.png'), // Default image
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4),
                            BlendMode
                                .darken), // Darken the image for gradient effect
                      ),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(35.0)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StreamBuilder<Server?>(
                    stream: _vpnService.serverStream,
                    builder: (context, snapshot) {
                      return ConnectionStats(vpnService: _vpnService);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _vpnService.dispose();
    super.dispose();
  }
}
