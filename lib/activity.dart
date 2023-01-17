import 'package:covoiturage/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Add.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'notification.dart';
import 'home.dart';
import 'post.dart';
import 'postrequests.dart';
import 'notification.dart';

void main() => runApp(chat());

class chat extends StatelessWidget {
  const chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //access to collection inside collection
    final tasksCollection = FirebaseFirestore.instance
        .collection("rides")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection("requests");
    print(tasksCollection);

    /*FirebaseFirestore.instance
        .collection('rides')
        .where('userId',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString())
        .snapshots();*/

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Covoiturage",
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
            child: Icon(Icons.notifications),
            backgroundColor: Colors.teal,
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text("Activities"),
          ),
          body: Container(
            child: StreamBuilder(
              stream: /*tasksCollection.snapshots(),*/
                  FirebaseFirestore.instance
                      .collection('rides')
                      .where('userId',
                          isEqualTo:
                              FirebaseAuth.instance.currentUser!.uid.toString())
                      .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: InkWell(
                            onTap: () async {
                              final selectedPost =
                                  snapshot.data!.docs[index].data();
                              Map<String, dynamic> data =
                                  snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PostRequest(
                                      selectedPost: data,
                                      rideID: snapshot.data!.docs[index].id),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 15.0),
                              height: 170,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey[200],
                                  borderRadius: BorderRadius.circular(25)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 15,
                                        child: Text(
                                            'departure: ${snapshot.data!.docs[index]['departure']}'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          10), // creates a space of height 10
                                  Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 15,
                                        child: Text(
                                            'destination: ${snapshot.data!.docs[index]['destination']}'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          10), // creates a space of height 10
                                  Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 15,
                                        child: Text(
                                            'price: ${snapshot.data!.docs[index]['price']}'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          10), // creates a space of height 10
                                  Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 15,
                                        child: Text(
                                            'seats: ${snapshot.data!.docs[index]['seats']}'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          10), // creates a space of height 10
                                  Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 15,
                                        child: Text(
                                            'time: ${snapshot.data!.docs[index]['time']}'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          10), // creates a space of height 10
                                  FutureBuilder(
                                      future: FirebaseFirestore.instance
                                          .collection("users")
                                          .where("email",
                                              isEqualTo: snapshot
                                                  .data!.docs[index]['email'])
                                          .get(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              userSnapshot) {
                                        if (userSnapshot.hasData &&
                                            userSnapshot
                                                .data!.docs.isNotEmpty) {
                                          return Text(
                                            "Name: ${userSnapshot.data!.docs[0]['name']}",
                                          );
                                        } else {
                                          return Text("Name:       ");
                                        }
                                      }),
                                ],
                              ),
                            ),
                          )));
                } else {
                  return Container();
                }
              },
            ),
          ),
        ));
  }
}
