import 'package:flutter/material.dart';

import '../../entities/dive.dart';

class DiveDetail extends StatelessWidget {
  const DiveDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dive = ModalRoute.of(context)!.settings.arguments as Dive;
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
                padding: EdgeInsets.only(top: 20,),
                child: Wrap(
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
                    const SizedBox(height: 40,),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
