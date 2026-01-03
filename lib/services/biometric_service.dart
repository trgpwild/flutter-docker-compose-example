import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class BiometricService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> checkBiometrics() async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();
      return canAuthenticate;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> authenticate() async {
    try {
      // In local_auth 2.0.0+ (used by version 3.0.0 wrapper)
      // the options are passed differently or omitted if not needed defaults are fine.
      // Basic call for local_auth 3.0.0
      return await auth.authenticate(
        localizedReason: 'Por favor, autentique-se para acessar a página',
        // In some versions, it's 'stickyAuth: true' directly, or through AuthenticationOptions
        // But the error said options/AuthenticationOptions were undefined.
        // Let's try the most basic signature first or check the available methods.
      );
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
