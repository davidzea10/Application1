import 'package:flutter/material.dart';
import '../controller/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _controller = RegisterController();

  bool _isLoading = false;
  bool _hidePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back_ios_sharp),
          backgroundColor: Color.fromRGBO(38, 195, 24, 1),
          title: Text(
            'Inscription',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NOM',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.person),
                      labelText: 'label nom',
                      hintText: 'Jean Dupont',
                      border: OutlineInputBorder()),
                  validator: _controller.validateName,
                ),
                SizedBox(height: 30),
                Text(
                  'EMAIL',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.email),
                      labelText: 'label email',
                      hintText: 'joseph@gmail.com',
                      border: OutlineInputBorder()),
                  validator: _controller.validateEmail,
                ),
                SizedBox(height: 30),
                Text('PASSWORD',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _hidePassword,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                          icon: Icon(_hidePassword
                              ? Icons.remove_red_eye
                              : Icons.visibility_off)),
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder()),
                  validator: _controller.validatePassword,
                ),
                SizedBox(height: 30),
                Center(
                    child: ElevatedButton(
                        onPressed: _isLoading ? null : _onSubmit,
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : Text('S\'INSCRIRE'))),
                SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            Navigator.pop(context);
                          },
                    child: Text('Déjà un compte ? Se connecter'),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    setState(() {
      _isLoading = true;
    });
    final result = await _controller.submitRegister(name, email, password);
    setState(() {
      _isLoading = false;
    });
    if (!mounted) return;

    if (result == 'SUCCES') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Inscription réussie, connectez-vous maintenant'),
      ));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result),
      ));
    }
  }
}

