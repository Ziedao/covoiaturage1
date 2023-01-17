import 'package:covoiturage/reset.dart';
import 'package:flutter/material.dart';
import 'Rules.dart';

void main() => runApp(Code2());

class Code2 extends StatelessWidget {
  const Code2({Key? key}) : super(key: key);

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
        body: Code(),
      ),
    );
  }
}

class Code extends StatelessWidget {
  const Code({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          const SizedBox(
            height: 55,
          ),
          const Text(
            "Enter the 5-digit code sent at :",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const Text(
            "*********",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Enter code",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient:
                    const LinearGradient(colors: [Colors.blue, Colors.green])),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => reset2()),
                );
              },
              child: const Text(
                "Enter",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          const Divider(
            height: 30,
            color: Colors.black,
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't recieve a code?",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              TextButton(onPressed: () {}, child: const Text("Resend"))
            ],
          ),
        ],
      ),
    );
  }
}
