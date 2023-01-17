import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covoiturage/ProfileInfoEdit.dart';
import 'package:covoiturage/ProfileInfoEdit0.dart';
import 'package:covoiturage/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covoiturage/reusable_widgets/reusable_widget.dart';
import 'package:covoiturage/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:covoiturage/screens/signup2.Dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _PhoneNumberTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController =
      TextEditingController();
  // controllers for text fields
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  // variable to store selected date
  late DateTime _selectedDate;

  // sign user up method
  Future signUserUp() async {
    /*showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );*/
    //check email validity:
    bool isValid = _emailTextController.text.contains("@") &&
        (_emailTextController.text.endsWith(".tn") ||
            _emailTextController.text.endsWith(".com"));
    //popup message for wrong invalid email
    if (isValid == false) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Email'),
            content: Text('Please check the validity of your email address.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );
    }
    //pop up messsage for wrong password
    if ((_passwordTextController.text == _confirmPasswordTextController.text) &&
        isValid) {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailTextController.text,
                password: _passwordTextController.text)
            .then((value) => Navigator.of(context).pop());

        addUserDetail(_userNameTextController.text,
            _PhoneNumberTextController.text, _emailTextController.text);
        // navigate to SignUpScreen2 page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen2()),
        );
      } catch (e) {
        print(e);
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('eroor: $e'),
            content: Text('eroor: $e'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );
      }
    }
/*else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Passwords don't match!"),
          );
        },
      );
    }*/
  }

  Future addUserDetail(String name, String phone, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'name': name,
      'phone': phone,
      'email': email,
      'userId': FirebaseAuth.instance.currentUser!.uid.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Phone number", Icons.phone, false,
                    _PhoneNumberTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email Id", Icons.email_outlined, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Confirm Password", Icons.lock_outlined, true,
                    _confirmPasswordTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Sign Up", () {
                  signUserUp();
                  /*FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    print("Created New Account");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileInfoEdit02()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });*/
                })
              ],
            ),
          ))),
    );
  }
}
