// ignore_for_file: use_build_context_synchronously

import 'package:crypt/crypt.dart';
import 'package:diodon/bloc/connection_bloc.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../entities/user.dart';

class ConnexionView extends StatelessWidget {
  const ConnexionView({super.key});

  @override
  Widget build(BuildContext context) {
    final isarService = IsarService();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diodon"),
      ),
      body: SafeArea(
        child: Center(
          child: BlocBuilder<ConnexionBloc, Connexion>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return Column(
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
                          context
                              .read<ConnexionBloc>()
                              .addUsers(snapshot.data!);
                          if (state.users!.isEmpty) {
                            return const Text('Aucuns utilisateurs');
                          }
                          return _displayAvatar(state);
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
              );
            },
          ),
        ),
      ),
    );
  }

  Flexible _displayAvatar(Connexion state) {
    return Flexible(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        itemCount: state.users!.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    child: TextButton(
                        onPressed: () async {
                          await _displayPopConnexion(
                              context, state.users![index].id);
                        },
                        child: Text(
                          '${state.users![index].firstName} ${state.users![index].name}',
                          style: Theme.of(context).textTheme.titleLarge,
                        )),
                  ),
                  IconButton(
                      onPressed: () async {
                        await _displayPopdDelte(context, state.users![index]);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 35,
                      ))
                ],
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
    final formKey = GlobalKey<FormState>();
    String mdp = '';
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text(
                'Connection',
                textAlign: TextAlign.center,
              ),
              actions: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Entrez votre mot de passe',
                        ),
                        validator: (value) {
                          mdp = value!;
                          if (value.isEmpty) {
                            return 'Le champs est obligatoire';
                          }
                          return null;
                        },
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            _connection(id, mdp, context);
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

  Future<void> _connection(int id, String mdp, BuildContext context) async {
    final isarService = IsarService();
    final cryptPassword = await isarService.getPasswordUser(id);
    final passwordIsTrue = Crypt(cryptPassword).match(mdp);
    if (passwordIsTrue == true) {
      User user = await isarService.getUser(id);
      context.read<ConnexionBloc>().logIn(user);
      Navigator.pushNamedAndRemoveUntil(context, "/homePage", (route) => false);
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Mot de passe invalide',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _displayPopdDelte(BuildContext context, User user) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.warning, color: Colors.red),
              Text(
                'Suppression',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: Text(
              "Voulez-vous vraiment supprimer ${user.firstName} ${user.name}?\nCette action supprimera le compte, la signature et le stamp de la personne. "),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    context.read<ConnexionBloc>().deleteUser(user);
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
