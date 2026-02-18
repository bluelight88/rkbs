import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialAuthResult {
  final String provider;
  final String idToken;
  final String? email;

  SocialAuthResult({
    required this.provider,
    required this.idToken,
    this.email,
  });
}

class SocialAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    // MUST be the "Web Client ID" from Google Cloud Console to get idToken
    serverClientId: '482265189932-gn52k6iou7efbre53o5n7d3vk5qfgt25.apps.googleusercontent.com',
    scopes: ['email', 'openid'],
  );

  static Future<SocialAuthResult?> signInWithGoogle() async {
    try {
      // Clear previous session to ensure account picker appears
      await _googleSignIn.signOut();
      
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final GoogleSignInAuthentication auth = await account.authentication;
        
        // Use idToken for backend verification
        final String token = auth.idToken ?? auth.accessToken ?? "";
        
        debugPrint('Google Login Success: ${account.email}');
        debugPrint('Token: $token');

        return SocialAuthResult(
          provider: 'google',
          idToken: token,
          email: account.email,
        );
      }
    } on PlatformException catch (e) {
      // Code 10: Developer Error (usually SHA-1 mismatch or wrong Client ID type)
      debugPrint('Google Sign-In PlatformException: code: ${e.code}, message: ${e.message}');
    } catch (error) {
      debugPrint('Unexpected sign-in error: $error');
    }
    return null;
  }

  static Future<SocialAuthResult?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );
      if (result.status == LoginStatus.success) {
        final AccessToken? accessToken = result.accessToken;
        final userData = await FacebookAuth.instance.getUserData();
        return SocialAuthResult(
          provider: 'facebook',
          idToken: accessToken?.tokenString ?? "",
          email: userData['email'],
        );
      }
    } catch (e) {
      debugPrint("Facebook sign-in error: $e");
    }
    return null;
  }

  static Future<SocialAuthResult?> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      return SocialAuthResult(
        provider: 'apple',
        idToken: credential.identityToken ?? "",
        email: credential.email,
      );
    } catch (e) {
      debugPrint("Apple sign-in error: $e");
    }
    return null;
  }
}
