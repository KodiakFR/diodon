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

  const SignaturePreviewPage({
    super.key,
    required this.signature,
    required this.user
  });

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
    const String directory = "/storage/emulated/0/Android/data/com.example.diodon/files";
    final String name = '${user.name}_${user.firstName}.png';
    const String subFolderName = 'signatures';
    String path = '$directory/$subFolderName/$name';
    // Créez le sous-dossier s'il n'existe pas déjà
    await Directory('$directory/$subFolderName').create();
    await FileSaver.instance
        .saveFile(name: name, bytes: signature, filePath: path);

    await File('$directory/$name').rename(path);

    final bool fileExist = await File(path).exists();
    if (fileExist) {
     Navigator.pushReplacementNamed(context, "/connexion");

      const SnackBar(
        content: Text('La signature est sauvegarder'),
        backgroundColor: Colors.green,
      );
    } else {
      const SnackBar(
        content: Text('Suvegarde de la signature à échoué, veuillez rééssayer'),
        backgroundColor: Colors.red,
      );
    }
  }
}

Future<String> get _locatePath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}
