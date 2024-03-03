// ignore_for_file: use_build_context_synchronously

import 'package:diodon/bloc/dives_bloc.dart';
import 'package:diodon/entities/dive.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:diodon/views/Widget/app_bar_custo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../entities/weekend.dart';

class WeekendDetail extends StatelessWidget {
  WeekendDetail({super.key});
  final IsarService isarService = IsarService();

  @override
  Widget build(BuildContext context) {
    final weekend = ModalRoute.of(context)!.settings.arguments as Weekend;
    return Scaffold(
      appBar: CustoAppBar(weekend.title),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 25,
                  runSpacing: 10,
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
                      'Nombre de participants : ${weekend.participants.length.toString()}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/addParticipants",
                        arguments: weekend);
                  },
                  child: const Text('Afficher la liste des participants')),
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
              BlocBuilder<DivesBloc, List<Dive>>(
                builder: (context, state) {
                  return FutureBuilder(
                    future: isarService.getAllDiveByWeekend(weekend),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      if (snapshot.hasData) {
                        context.read<DivesBloc>().initDives(snapshot.data!);
                        if (state.isNotEmpty) {
                          return _displayDives(state, weekend);
                        } else {
                          return const Text(
                              "Aucune plongée n'a été créé pour ce week-end");
                        }
                      }
                      return const CircularProgressIndicator();
                    },
                  );
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/createDive",
                        arguments: weekend);
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
                      Navigator.pushNamed(context, "/diveDetail",
                          arguments: dives[index]);
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
                        bool isDelete = await context
                            .read<DivesBloc>()
                            .deleteDive(dives[index], weekend);
                        if (isDelete == true) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'La plongée à été supprimé',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.green,
                          ));
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
