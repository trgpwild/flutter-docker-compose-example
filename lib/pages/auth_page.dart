import 'package:flutter/material.dart';
import '../services/biometric_service.dart';
import 'home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final BiometricService _biometricService = BiometricService();
  bool _isAuthenticating = false;

  Future<void> _authenticate() async {
    setState(() {
      _isAuthenticating = true;
    });

    final bool isAuthenticated = await _biometricService.authenticate();

    setState(() {
      _isAuthenticating = false;
    });

    if (isAuthenticated) {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Falha na autenticação')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acesso Biométrico')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.fingerprint, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Toque no botão para entrar',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _isAuthenticating ? null : _authenticate,
              child: _isAuthenticating
                  ? const CircularProgressIndicator()
                  : const Text('Autenticar'),
            ),
          ],
        ),
      ),
    );
  }
}
