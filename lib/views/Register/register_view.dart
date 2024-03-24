// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:crypt/crypt.dart';
import 'package:diodon/bloc/register_bloc.dart';
import 'package:diodon/entities/user.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  final _isarService = IsarService();
  final _formKey = GlobalKey<FormState>();

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
              child: BlocBuilder<RegisterBloc, Register>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Nouvel Utilisateur',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      TextFormField(
                        initialValue: state.firstname,
                        onChanged: (value) =>
                            context.read<RegisterBloc>().changeFirstName(value),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Le champs est obligatoire';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Entrez votre Prénom',
                            labelText: 'Prénom'),
                      ),
                      TextFormField(
                        initialValue: state.name,
                        onChanged: (value) =>
                            context.read<RegisterBloc>().changeName(value),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Le champs est obligatoire';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Entrez votre nom', labelText: 'Nom'),
                      ),
                      TextFormField(
                        initialValue: state.mpd,
                        onChanged: (value) =>
                            context.read<RegisterBloc>().changeMdp(value),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Le champs est obligatoire';
                          }
                          if (value.length < 7) {
                            return 'Votre mot de passe doit contenir un minium de 7 caractères';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Entrez votre mot de passe',
                        ),
                      ),
                      TextFormField(
                        initialValue: state.mdpConfirm,
                        onChanged: (value) => context
                            .read<RegisterBloc>()
                            .changeMdpConfirm(value),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Le champs est obligatoire';
                          }
                          if (value != state.mpd) {
                            return 'Vos mots de passe ne sont pas identiques';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Confirmez votre mot de passe',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                              onPressed: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.image,
                                );
                                if (result != null) {
                                  context.read<RegisterBloc>().changeFile(
                                      File(result.files.single.path!), 'stamp');
                                }
                              },
                              child: const Text('Import Tampon'),
                            ),
                          ),
                          Text(state.files['stamp'] != null
                              ? state.files['stamp']!.path.split('/').last
                              : 'Aucun fichier...')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                              onPressed: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.image,
                                );
                                if (result != null) {
                                  final file = File(result.files.single.path!);
                                  context
                                      .read<RegisterBloc>()
                                      .changeFile(file, 'signature');
                                }
                              },
                              child: const Text('Import Signature'),
                            ),
                          ),
                          Text(state.files['signature'] != null
                              ? state.files['signature']!.path.split('/').last
                              : 'Aucun fichier...'),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Text('OU'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              Navigator.pushReplacementNamed(
                                  context, '/signatureDialog');
                            },
                            child: const Text('Créer signature'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: (() async {
                            if (_formKey.currentState!.validate() &&
                                state.files['stamp'] != null &&
                                state.files['signature'] != null) {
                              final cryptPassword = Crypt.sha256(state.mpd!);
                              final newUser = User.register(
                                  firstName: state.firstname,
                                  name: state.name,
                                  password: cryptPassword.toString());
                              bool userSave =
                                  await _isarService.saveUser(newUser);
                              if (userSave) {
                                //enregistrement signature
                                bool signatureSaved = await _saveFile(newUser,
                                    state.files['signature']!, "Signature");
                                if (signatureSaved) {
                                  //enregistrement stamp
                                  bool stampSaved = await _saveFile(
                                      newUser, state.files['stamp']!, "Stamp");
                                  if (stampSaved) {
                                    context.read<RegisterBloc>().initialState();
                                    Navigator.pushNamed(context, "/connexion");
                                  }
                                }
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
                            } else {
                              if (state.files['stamp'] == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    'Veuillez ajouter votre tampon',
                                    textAlign: TextAlign.center,
                                  ),
                                  backgroundColor: Colors.red,
                                ));
                              }
                              if (state.files['signature'] == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    'Veuillez ajouter votre signature',
                                    textAlign: TextAlign.center,
                                  ),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            }
                          }),
                          child: const Text('Enregistrer'))
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _saveFile(User newUser, File file, String startPath) async {
    await Permission.storage.request();
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    final Directory directory = await getApplicationDocumentsDirectory();
    String directoryPath = directory.path;
    final String name = '${startPath}_${newUser.name}_${newUser.firstName}.png';
    String path = '$directoryPath/$name';
    String filePath = await FileSaver.instance
        .saveFile(name: name, bytes: file.readAsBytesSync(), filePath: path);
    return await File(filePath).exists();
  }
}
