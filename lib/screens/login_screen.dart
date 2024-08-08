import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueGrey[900]!, Colors.blueGrey[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Main content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  SizedBox(
                    height: 150,
                    child: Image.asset(
                        'assets/images/logo.png'), // Replace with your logo path
                  ),
                  const SizedBox(height: 40),
                  // Title
                  Text(
                    'Welcome Back',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Please login to continue',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                  const SizedBox(height: 30),
                  // Text Fields
                  _buildTextField(
                    context,
                    label: 'Username',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    context,
                    label: 'Password',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      // Handle login action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[800],
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Continue as Guest Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[800],
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Continue as Guest',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Forgot Password
                  TextButton(
                    onPressed: () {
                      // Handle forgot password action
                    },
                    child: Text(
                      'Forgot Password?',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Sign Up Option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white70,
                            ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          // Handle sign up action
                        },
                        child: Text(
                          'Sign Up',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      obscureText: obscureText,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.white,
          ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white70,
            ),
        prefixIcon: Icon(
          icon,
          color: Colors.white70,
        ),
        filled: true,
        fillColor: Colors.blueGrey[700],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
