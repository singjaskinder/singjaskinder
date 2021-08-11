import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _localAuth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e.message);
      return false;
    }
  }

  static Future<bool> authenticate() async {
    return await _localAuth.authenticate(
      localizedReason: ' ',
      useErrorDialogs: true,
      stickyAuth: true,
      androidAuthStrings: AndroidAuthMessages(
        signInTitle: 'Unlock Dlivr Driver',
        biometricHint:
            'Unlock your screen with PIN, pattern, password, face, or fingerprint',
      ),
    );
  }

  static Future<bool> cancelAuthentication() async {
    return await _localAuth.stopAuthentication();
  }
}
