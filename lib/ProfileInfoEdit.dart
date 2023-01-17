import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covoiturage/ProfileInfoEdit.dart';
import 'package:covoiturage/ProfileInfoEdit0.dart';
import 'package:covoiturage/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covoiturage/reusable_widgets/reusable_widget.dart';
import 'package:covoiturage/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class ProfileInfoEdit2 extends StatefulWidget {
  const ProfileInfoEdit2({Key? key}) : super(key: key);

  @override
  _SignUpScreenState2 createState() => _SignUpScreenState2();
}

class _SignUpScreenState2 extends State<ProfileInfoEdit2> {
  TextEditingController _birthdayTextController = TextEditingController();
  TextEditingController _genderTextController = TextEditingController();
  TextEditingController _professionTextController = TextEditingController();
  TextEditingController _selectedTime = TextEditingController();

  bool _dateSelected = false;
  String _selectedGender = 'male';

  @override
  void initState() {
    super.initState();
    _selectedTime = TextEditingController();
  }

  @override
  void dispose() {
    _selectedTime.dispose();

    super.dispose();
  }

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();
  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    late DateTime _selectedDate;

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
    } catch (e) {
      print('error occured');
    }
  }

  Future addUserDetail(
      String birthday, String gender, String profession) async {
// Get the current user
//final FirebaseUser user = await FirebaseAuth.instance.currentUser();
// Get a reference to the user's document in the "users" collection
//final DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
    final DocumentReference userRef = documentSnapshot.reference;

// Update the user's document with the new information
    await userRef.update({
      'birthday': birthday,
      'gender': gender,
      'profession': profession,
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
          "Profile Info",
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
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _birthdayTextController,
                  decoration: InputDecoration(
                    labelText: 'Birthday',
                    prefixIcon: Icon(Icons.date_range),
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );

                    setState(() {
                      _birthdayTextController.text =
                          '${selectedDate.toString().substring(0, 11)}';
                      _dateSelected = true;
                    });
                  },
                  validator: (value) {
                    if (!_dateSelected) {
                      return 'Please select your birthday';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Gender',
                  ),
                  value: _genderTextController.text.isEmpty
                      ? null
                      : _genderTextController.text,
                  items: [
                    'male',
                    'female',
                  ].map((destination) {
                    return DropdownMenuItem(
                      value: destination,
                      child: Text(destination),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _genderTextController.text = value.toString();
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select your gender';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Profession", Icons.person_outline, false,
                    _professionTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Save", () {
                  addUserDetail(
                      _birthdayTextController.text,
                      _genderTextController.text,
                      _professionTextController.text);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => home()));
                }),
              ],
            ),
          ))),
    );
  }
}
