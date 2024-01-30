// ignore_for_file: use_build_context_synchronously

import 'package:diodon/entities/dive.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../entities/weekend.dart';

class WeekendDetail extends StatelessWidget {
  WeekendDetail({super.key});
  final IsarService isarService = IsarService();

  @override
  Widget build(BuildContext context) {
    final weekend = ModalRoute.of(context)!.settings.arguments as Weekend;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          weekend.title,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home, size: 40),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, "/homePage", (route) => false),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Date de début: ${DateFormat('dd/MM/yyyy').format(weekend.start)}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'Date de fin: ${DateFormat('dd/MM/yyyy').format(weekend.end)}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'Nombre de plongées : ${weekend.nbDive}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'Nombre de particiapants : ${weekend.participants.length.toString()}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              "/addParticipants",
                              arguments: weekend,
                              (route) => false);
                        },
                        child:
                            const Text('Afficher la liste des participants')),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Liste des plongées',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 30,
              ),
              FutureBuilder(
                future: isarService.getAllDiveByWeekend(weekend),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (snapshot.hasData) {
                    final List<Dive> dives = snapshot.data!;
                    if (dives.isNotEmpty) {
                      return _displayDives(dives, weekend);
                    } else {
                      return const Text(
                          "Aucune plongée n'a été créé pour ce week-end");
                    }
                  }
                  return const CircularProgressIndicator();
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/createDive",
                        arguments: weekend,
                        (route) => false);
                  },
                  child: const Text('Ajouter une plongée'))
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayDives(List<Dive> dives, Weekend weekend) {
    return Flexible(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: dives.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/diveDetail",
                          arguments: dives[index],
                          (route) => false);
                    },
                    child: Text(dives[index].title),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/updateDive",
                            arguments: dives[index]);
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () async {
                        bool isDelete =
                            await isarService.deleteDive(dives[index]);
                        if (isDelete == true) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'La plongée à été supprimé',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.green,
                          ));
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              "/weekendDetail",
                              arguments: weekend,
                              (route) => false);
                        }
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
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
}
