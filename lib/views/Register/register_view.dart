import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
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
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le champs est obligatoire';
                      }
                    },
                    decoration: const InputDecoration(
                        hintText: 'Entrez votre Prénom', labelText: 'Prénom'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le champs est obligatoire';
                      }
                    },
                    decoration: const InputDecoration(
                        hintText: 'Entrez votre nom', labelText: 'Nom'),
                  ),
                  TextFormField(
                    validator: (value) {},
                    decoration: const InputDecoration(
                        hintText: 'Entrez votre mot de passe',
                        labelText: 'Mot de passe'),
                  ),
                  TextFormField(
                    validator: (value) {},
                    decoration: const InputDecoration(
                        hintText: 'Confirmez votre mot de passe',
                        labelText: 'Confirmation mot de passe'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Signature'),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {}, child: const Text("Importer")),
                      ElevatedButton(
                          onPressed: () {}, child: const Text("Créer"))
                    ],
                  ),
                  ElevatedButton(
                      onPressed: (() async {
                        if (_formKey.currentState!.validate()) {
                          print('je peux enregistrer');
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
