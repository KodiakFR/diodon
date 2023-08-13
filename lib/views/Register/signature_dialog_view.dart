import 'dart:typed_data';

import 'package:diodon/views/Register/signature_preview_page.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureDialog extends StatefulWidget {
  const SignatureDialog({super.key});

  @override
  State<SignatureDialog> createState() => _SignatureDialogState();
}

class _SignatureDialogState extends State<SignatureDialog> {
  late SignatureController controller;

  @override
  void initState() {
    super.initState();
    controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Signature'),
          backgroundColor: Colors.orange,
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: Signature(
                controller: controller,
                backgroundColor: const Color.fromARGB(255, 254, 228, 151)),
          ),
          Container(
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () async {
                    if (controller.isNotEmpty) {
                      final signature = await exportSignature();

                      await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            SignaturePreviewPage(signature: signature),
                      ));
                    }
                  },
                  icon: const Icon(Icons.check),
                  color: Colors.green,
                ),
                IconButton(
                  onPressed: () => controller.clear(),
                  icon: const Icon(Icons.cancel),
                  color: Colors.red,
                ),
              ],
            ),
          )
        ]),
      );

  Future<Uint8List> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      exportBackgroundColor: Colors.white,
      exportPenColor: Colors.black,
      points: controller.points,
    );
    final signature = await exportController.toPngBytes();
    exportController.dispose();
    return signature!;
  }
}
