import 'package:covoiturage/ProfileInfoEdit0.dart';
import 'package:covoiturage/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String _password ;
  late String _email;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          const Text(
            "Create account",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Colors.teal,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          TextFormField(
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          TextFormField(
            validator: (input) => !input!.contains('@')
                  ? 'Please enter a valid email'
                  : null,
            onSaved: (input) => _email = input!,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Email or Phone number",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          TextFormField(
            onSaved: (input) => _password = input!,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.remove_red_eye)),
          ),
          const SizedBox(
            height: 25,
          ),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: const InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.remove_red_eye)),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient:
                    const LinearGradient(colors: [Colors.blue, Colors.green])),
            child: MaterialButton(
              onPressed: () {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: _email,
                        password: _password)
                    .then((value) {
                  print("Created New Account");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileInfoEdit02()));
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });
              },
              child: const Text(
                "Sign up",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            height: 10,
            color: Colors.black,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginUI()),
                    );
                  },
                  child: const Text("Sign in"))
            ],
          ),
        ],
      ),
    );
  }

}

void main() => runApp(SignUp());

class SignUp2 extends StatelessWidget {
  const SignUp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Covoiturage",
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Covoiturage"),
        ),
        body: SignUp(),
      ),
    );
  }
}
