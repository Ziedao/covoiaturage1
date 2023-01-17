import 'package:covoiturage/Code.dart';
import 'package:flutter/material.dart';
import 'ProfileInfoEdit.dart';
import 'Rules.dart';
import 'reset.dart';
import 'Sign_Up.dart';
import 'home.dart';
import 'ProfileInfo.dart';
import 'Code.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covoiturage/screens/signin_screen.dart';
import 'package:covoiturage/screens/signup_screen.dart';

//void main() => runApp(LoginUI());
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(LoginUI());
}

class LoginUI extends StatelessWidget {
  const LoginUI({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: AuthPage(),
    );
  }
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return home();
          }

          // user is NOT logged in
          else {
            return SignInScreen();
          }
        },
      ),
    );
  }
}
