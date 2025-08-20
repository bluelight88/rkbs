import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialAuthService {
  static Future<void> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn.instance;
    try {
      await googleSignIn.initialize();
      final account = await googleSignIn.authenticate(scopeHint: ['email']);
      final auth = account.authentication;
      final idToken = auth.idToken;
      final accessToken = auth.toString();
      debugPrint('Google signed in: ${account.email}');
      debugPrint('ID Token: $idToken');
      debugPrint('Access Token: $accessToken');
    } on GoogleSignInException catch (e) {
      debugPrint(
        'Google Sign-In error: code: ${e.code.name}, description: ${e.description}',
      );
    } catch (error) {
      debugPrint('Unexpected sign-in error: $error');
    }
  }

  static Future<void> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        debugPrint("Facebook signed in: ${userData['email']}");
      }
    } catch (e) {
      debugPrint("Facebook sign-in error: $e");
    }
  }

  static Future<void> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      debugPrint("Apple signed in: ${credential.email}");
    } catch (e) {
      debugPrint("Apple sign-in error: $e");
    }
  }
}
