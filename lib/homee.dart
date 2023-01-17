import 'package:covoiturage/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'Add.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covoiturage/post.dart';

void main() => runApp(homee());

class homee extends StatelessWidget {
  const homee({Key? key}) : super(key: key);

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
          body: Container(
            padding: EdgeInsets.all(10.0),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('rides')
                  .where('seats', whereIn: ['4', '1', '2', '3'])
                  //.orderBy("timestamp", descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return (ListView.separated(
                    padding: EdgeInsets.all(
                        5.0), //  maaaaaaaaaaaaaaaaaaaaaaaake it bea
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {
                          final selectedPost =
                              snapshot.data!.docs[index].data();
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
                                            isEqualTo: snapshot
                                                .data!.docs[index]['email'])
                                        .get(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot>
                                            userSnapshot) {
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
            ),
          ),
        ));
  }
}
