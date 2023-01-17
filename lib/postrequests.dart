import 'package:covoiturage/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'activity.dart';

class PostRequest extends StatefulWidget {
  final Map<String, dynamic> selectedPost;
  final String rideID;

  PostRequest({Key? key, required this.selectedPost, required this.rideID})
      : super(key: key);

  @override
  State<PostRequest> createState() => _PostRequestState();
}

class _PostRequestState extends State<PostRequest> {
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ride Requests"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('ridesrequests')
              .where('rideId', isEqualTo: widget.rideID)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              print(snapshot.hasData);

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('email',
                            isEqualTo: snapshot.data!.docs[index]['Email'])
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> userSnapshot) {
                      if (userSnapshot.hasData) {
                        //print(snapshot.hasData);
                        print('/////////////');
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
                                    height: 10), // creates a space of height 10
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                            "${userSnapshot.data!.docs[0]['name']} has requested ${snapshot.data!.docs[index]['seats']} places for this ride "),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      left: 20,
                                      child: Container(
                                        height: 30,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: snapshot.data!
                                                      .docs[index]['accepted']
                                                      .toString() ==
                                                  'true'
                                              ? Colors.grey
                                              : Colors.green,
                                        ),
                                        child: MaterialButton(
                                          onPressed: () async {
                                            if (snapshot.data!
                                                    .docs[index]['accepted']
                                                    .toString() ==
                                                'false') {
                                              String seatsno = snapshot
                                                  .data!.docs[index]['seats']
                                                  .toString();
                                              //decrese seats number
                                              FirebaseFirestore.instance
                                                  .collection("rides")
                                                  .doc(widget.rideID)
                                                  .get()
                                                  .then((doc) {
                                                String attributeValue =
                                                    doc["seats"];
                                                print(seatsno);
                                                print('///aaa///');
                                                if (attributeValue.isNotEmpty) {
                                                  int attributeInt =
                                                      int.parse(attributeValue);

                                                  //attributeInt--;
                                                  attributeInt = attributeInt -
                                                      int.parse(seatsno);
                                                  FirebaseFirestore.instance
                                                      .collection("rides")
                                                      .doc(widget.rideID)
                                                      .update({
                                                    "seats":
                                                        attributeInt.toString(),
                                                  });
                                                }
                                              });
                                              await firestore
                                                  .collection('ridesrequests')
                                                  .where("Email",
                                                      isEqualTo: userSnapshot
                                                          .data!
                                                          .docs[0]['email'])
                                                  .where("rideId",
                                                      isEqualTo: widget.rideID)
                                                  .get()
                                                  .then((querySnapshot) {
                                                querySnapshot.docs
                                                    .forEach((doc) {
                                                  firestore
                                                      .collection(
                                                          "ridesrequests")
                                                      .doc(doc.id)
                                                      .update(
                                                          {"accepted": true});
                                                });
                                              });
                                              setState(() {});
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    //title: Text('already accepted'),
                                                    content: Text(
                                                        'already accepted.'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: Text('OK'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(true);
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                            /*String seatsno = snapshot
                                                .data!.docs[index]['seats']
                                                .toString();
                                            //decrese seats number
                                            FirebaseFirestore.instance
                                                .collection("rides")
                                                .doc(widget.rideID)
                                                .get()
                                                .then((doc) {
                                              String attributeValue =
                                                  doc["seats"];
                                              print(seatsno);
                                              print('///aaa///');
                                              if (attributeValue.isNotEmpty) {
                                                int attributeInt =
                                                    int.parse(attributeValue);

                                                //attributeInt--;
                                                attributeInt = attributeInt -
                                                    int.parse(seatsno);
                                                FirebaseFirestore.instance
                                                    .collection("rides")
                                                    .doc(widget.rideID)
                                                    .update({
                                                  "seats":
                                                      attributeInt.toString(),
                                                });
                                              }
                                            });
                                            await firestore
                                                .collection('ridesrequests')
                                                .where("Email",
                                                    isEqualTo: userSnapshot
                                                        .data!.docs[0]['email'])
                                                .where("rideId",
                                                    isEqualTo: widget.rideID)
                                                .get()
                                                .then((querySnapshot) {
                                              querySnapshot.docs.forEach((doc) {
                                                firestore
                                                    .collection("ridesrequests")
                                                    .doc(doc.id)
                                                    .update({"accepted": true});
                                              });
                                            });
                                            setState(() {});*/
                                          },
                                          child: snapshot.data!
                                                      .docs[index]['accepted']
                                                      .toString() ==
                                                  'true'
                                              ? Text("Accepted",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white))
                                              : Text("Accept",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white)),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ])),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
