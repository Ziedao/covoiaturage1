import 'package:covoiturage/ProfileInfoEdit0.dart';
import 'package:covoiturage/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ProfileInfoEdit.dart';
import 'home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(profileInfo());

class profileInfo extends StatelessWidget {
  const profileInfo({Key? key}) : super(key: key);

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
          title: Text("Profile"),
        ),
        body: UserInfoScreen(),
      ),
    );
  }
}

class UserInfoScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.teal ,
          centerTitle: true,
          title: Text("Profile"),
        ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Name: ${docs[index]['name']}",
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Birthday: ${docs[index]['birthday']}",
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Gender: ${docs[index]['gender']}",
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Profession: ${docs[index]['profession']}",
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Phone Number: ${docs[index]['phone']}",
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 10),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.green])),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileInfoEdit2()),
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
                          gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.green])),
                      child: MaterialButton(
                        onPressed: () {
                          signUserOut();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()),
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
                      height: 50,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
