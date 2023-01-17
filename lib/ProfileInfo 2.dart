import 'package:covoiturage/ProfileInfoEdit0.dart';
import 'package:covoiturage/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ProfileInfoEdit.dart';

void main() => runApp(ProfileInfo2());

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({Key? key}) : super(key: key);

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
        body: ProfileInfo2(),
      ),
    );
  }
}

class ProfileInfo2 extends StatelessWidget {
  ProfileInfo2({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Stack(
            children: [
              Container(
                width: 200,
                height: 180,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 1))
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://media.istockphoto.com/id/1223671392/fr/vectoriel/photo-de-profil-par-d%C3%A9faut-avatar-photo-placeholder-illustration-de-vecteur.jpg?s=170667a&w=0&k=20&c=EqD6q8IUqwN_bgGec0UBhh3tk2Zuur5lezDDlQsGdPY="))),
              ),
            ],
          ),
          Text(
            "Name  ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 220,
          ),
          Container(
            height: 40,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient:
                    const LinearGradient(colors: [Colors.blue, Colors.green])),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileInfoEdit2()),
                );
              },
              child: const Text(
                "Edit Profile",
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 40,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient:
                    const LinearGradient(colors: [Colors.blue, Colors.green])),
            child: MaterialButton(
              onPressed: () {
                signUserOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                );
              },
              child: const Text(
                "log out",
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
