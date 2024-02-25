// ignore_for_file: use_build_context_synchronously

import 'package:diodon/bloc/connection_bloc.dart';
import 'package:diodon/bloc/home_bloc.dart';
import 'package:diodon/entities/weekend.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../PDF/pdf.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final IsarService isarService = IsarService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Liste des weekends',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home, size: 40),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, "/homePage", (route) => false),
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<ConnexionBloc>().logOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, "/connexion", (route) => false);
              },
              icon: const Icon(Icons.login_outlined))
        ],
      ),
      body: SafeArea(
          child: BlocBuilder<HomeBloc, Home>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FutureBuilder(
                future: isarService.getAllWeekend(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.hasData) {
                    context.read<HomeBloc>().addWeekends(snapshot.data!);
                    if (state.weekends!.isEmpty) {
                      return const Center(
                          child: Text('Aucun Weekend n\'est enregistré'));
                    }
                    return displayWeekend(state.weekends!);
                  } else {
                    return const CircleAvatar();
                  }
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/createWeekend");
                },
                child: const Text('Ajouter un weekend'),
              ),
            ],
          );
        },
      )),
    );
  }

  Widget displayWeekend(List<Weekend> weekends) {
    return Flexible(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: weekends.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/weekendDetail",
                          arguments: weekends[index]);
                    },
                    child: Text(weekends[index].title),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/updateWeekend",
                            arguments: weekends[index]);
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () async {
                        await _displayPopDelete(weekends[index], context);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                  IconButton(
                      onPressed: () async {
                        await _saveAsFile(context, weekends[index]);
                      },
                      icon: const Icon(Icons.file_open_outlined))
                ],
              ),
              const SizedBox(
                width: 100,
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _saveAsFile(BuildContext context, Weekend weekend) async {
    final bytes = await generatePdf(weekend, context);
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    await FileSaver.instance.saveAs(
        name: "Fiche de sécurité du ${weekend.title}",
        bytes: bytes,
        filePath: appDocPath,
        ext: "pdf",
        mimeType: MimeType.other);
  }

  _displayPopDelete(Weekend weekend, BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning, color: Colors.red),
            Text(
              'Suppression',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Text(
            "Voulez vous vraiment supprimer le ${weekend.title}?\nCette suppression entrainera la suprresion des plongées et des planquées existantes"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  context.read<HomeBloc>().removeWeekend(weekend);
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
