import 'package:diodon/entities/participant.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:flutter/material.dart';

import '../../entities/dive.dart';

class DiveDetail extends StatelessWidget {
  const DiveDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dive = ModalRoute.of(context)!.settings.arguments as Dive;
    final IsarService isarService = IsarService();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          dive.title,
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
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: _recapDive(dive, context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  'Gestion des palanquées',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        FutureBuilder(
                          future: isarService.getAllDiverForDive(dive),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            if (snapshot.hasData) {
                              final List<Participant> participants =
                                  snapshot.data!;
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.7,
                                  width: double.infinity,
                                child:  Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: DataTable(
                                          columns: const <DataColumn>[
                                            DataColumn(
                                              label: Expanded(
                                                child: Text("Prénom"),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Expanded(
                                                child: Text("Nom"),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Expanded(
                                                child: Text("Niveau"),
                                              ),
                                            ),
                                          ],
                                          rows: participants.map(
                                            (participant) => DataRow(cells: [
                                            DataCell(Text(participant.firstName ?? '')),
                                            DataCell(Text(participant.name ?? '')),
                                            DataCell(Text(participant.diveLevel ?? '')),
                                          ],
                                          ),
                                          ).toList(),
                                        ),
                                  ),
                                ),
                                
                              );
                            }
                            return const CircularProgressIndicator();
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [Text('test')],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Wrap _recapDive(Dive dive, BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Date de départ: ${dive.dateDepart.day}/${dive.dateDepart.month}/${dive.dateDepart.year}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Heure de départ: ${dive.dateDepart.hour}:${dive.dateDepart.minute}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'DP : ${dive.dp}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Nombre de plongeurs : ${dive.nbDiver.toString()}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Nom du navire : ${dive.boat}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Capitaine : ${dive.captain}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Site de plongée : ${dive.divingSite}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Nombre de personnes : ${dive.nbPeople.toString()}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        )
      ],
    );
  }
}
