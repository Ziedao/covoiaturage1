import 'package:covoiturage/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'findd.dart';

class find2 extends StatefulWidget {
  @override
  _find2State createState() => _find2State();
}

class _find2State extends State<find2> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool _dateSelected = false;

  TextEditingController _selectedTime = TextEditingController();
  TextEditingController _selectedDestination = TextEditingController();
  TextEditingController _selectedDeparture = TextEditingController();
  TextEditingController _nameofuser = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedTime = TextEditingController();
    _selectedDestination = TextEditingController();
    _selectedDeparture = TextEditingController();
  }

  @override
  void dispose() {
    _selectedTime.dispose();
    _selectedDestination.dispose();
    _selectedDeparture.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Covoiturage",
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: Text("Find"),
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
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                      },
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

                    TextButton(
                      child: Text('Find Ride'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          print(_selectedDeparture.text);
                          findd(
                              departure: _selectedDeparture.text,
                              destination: _selectedDestination.text,
                              time: _selectedTime.text);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => findd(
                                      departure: _selectedDeparture.text,
                                      destination: _selectedDestination.text,
                                      time: _selectedTime.text)));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
