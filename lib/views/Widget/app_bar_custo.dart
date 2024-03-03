import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/connection_bloc.dart';

class CustoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String namePage;
  const CustoAppBar(this.namePage, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        namePage,
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.home, size: 40),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, "/homePage", (route) => false),
        ),
        SizedBox(
          width: 20,
        ),
        IconButton(
            onPressed: () {
              context.read<ConnexionBloc>().logOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, "/connexion", (route) => false);
            },
            icon: const Icon(Icons.logout))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
