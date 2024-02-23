// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';
import 'package:diodon/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class SignaturePreviewPage extends StatelessWidget {
  final Uint8List signature;

  const SignaturePreviewPage(
      {super.key, required this.signature});

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
    final String path = (await getApplicationCacheDirectory()).path;
    File file = File('$path/newSignature.png');
    await file.writeAsBytes(signature);
    context.read<RegisterBloc>().changeFile(file, 'signature');
    Navigator.pushNamed(context, "/register");
    // final Directory directory = await getApplicationDocumentsDirectory();
    // String directoryPath = directory.path;
    // final String name = 'Signature_${user.name}_${user.firstName}.png';
    // String path = '$directoryPath/$name';
    // String filePath = await FileSaver.instance
    //     .saveFile(name: name, bytes: signature, filePath: path);
    // final bool fileExist = await File(filePath).exists();
    // if (fileExist) {
    //   Navigator.pushNamed(context, "/addStamp",arguments: user);
    // }
  }
}
