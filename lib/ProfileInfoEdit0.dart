import 'package:covoiturage/Rules.dart';
import 'package:flutter/material.dart';

void main() => runApp(ProfileInfoEdit0());

class ProfileInfoEdit02 extends StatelessWidget {
  const ProfileInfoEdit02({Key? key}) : super(key: key);

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
        body: ProfileInfoEdit0(),
      ),
    );
  }
}

class ProfileInfoEdit0 extends StatelessWidget {
  const ProfileInfoEdit0({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Stack(
            children: [
              Container(
                width: 200,
                height: 180,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 1))
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://media.istockphoto.com/id/1223671392/fr/vectoriel/photo-de-profil-par-d%C3%A9faut-avatar-photo-placeholder-illustration-de-vecteur.jpg?s=170667a&w=0&k=20&c=EqD6q8IUqwN_bgGec0UBhh3tk2Zuur5lezDDlQsGdPY="))),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      color: Colors.green,
                    ),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          TextFormField(
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              labelText: "Profession",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.work),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          TextFormField(
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              labelText: "City",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_city),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          TextFormField(
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              labelText: "About",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            height: 40,
            width: 140,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient:
                    const LinearGradient(colors: [Colors.blue, Colors.green])),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => rules2()),
                );
              },
              child: const Text(
                "Save",
                style: TextStyle(
                  fontSize: 21,
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
