import 'package:covoiturage/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class add2 extends StatefulWidget {
  @override
  _add2State createState() => _add2State();
}

class _add2State extends State<add2> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool _dateSelected = false;

  TextEditingController _selectedTime = TextEditingController();
  TextEditingController _selectedDestination = TextEditingController();
  TextEditingController _selectedDeparture = TextEditingController();
  TextEditingController _selectedSeats = TextEditingController();
  TextEditingController _selectedPrice = TextEditingController();
  TextEditingController _nameofuser = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedTime = TextEditingController();
    _selectedDestination = TextEditingController();
    _selectedDeparture = TextEditingController();
    _selectedSeats = TextEditingController();
    _selectedPrice = TextEditingController();
  }

  @override
  void dispose() {
    _selectedTime.dispose();
    _selectedDestination.dispose();
    _selectedDeparture.dispose();
    _selectedSeats.dispose();
    _selectedPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: true,
        title: "Covoiturage",
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: Text("Add"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    // Date and time picker
                    TextFormField(
                      controller: _selectedTime,
                      decoration: InputDecoration(
                        labelText: 'Date and Time',
                        prefixIcon: Icon(Icons.date_range),
                      ),
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        final selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        setState(() {
                          _selectedTime.text =
                              '${selectedDate.toString().substring(0, 11)} ${selectedTime.toString()}';
                          _dateSelected = true;
                        });
                      },
                      validator: (value) {
                        if (!_dateSelected) {
                          return 'Please select a date and time';
                        }
                        return null;
                      },
                    ),

                    // Destination dropdown
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Destination',
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      value: _selectedDestination.text.isEmpty
                          ? null
                          : _selectedDestination.text,
                      items: [
                        'Ariana',
                        'Ben Arous',
                        'Bizerte',
                        'Béja',
                        'Gabès',
                        'Gafsa',
                        'Jendouba',
                        'Kairouan',
                        'Kasserine',
                        'Kébili',
                        'La Manouba',
                        'Le Kef',
                        'Mahdia',
                        'Monastir',
                        'Médnine',
                        'Nabeul',
                        'Sfax',
                        'Sidi Bouzid',
                        'Siliana',
                        'Sousse',
                        'Tataouine',
                        'Tozeur',
                        'Tunis',
                        'Zaghouan'
                      ].map((destination) {
                        return DropdownMenuItem(
                          value: destination,
                          child: Text(destination),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedDestination.text = value.toString();
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a destination';
                        }
                        return null;
                      },
                    ),

                    // Departure dropdown
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'departure',
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      value: _selectedDeparture.text.isEmpty
                          ? null
                          : _selectedDeparture.text,
                      items: [
                        'Ariana',
                        'Ben Arous',
                        'Bizerte',
                        'Béja',
                        'Gabès',
                        'Gafsa',
                        'Jendouba',
                        'Kairouan',
                        'Kasserine',
                        'Kébili',
                        'La Manouba',
                        'Le Kef',
                        'Mahdia',
                        'Monastir',
                        'Médnine',
                        'Nabeul',
                        'Sfax',
                        'Sidi Bouzid',
                        'Siliana',
                        'Sousse',
                        'Tataouine',
                        'Tozeur',
                        'Tunis',
                        'Zaghouan'
                      ].map((departure) {
                        return DropdownMenuItem(
                          value: departure,
                          child: Text(departure),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedDeparture.text = value.toString();
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a departure';
                        }
                        return null;
                      },
                    ),

                    // Seats dropdown
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Seats Available',
                        prefixIcon: Icon(Icons.chair_rounded),
                      ),
                      value: _selectedSeats.text.isEmpty
                          ? null
                          : _selectedSeats.text,
                      items: ['1', '2', '3', '4'].map((seats) {
                        return DropdownMenuItem(
                          value: seats,
                          child: Text(seats),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedSeats.text = value.toString();
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select nbr of availebale seats';
                        }
                        return null;
                      },
                    ),

                    // Price input
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Price per place (in TND)',
                        prefixIcon: Icon(Icons.money),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the price';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _selectedPrice.text = double.parse(value!).toString();
                      },
                    ),
                    // Submit button
                    /* RaisedButton(
                  child: Text('Add Ride'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
          
                      // Add data to Firestore
                      _firestore.collection('rides').add({
                        'time': _selectedTime,
                        'destination': _selectedDestination,
                        'departure': _selectedDeparture,
                        'seats': _selectedSeats,
                        'price': _selectedPrice,
                      });
          
                      Navigator.pop(context);
                    }
                  },
                ),*/
                    TextButton(
                        child: Text('Add Ride'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            // Add data to Firestore

                            try {
                              final user = await _auth.currentUser!;
                              final userId = user.uid;
                              //final names = GetUserName(userId);
                              //print(names);
                              print("//////");

                              /*final document = _firestore.collection('users').doc(userId);
                          final snapshot = await document.get();*/
                              //final name = snapshot.data['name'];

                              await _firestore.collection('rides').add({
                                'time': _selectedTime.text,
                                'destination': _selectedDestination.text,
                                'departure': _selectedDeparture.text,
                                'seats': _selectedSeats.text,
                                'price': _selectedPrice.text,
                                'userId': user.uid,
                                'email': user.email,
                                "timestamp": FieldValue.serverTimestamp(),
                                //'phoneNumber': names,
                              });
                              Navigator.pop(context);
                            } catch (e) {
                              print(e);
                            }

                            /* _firestore.collection('rides').add({
                        'time': _selectedTime.text,
                        'destination': _selectedDestination.text,
                        'departure': _selectedDeparture.text,
                        'seats': _selectedSeats.text,
                        'price': _selectedPrice.text,
                      });*/

                            //Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => home()));
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

//Future<Map<String, dynamic>> getData(String userId) async {
  // Get a reference to the collection
  //CollectionReference collection = FirebaseFirestore.instance.collection('users');

  // Get the document with the matching `userId`
  //DocumentSnapshot snapshot = await collection.doc(userId).get();

  // Return the data as a map
  //return snapshot.data();
//}

/*class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget 
    build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['name']}");
        }

        return Text("loading");
      },
    );
  }
}*/
















/*import 'package:covoiturage/home.dart';
import 'package:flutter/material.dart';
import 'select.dart';

void main() => runApp(add2());







class add extends StatelessWidget {
  const add({Key? key}) : super(key: key);

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
          title: Text("Add Ride"),
        ),
        body: add2(),
      ),
    );
  }
}

class add2 extends StatefulWidget {
  @override
  State<add2> createState() => _add2();
}

class _add2 extends State<add2> {
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Add Ride"),
        ),
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          '${dateTime.day}/${dateTime.month}/${dateTime.year} - ${dateTime.hour}:${dateTime.minute}',
          style: const TextStyle(fontSize: 20),
        ),
        ElevatedButton(
          child:
              const Text('Select date & time', style: TextStyle(fontSize: 20)),
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: dateTime,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (newDate == null) return;
            TimeOfDay? newTime = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
            );
            if (newTime == null) return;

            final newDateTime = DateTime(
              newDate.year,
              newDate.month,
              newDate.day,
              newTime.hour,
              newTime.minute,
            );

            setState(() {
              dateTime = newDateTime;
            });
          },
        ),
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Number of places available: ",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        DropdownButtonExample(),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 200,
          child: TextField(
            decoration: InputDecoration(
              labelText: "Price (per place)",
              prefixIcon: Icon(Icons.attach_money_outlined),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Text(
          "From",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        DropdownButtonExample2(),
        const SizedBox(
          height: 30,
        ),
        const Text(
          "To",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        DropdownButtonExample2(),
        const SizedBox(
          height: 60,
        ),
        Container(
          height: 40,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient:
                  const LinearGradient(colors: [Colors.blue, Colors.green])),
          child: MaterialButton(
            onPressed: () {},
            child: const Text(
              "Post",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ]),
    ));
  }
}*/
