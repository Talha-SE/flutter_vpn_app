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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black87, Colors.black54],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Main content
          Center(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                    maxWidth: 600), // Max width for larger screens
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo
                    SizedBox(
                      height: 120,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Title
                    Text(
                      'Welcome Back',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Please login to continue',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                    const SizedBox(height: 40),
                    // Text Fields
                    _buildTextField(
                      context,
                      label: 'Username',
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      context,
                      label: 'Password',
                      icon: Icons.lock,
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    // Login Button
                    _buildButton(
                      context,
                      label: 'Login',
                      onPressed: () {
                        // Handle login action
                      },
                    ),
                    const SizedBox(height: 16),
                    // Continue as Guest Button
                    _buildButton(
                      context,
                      label: 'Continue as Guest',
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/');
                      },
                    ),
                    const SizedBox(height: 24),
                    // Forgot Password
                    TextButton(
                      onPressed: () {
                        // Handle forgot password action
                      },
                      child: Text(
                        'Forgot Password?',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white70,
                                  decoration: TextDecoration.underline,
                                ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Sign Up Option
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
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
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
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
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
          ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white70,
            ),
        prefixIcon: Icon(
          icon,
          color: Colors.white70,
        ),
        filled: true,
        fillColor: Colors.blueGrey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey[900],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadowColor: Colors.black45,
          elevation: 5,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
