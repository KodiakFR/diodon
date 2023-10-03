import 'package:flutter/material.dart';

import '../../entities/weekend.dart';

class WeekendDetail extends StatelessWidget {
  const WeekendDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final weekend = ModalRoute.of(context)!.settings.arguments as Weekend;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${weekend.title}",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home, size: 40),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, "/homePage", (route) => false),
        ),
      ),
      body: SafeArea(child: Center(
        child: Column(
          children: [
           
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                 Text('Date de début: ${weekend.start.day}/${weekend.start.month}/${weekend.start.year}', style: Theme.of(context).textTheme.titleMedium,),
                 Text('Date de fin: ${weekend.end.day}/${weekend.end.month}/${weekend.end.year}', style: Theme.of(context).textTheme.titleMedium,),
                 Text('Nombre de plongées : ${weekend.nbDive}', style: Theme.of(context).textTheme.titleMedium,),
                 Text('Nombre de particiapants : ${weekend.participants.length.toString()}', style: Theme.of(context).textTheme.titleMedium,),
              ],
            ),
            const SizedBox(height: 40,),
            ElevatedButton(onPressed: (){
               Navigator.pushNamedAndRemoveUntil(context, "/addParticipants",arguments: weekend, (route) => false);
            }, child: const Text('Afficher la liste des participants')),
            const SizedBox(height: 50,)
          ],
        ),
      ),),
    );
  }
}