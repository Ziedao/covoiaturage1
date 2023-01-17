import 'package:covoiturage/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(rules2());

class rules2 extends StatelessWidget {
  const rules2({Key? key}) : super(key: key);

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
        body: Rules(),
      ),
    );
  }
}

class Rules extends StatelessWidget {
  const Rules({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
      child: Column(
        children: [
          const Text(
            "Rules",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Colors.teal,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            "We're commited, along with millions of ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const Text(
            "riders and drivers, to:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            "-Treat everyone with kindness ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          const Text(
            "and respect ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            "-Help keep one another safe",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            "-Follow the law",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            "Everyone who uses this app is expected to ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const Text(
            "follow these rules ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          Container(
            height: 30,
            width: double.infinity,
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 30,
            color: Colors.black,
          ),
          Container(
            height: 60,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient:
                    const LinearGradient(colors: [Colors.blue, Colors.green])),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => (home())),
                );
              },
              child: const Text(
                "I understand",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
