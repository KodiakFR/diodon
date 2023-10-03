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
      body: SafeArea(child: Center(),),
    );
  }
}