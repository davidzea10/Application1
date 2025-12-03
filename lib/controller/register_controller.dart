import '../controller/auth_controller.dart';
import 'login_controller.dart';

class RegisterController extends LoginController {
  final AuthController _auth = AuthController();

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nom obligatoire';
    }
    if (value.trim().length < 3) {
      return 'Nom trop court';
    }
    return null;
  }

  Future<String> submitRegister(String name, String email, String password) {
    return _auth.Register(email.trim(), password.trim(), name: name.trim());
  }
}

