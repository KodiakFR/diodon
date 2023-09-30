import 'package:crypt/crypt.dart';
import 'package:diodon/entities/user.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  final _isarService = IsarService();

  @override
  Widget build(BuildContext context) {
    String _password = "";
    String _name = "";
    String _firstName = "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Diodon"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Nouvel Utilisateur',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le champs est obligatoire';
                      }
                      _firstName = value;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Entrez votre Prénom', labelText: 'Prénom'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le champs est obligatoire';
                      }
                      _name = value;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Entrez votre nom', labelText: 'Nom'),
                  ),
                  TextFormField(
                    validator: (value) {
                      _password = value!;
                      if (value.isEmpty) {
                        return 'Le champs est obligatoire';
                      }
                      if (value.length < 7) {
                        return 'Votre mot de passe doit contenir un minium de 7 caractères';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Entrez votre mot de passe',
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le champs est obligatoire';
                      }
                      if (value != _password) {
                        return 'Vos mots de passe ne sont pas identiques';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Confirmez votre mot de passe',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: (() async {
                        if (_formKey.currentState!.validate()) {
                          final cryptPassword = Crypt.sha256(_password);
                          final newUser = User()
                            ..name = _name
                            ..firstName = _firstName
                            ..password = cryptPassword.toString();
                          bool userSave = await _isarService.saveUser(newUser);
                          if (userSave == true) {
                            Navigator.pushReplacementNamed(
                                context, '/connexion');
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                'L\'utilisateur existe déjà',
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.red,
                            ));
                          }
                        }
                      }),
                      child: const Text('Enregistrer'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
