import 'package:flutter/material.dart';

class ConnexionView extends StatelessWidget {
  const ConnexionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diodon"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Connexion', style: Theme.of(context).textTheme.headline2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                CircleAvatar(
                  minRadius: 60,
                  child: Text('Aurélien'),
                ),
                CircleAvatar(
                  minRadius: 60,
                  child: Text('Patick'),
                ),
                CircleAvatar(
                  minRadius: 60,
                  child: Text('Eric'),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/register");
                },
                child: const Text("Ajouter un utilisateur"))
          ],
        ),
      ),
    );
  }
}
