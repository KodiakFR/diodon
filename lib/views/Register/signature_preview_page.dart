import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
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
              onPressed: () => storeSignature(context),
              icon: const Icon(Icons.done))
        ],
      ),
      body: Image.memory(signature),
    );
  }

  Future storeSignature(BuildContext context) async {
    print('ke suis la');
    await Permission.storage.request();
    final status = await Permission.storage.status;
    print('débug staut : ' + status.name);
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    const name = 'signature.png';
    final result = await ImageGallerySaver.saveImage(signature, name: name);
    final isSuccess = result['isSuccess'];
    if (isSuccess) {
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
