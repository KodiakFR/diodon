import 'package:diodon/services/isar_service.dart';
import 'package:flutter/material.dart';

import '../../entities/user.dart';

class ConnexionView extends StatelessWidget {
  ConnexionView({super.key});
  final isarService = IsarService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diodon"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Connexion',
                  style: Theme.of(context).textTheme.displayMedium),
              FutureBuilder(
                  future: isarService.getAllUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    if (snapshot.hasData) {
                      List<User> users = snapshot.data!;
                      if (users.isEmpty) {
                        return Text('Aucuns utilisateurs');
                      }
                      return _displayAvatar(users);
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/register");
                  },
                  child: const Text("Ajouter un utilisateur"))
            ],
          ),
        ),
      ),
    );
  }

  Flexible _displayAvatar(List<User> users) {
    return Flexible(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                child: TextButton(
                    onPressed: () async {
                      print(users[index].id);
                      await _displayPopConnexion(context, users[index].id);
                    },
                    child: Text(
                      '${users[index].firstName} ${users[index].name}',
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
              ),
              const SizedBox(
                width: 100,
              )
            ],
          );
        },
      ),
    );
  }

  Future<void> _displayPopConnexion(BuildContext context, int id) async {
    String mdp = 'a';
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: const Text('Connection'),
              actions: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Entrez votre mot de passe',
                        ),
                        validator: (value) {
                          mdp = value!;
                          if (value.isEmpty) {
                            return 'Le champs est obligatoire';
                          }
                        },
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final isConnected =
                                await isarService.connexionUser(mdp, id);
                            if (isConnected == true) {
                              print('je suis connecté');
                            } else {
                              print('je suis pas connecté');
                            }
                          }
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              ],
            ));
  }
}
