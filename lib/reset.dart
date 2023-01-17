import 'package:covoiturage/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(reset2());

class reset2 extends StatelessWidget {
  const reset2({Key? key}) : super(key: key);

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
        body: reset(),
      ),
    );
  }
}

class reset extends StatelessWidget {
  const reset({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          const Text(
            "New Credentials",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: Colors.teal,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          const Text(
            "Set your new password",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.remove_red_eye)),
          ),
          const SizedBox(
            height: 25,
          ),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: const InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.remove_red_eye)),
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            height: 45,
          ),
          Container(
            height: 40,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient:
                    const LinearGradient(colors: [Colors.blue, Colors.green])),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => home()),
                );
              },
              child: const Text(
                "Save",
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
