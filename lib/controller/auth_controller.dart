import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String> Register(String email, String password, {String? name}) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Mettre à jour le nom d'utilisateur si fourni
      if (name != null && name.isNotEmpty) {
        await userCredential.user?.updateDisplayName(name);
        await userCredential.user?.reload();
      }

      return 'SUCCES';
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        return 'MOT DE PASSE COURT';
      } else if (e.code == "email-already-in-use") {
        return 'EMAIL DEJA UTILISE';
      } else if (e.code == "invalid-email") {
        return 'EMAIL INVALIDE';
      } else if (e.code == "operation-not-allowed") {
        return 'OPERATION NON AUTORISEE';
      } else if (e.code == "network-request-failed" || 
                 e.code == "too-many-requests" ||
                 e.message?.contains("network") == true ||
                 e.message?.contains("timeout") == true ||
                 e.message?.contains("unreachable") == true) {
        return 'ERREUR RESEAU: Vérifiez votre connexion Internet';
      } else {
        return 'ERREUR: ${e.message ?? e.code}';
      }
    } catch (e) {
      String errorMessage = e.toString().toLowerCase();
      if (errorMessage.contains("network") || 
          errorMessage.contains("timeout") || 
          errorMessage.contains("unreachable") ||
          errorMessage.contains("socket") ||
          errorMessage.contains("connection")) {
        return 'ERREUR RESEAU: Vérifiez votre connexion Internet et réessayez';
      }
      return 'ERREUR: ${e.toString()}';
    }
  }

  Future<String> Login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return 'SUCCES';
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return 'UTILISATEUR NON TROUVE';
      } else if (e.code == "wrong-password") {
        return 'MOT DE PASSE INCORRECT';
      } else if (e.code == "invalid-email") {
        return 'EMAIL INVALIDE';
      } else if (e.code == "user-disabled") {
        return 'UTILISATEUR DESACTIVE';
      } else if (e.code == "too-many-requests") {
        return 'TROP DE TENTATIVES, REESSAYEZ PLUS TARD';
      } else if (e.code == "network-request-failed" || 
                 e.message?.contains("network") == true ||
                 e.message?.contains("timeout") == true ||
                 e.message?.contains("unreachable") == true) {
        return 'ERREUR RESEAU: Vérifiez votre connexion Internet';
      } else {
        return 'ERREUR: ${e.message ?? e.code}';
      }
    } catch (e) {
      String errorMessage = e.toString().toLowerCase();
      if (errorMessage.contains("network") || 
          errorMessage.contains("timeout") || 
          errorMessage.contains("unreachable") ||
          errorMessage.contains("socket") ||
          errorMessage.contains("connection")) {
        return 'ERREUR RESEAU: Vérifiez votre connexion Internet et réessayez';
      }
      return 'ERREUR: ${e.toString()}';
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return 'CONNEXION ANNULEE';
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      return 'SUCCES';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return 'Ce compte utilise déjà une autre méthode de connexion';
      } else if (e.code == 'invalid-credential') {
        return 'Identifiants Google invalides, réessayez';
      } else if (e.code == 'network-request-failed') {
        return 'ERREUR RESEAU: Vérifiez votre connexion Internet';
      } else {
        return 'ERREUR: ${e.message ?? e.code}';
      }
    } catch (e) {
      final String message = e.toString().toLowerCase();
      if (message.contains('sign_in_canceled') || message.contains('canceled')) {
        return 'CONNEXION ANNULEE';
      }
      if (message.contains('network') ||
          message.contains('timeout') ||
          message.contains('unreachable') ||
          message.contains('socket') ||
          message.contains('connection')) {
        return 'ERREUR RESEAU: Vérifiez votre connexion Internet et réessayez';
      }
      return 'ERREUR: ${e.toString()}';
    }
  }

  Future<String> signInWithFacebook() async {
    try {
      // Lancer le flux de connexion Facebook
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        // Créer le credential Firebase avec le token d'accès Facebook
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);

        // Se connecter à Firebase avec le credential
        await _auth.signInWithCredential(credential);
        return 'SUCCES';
      } else if (result.status == LoginStatus.cancelled) {
        return 'CONNEXION ANNULEE';
      } else {
        return 'ERREUR: ${result.message ?? 'Erreur de connexion Facebook'}';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return 'Ce compte utilise déjà une autre méthode de connexion';
      } else if (e.code == 'invalid-credential') {
        return 'Identifiants Facebook invalides, réessayez';
      } else if (e.code == 'network-request-failed') {
        return 'ERREUR RESEAU: Vérifiez votre connexion Internet';
      } else {
        return 'ERREUR: ${e.message ?? e.code}';
      }
    } catch (e) {
      final String message = e.toString().toLowerCase();
      if (message.contains('cancelled') || message.contains('canceled')) {
        return 'CONNEXION ANNULEE';
      }
      if (message.contains('network') ||
          message.contains('timeout') ||
          message.contains('unreachable') ||
          message.contains('socket') ||
          message.contains('connection')) {
        return 'ERREUR RESEAU: Vérifiez votre connexion Internet et réessayez';
      }
      return 'ERREUR: ${e.toString()}';
    }
  }

  Future<String> signInWithTwitter() async {
    try {
      // Twitter Auth via Firebase nécessite une implémentation web
      // Pour mobile, Twitter Auth est plus complexe et nécessite généralement
      // une configuration spécifique ou un package comme twitter_login
      
      // Message informatif pour l'utilisateur
      return 'ERREUR: Twitter authentication n\'est pas encore disponible. Veuillez utiliser Google ou Facebook.';
      
      // Note: Pour implémenter Twitter complètement, il faudrait:
      // 1. Ajouter le package twitter_login dans pubspec.yaml
      // 2. Configurer Twitter dans Firebase Console (déjà documenté)
      // 3. Implémenter le flux OAuth complet
    } catch (e) {
      return 'ERREUR: ${e.toString()}';
    }
  }
}

