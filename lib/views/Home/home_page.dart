import 'package:diodon/bloc/user_bloc.dart';
import 'package:diodon/entities/weekend.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entities/user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final IsarService isarService = IsarService();

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
        ),
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FutureBuilder(
              future: isarService.getAllWeekend(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.hasData) {
                  List<Weekend> weekends = snapshot.data!;
                  if (weekends.isEmpty) {
                    return const Center(
                        child: Text('Aucun Weekend n\'est enregistré'));
                  }
                  return displayWeekend(weekends);
                } else {
                  return const CircleAvatar();
                }
              },
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Ajouter un weekend'))
          ],
        )));
  }
  Widget displayWeekend(List<Weekend> weekends) {
    return Flexible(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: weekends.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text(weekends[index].title),
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
