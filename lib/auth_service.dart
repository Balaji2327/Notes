import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  /// Sign in using Google and FirebaseAuth. Returns UserCredential on success,
  /// or null if the user cancelled the sign-in flow.
  static Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    // Try silent sign-in first to avoid account picker when possible
    GoogleSignInAccount? googleUser = await googleSignIn.signInSilently();
    if (googleUser == null) {
      googleUser = await googleSignIn.signIn();
    }
    if (googleUser == null) return null; // user cancelled

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCred = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    // Persist a simple logged-in flag and email
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);
    await prefs.setString('user_email', userCred.user?.email ?? '');

    return userCred;
  }

  /// Sign in using GitHub via Firebase OAuthProvider.
  /// Requires GitHub provider to be configured in Firebase Console (client id/secret).
  static Future<UserCredential?> signInWithGitHub() async {
    final provider = OAuthProvider('github.com');
    provider.addScope('read:user');

    final userCred = await FirebaseAuth.instance.signInWithProvider(provider);

    // Persist a simple logged-in flag and email
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);
    await prefs.setString('user_email', userCred.user?.email ?? '');

    return userCred;
  }

  /// Link GitHub provider to the currently signed-in user.
  /// This opens the OAuth flow and attaches the GitHub credential to the existing account.
  static Future<UserCredential?> linkGitHubToCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('No signed-in user to link with.');

    final provider = OAuthProvider('github.com');
    provider.addScope('read:user');

    final result = await user.linkWithProvider(provider);

    // Persist a simple logged-in flag and email
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);
    await prefs.setString('user_email', result.user?.email ?? '');

    return result;
  }

  /// Sign out from Firebase and Google and clear persisted flags.
  static Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
    } catch (_) {}
    await FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_logged_in');
    await prefs.remove('user_email');
  }
}
