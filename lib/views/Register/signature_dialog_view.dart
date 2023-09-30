// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:diodon/views/Register/signature_preview_page.dart';
import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';
import 'package:flutter/services.dart';

import '../../entities/user.dart';

class SignatureDialog extends StatefulWidget {
  const SignatureDialog({super.key});

  @override
  State<SignatureDialog> createState() => _SignatureDialogState();
}

class _SignatureDialogState extends State<SignatureDialog> {
  HandSignatureControl control = HandSignatureControl(
    threshold: 0.01,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signature'),
        backgroundColor: Colors.orange,
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: Stack(children: [
            Container(
              constraints: const BoxConstraints.expand(),
              color: Colors.white,
              child: HandSignature(
                control: control,
                type: SignatureDrawType.shape,
              ),
            ),
            CustomPaint(
              painter: DebugSignaturePainterCP(
                control: control,
                cp: false,
                cpStart: false,
                cpEnd: false,
              ),
            ),
          ]),
        ),
        Container(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () async {
                  final signature = await exportSignature();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SignaturePreviewPage(signature: signature, user: user),
                  ));
                },
                icon: const Icon(Icons.check),
                color: Colors.green,
              ),
              IconButton(
                onPressed: () {
                  control.clear();
                },
                icon: const Icon(Icons.cancel),
                color: Colors.red,
              ),
            ],
          ),
        )
      ]),
    );
  }

  Future<Uint8List> exportSignature() async {
    final exportController = await control.toImage(
      color: Colors.black,
      background: Colors.white,
      fit: false,
    );

    final signature = Uint8List.view(exportController!.buffer);

    return signature;
  }
}
