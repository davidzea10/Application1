import '../controller/auth_controller.dart';

class LoginController {
  final AuthController _auth = AuthController();

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email obligatoire';
    }
    final emailRegex = RegExp(r'^[\w\.\-]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Format email invalide';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Mot de passe requis';
    }
    if (value.trim().length < 6) {
      return 'Minimum 6 caractères';
    }
    return null;
  }

  Future<String> submitLogin(String email, String password) {
    return _auth.Login(email.trim(), password.trim());
  }

  Future<String> signInWithGoogle() {
    return _auth.signInWithGoogle();
  }

  Future<String> signInWithFacebook() {
    return _auth.signInWithFacebook();
  }

  Future<String> signInWithTwitter() {
    return _auth.signInWithTwitter();
  }
}

