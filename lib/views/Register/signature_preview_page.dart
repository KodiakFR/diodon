import 'dart:io';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SignaturePreviewPage extends StatelessWidget {
  final Uint8List signature;

  const SignaturePreviewPage({
    super.key,
    required this.signature,
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

  /// This method stores a signature as an image file in the file system.
  ///
  /// It first requests storage permission if not already granted, and then saves the signature
  /// in the specified directory.
  ///
  /// [context]: The application's context.
  ///
  /// Example Usage:
  ///
  /// ```dart
  /// await storeSignature(context);
  /// ```
  Future _storeSignature(BuildContext context) async {
    await Permission.storage.request();
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    final String directory = await _locatePath;
    const String directory2 = "/storage/emulated/0/Android/data/com.example.diodon/files";
    const String name = 'signature.png';
    const String subFolderName = 'signatures';
    String path = '$directory2/$subFolderName/$name';
    // Créez le sous-dossier s'il n'existe pas déjà
    await Directory('$directory2/$subFolderName').create();
    await FileSaver.instance
        .saveFile(name: name, bytes: signature, filePath: path);

    await File('$directory2/$name').rename(path);

    final bool fileExist = await File(path).exists();
    if (fileExist) {
     Navigator.pop(context);

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
