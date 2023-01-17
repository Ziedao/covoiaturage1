import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostPage extends StatefulWidget {
  final Map<String, dynamic> selectedPost;
  final String rideID;

  PostPage({
    Key? key,
    required this.selectedPost,
    required this.rideID,
  }) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final firestore = FirebaseFirestore.instance;
  final _seatsController = TextEditingController();
  int _selectedSeats = 1;

  void _showSeatsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter the number of seats you want to request"),
          content: Form(
            child: DropdownButtonFormField(
                value: _selectedSeats,
                items: List.generate(int.parse(widget.selectedPost['seats']),
                        (index) => index + 1)
                    .map((seat) => DropdownMenuItem(
                          value: seat,
                          child: Text("$seat seats"),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedSeats = newValue!;
                    _seatsController.text = _selectedSeats.toString();
                  });
                }),
          )
          /*Form(
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^[0-9]')),
              ],
              controller: _seatsController,
            ),
          )*/
          ,
          actions: <Widget>[
            TextButton(
              child: Text("Confirm"),
              onPressed: () async {
                // code to add request to Firestore here
                final docRef = await firestore.collection("ridesrequests").add({
                  'Email': FirebaseAuth.instance.currentUser!.email,
                  'rideId': widget.rideID,
                  'seats': int.parse(_seatsController
                      .text), // or the variable where you stored the value that user entered
                  'accepted': false,
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Post Information"),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 20.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    child:
                        Text("Departure : ${widget.selectedPost['departure']}"),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    child: Text(
                        "Destination : ${widget.selectedPost['destination']}"),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    child:
                        Text("time and day : ${widget.selectedPost['time']}"),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    child: Text("Price : ${widget.selectedPost['price']}"),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    child: Text(
                        "Seats available : ${widget.selectedPost['seats']}"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(height: 20, color: Colors.black),
              SizedBox(height: 20),
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .where("email", isEqualTo: widget.selectedPost['email'])
                      .get(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> userSnapshot) {
                    if (userSnapshot.hasData &&
                        userSnapshot.data!.docs.isNotEmpty) {
                      return Column(
                        children: <Widget>[
                          Text("Rider Info",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 25)),
                          const SizedBox(
                            height: 20,
                          ),
                          Text("Name: ${userSnapshot.data!.docs[0]['name']}"),
                          const SizedBox(
                            height: 20,
                          ),
                          Text("Phone: ${userSnapshot.data!.docs[0]['phone']}"),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                              "Birthday: ${userSnapshot.data!.docs[0]['birthday']}"),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                              "Gender: ${userSnapshot.data!.docs[0]['gender']}"),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                              "Profession: ${userSnapshot.data!.docs[0]['profession']}"),
                        ],
                      );
                    } else {
                      return Text("Name:       ");
                    }
                  }),
              //userSnapshot.data!.docs[0]['name']
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
                    if (widget.selectedPost['email'] ==
                        FirebaseAuth.instance.currentUser!.email) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("This is your Post"),
                            content: Text("You can't request your own ride"),
                            actions: <Widget>[
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      _showSeatsDialog(context);
                    }
                  },
                  child: Text("Request ride",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }
}
