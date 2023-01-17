import 'package:covoiturage/home.dart';
import 'package:flutter/material.dart';
import 'find.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'post.dart';

class findd extends StatelessWidget {
  final String departure;
  final String destination;
  final String time;
  const findd(
      {Key? key,
      required this.departure,
      required this.destination,
      required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => home())),
        ),
        centerTitle: true,
        title: Text("Covoiturage"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('rides')
              .where('destination', isEqualTo: destination)
              .where('departure', isEqualTo: departure)
              .where('seats', whereIn: ['4', '1', '2', '3']).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return (ListView.separated(
                padding:
                    EdgeInsets.all(5.0), //  maaaaaaaaaaaaaaaaaaaaaaaake it bea
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      final selectedPost = snapshot.data!.docs[index].data();
                      Map<String, dynamic> data = snapshot.data!.docs[index]
                          .data() as Map<String, dynamic>;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostPage(
                              selectedPost: data,
                              rideID: snapshot.data!.docs[index].id),
                        ),
                      );
                    },
                    child: Container(
                        padding: EdgeInsets.all(6.0),
                        height: 175,
                        decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                      "Departure : ${snapshot.data!.docs[index]['departure']}"),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                      "Destination : ${snapshot.data!.docs[index]['destination']}"),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                      "time and day : ${snapshot.data!.docs[index]['time']}"),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                      "Seats available : ${snapshot.data!.docs[index]['seats']}"),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                      "Price : ${snapshot.data!.docs[index]['price']} TND"),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection("users")
                                    .where("email",
                                        isEqualTo: snapshot.data!.docs[index]
                                            ['email'])
                                    .get(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> userSnapshot) {
                                  if (userSnapshot.hasData &&
                                      userSnapshot.data!.docs.isNotEmpty) {
                                    return Text(
                                      "Name: ${userSnapshot.data!.docs[0]['name']}",
                                    );
                                  } else {
                                    return Text("Name:       ");
                                  }
                                }),
                          ],
                        )),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                itemCount: snapshot.data!.docs.length,
              ));
            } else {
              return Container();
            }
          },
          /*builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return (ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {},
                    child: Container(
                        padding: EdgeInsets.all(6.0),
                        height: 175,
                        decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                      "Departure : ${snapshot.data!.docs[index]['departure']}"),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                      "Destination : ${snapshot.data!.docs[index]['destination']}"),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                      "time and day : ${snapshot.data!.docs[index]['time']}"),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                      "Seats available : ${snapshot.data!.docs[index]['seats']}"),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                      "Price : ${snapshot.data!.docs[index]['price']} TND"),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection("users")
                                    .where("email",
                                        isEqualTo: snapshot.data!.docs[index]
                                            ['email'])
                                    .get(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> userSnapshot) {
                                  if (userSnapshot.hasData &&
                                      userSnapshot.data!.docs.isNotEmpty) {
                                    return Text(
                                      "Name: ${userSnapshot.data!.docs[0]['name']}",
                                    );
                                  } else {
                                    return Text("Name:       ");
                                  }
                                }),
                          ],
                        )),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                itemCount: snapshot.data!.docs.length,
              ));

              /*ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0),
                          height: 160,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
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
                                  height: 10), // creates a space of height 10
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
                                  height: 10), // creates a space of height 10
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
                                  height: 10), // creates a space of height 10
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
                                  height: 10), // creates a space of height 10
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
                                  height: 10), // creates a space of height 10
                              Row(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 15,
                                    child: Text(
                                        snapshot.data!.docs[index]['email']),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ));*/
            } else {
              return Container();
            }
          },*/
        ),
      ),
    );
    /*Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => home())),
        ),
        backgroundColor: Colors.teal,
        title: Text('Results'),
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('rides')
              .where('destination', isEqualTo: destination)
              .where('departure', isEqualTo: departure)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {},
                    child: Container(
                        padding: EdgeInsets.all(6.0),
                        height: 175,
                        decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                      "Departure : ${snapshot.data!.docs[index]['departure']}"),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                      "Destination : ${snapshot.data!.docs[index]['destination']}"),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                      "time and day : ${snapshot.data!.docs[index]['time']}"),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                      "Seats available : ${snapshot.data!.docs[index]['seats']}"),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                      "Price : ${snapshot.data!.docs[index]['price']} TND"),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                      "Email : ${snapshot.data!.docs[index]['email']}"),
                                ),
                              ],
                            ),
                          ],
                        )),
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );*/
  }
}
