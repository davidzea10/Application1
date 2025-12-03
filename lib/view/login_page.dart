import 'package:flutter/material.dart';
import '../controller/login_controller.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _controller = LoginController();

  bool _isLoading = false;
  String? _activeAuthAction;
  bool _hidePassword = true;

  @override
  void dispose() {
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
            'Connexion',
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
                        child: _isLoading && _activeAuthAction == 'email'
                            ? SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Text('SE CONNECTER'))),
                SizedBox(height: 15),
                
                // Séparateur "OU"
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OU',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 15),
                
                // Bouton Google
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _onGoogleSignIn,
                    icon: Icon(Icons.account_circle, color: Colors.blue.shade600),
                    label: _isLoading && _activeAuthAction == 'google'
                        ? SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text('Continuer avec Google'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      elevation: 1,
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                
                // Bouton Facebook
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _onFacebookSignIn,
                    icon: Icon(Icons.facebook, color: Colors.blue.shade700),
                    label: _isLoading && _activeAuthAction == 'facebook'
                        ? SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text('Continuer avec Facebook'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.blue.shade50,
                      foregroundColor: Colors.blue.shade900,
                      elevation: 1,
                      side: BorderSide(color: Colors.blue.shade200),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                
                // Bouton Twitter
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _onTwitterSignIn,
                    icon: Icon(Icons.alternate_email, color: Colors.lightBlue.shade600),
                    label: _isLoading && _activeAuthAction == 'twitter'
                        ? SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text('Continuer avec Twitter'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.lightBlue.shade50,
                      foregroundColor: Colors.lightBlue.shade900,
                      elevation: 1,
                      side: BorderSide(color: Colors.lightBlue.shade200),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                    child: Text('Pas encore de compte ? S\'inscrire'),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    String email = _emailController.text;
    String password = _passwordController.text;

    await _performAuthAction(
        actionId: 'email',
        authCall: () => _controller.submitLogin(email, password));
  }

  Future<void> _onGoogleSignIn() async {
    await _performAuthAction(
      actionId: 'google',
      authCall: _controller.signInWithGoogle,
    );
  }

  Future<void> _onFacebookSignIn() async {
    await _performAuthAction(
      actionId: 'facebook',
      authCall: _controller.signInWithFacebook,
    );
  }

  Future<void> _onTwitterSignIn() async {
    await _performAuthAction(
      actionId: 'twitter',
      authCall: _controller.signInWithTwitter,
    );
  }

  Future<void> _performAuthAction({
    required String actionId,
    required Future<String> Function() authCall,
  }) async {
    setState(() {
      _isLoading = true;
      _activeAuthAction = actionId;
    });

    final result = await authCall();

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _activeAuthAction = null;
    });

    if (result == 'SUCCES') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result),
      ));
    }
  }
}

