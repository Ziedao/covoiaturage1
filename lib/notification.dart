import 'package:covoiturage/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'activity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => home())),
        ),
        backgroundColor: Colors.teal,
        title: Text('Notifications'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('ridesrequests')
              .where('accepted', isEqualTo: true)
              .where("Email",
                  isEqualTo:
                      FirebaseAuth.instance.currentUser!.email.toString())
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('rides')
                          .doc(document['rideId'])
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> rideSnapshot) {
                        if (rideSnapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              height: 75,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(25)),
                              child: Column(children: [
                                SizedBox(
                                  height: 5,
                                ),
                                FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection("users")
                                        .where("email",
                                            isEqualTo:
                                                rideSnapshot.data?['email'])
                                        .get(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot>
                                            userSnapshot) {
                                      if (userSnapshot.hasData &&
                                          userSnapshot.data!.docs.isNotEmpty) {
                                        return Text(
                                          "${userSnapshot.data!.docs[0]['name']} has accepted your request for the ride from ${rideSnapshot.data!['departure']} to ${rideSnapshot.data!['destination']} at ${rideSnapshot.data!['time']}}",
                                        );
                                      } else {
                                        return Text("Name: Unknown");
                                      }
                                    }),
                                SizedBox(
                                  height: 5,
                                ),
                              ]),
                            ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      });
                }).toList(),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
