// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../entities/user.dart';

class SignaturePreviewPage extends StatelessWidget {
  final Uint8List signature;
  final User user;

  const SignaturePreviewPage(
      {super.key, required this.signature, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        title: const Text("Enregistrmeent de la signature"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => _storeSignature(context),
              icon: const Icon(Icons.done))
        ],
      ),
      body: Image.memory(signature),
    );
  }

  Future _storeSignature(BuildContext context) async {
    await Permission.storage.request();
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    final Directory directory = await getApplicationDocumentsDirectory();
    String directoryPath = directory.path;
    final String name = '${user.name}_${user.firstName}.png';
    String path = '$directoryPath/$name';
    String filePath = await FileSaver.instance
        .saveFile(name: name, bytes: signature, filePath: path);
    final bool fileExist = await File(filePath).exists();
    if (fileExist) {
      Navigator.pushNamed(context, "/connexion");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('L\'utilisateur a été sauvegardé avec succés'),
        backgroundColor: Colors.green,
      ));
    } else {
      const SnackBar(
        content: Text('La création de l\'utilisateur à échoué, veuillez rééssayer'),
        backgroundColor: Colors.red,
      );
    }
  }
}
