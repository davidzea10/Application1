import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'view/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print('✅ Firebase initialisé avec succès');
  } catch (e) {
    print('❌ Erreur d\'initialisation Firebase: $e');
    print('Assurez-vous d\'avoir ajouté les fichiers de configuration Firebase');
    print('Vérifiez que google-services.json est dans android/app/');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application Mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
