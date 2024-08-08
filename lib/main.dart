import 'package:flutter/material.dart';
import 'utils/theme.dart';
import 'screens/home_screen.dart';
import 'screens/server_list_screen.dart';
import 'screens/server_details_screen.dart';
import 'screens/login_screen.dart'; // Import the LoginScreen

void main() {
  runApp(const VpnApp());
}

class VpnApp extends StatelessWidget {
  const VpnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VPN App',
      theme: darkTheme, // Use the darkTheme defined in theme.dart
      initialRoute: '/login', // Set LoginScreen as the initial route
      routes: {
        '/login': (context) => const LoginScreen(), // Route for login screen
        '/': (context) => const HomeScreen(),
        '/servers': (context) => const ServerListScreen(),
        '/server_details': (context) => const ServerDetailsScreen(),
      },
    );
  }
}
