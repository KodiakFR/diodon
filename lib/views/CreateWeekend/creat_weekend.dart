import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final _formKey = GlobalKey<FormState>();

class CreateWeekend extends StatefulWidget {
  const CreateWeekend({super.key});

  @override
  State<CreateWeekend> createState() => _CreateWeekendState();
}

class _CreateWeekendState extends State<CreateWeekend> {
  final TextEditingController _dateStart = TextEditingController();
  final TextEditingController _dateEnd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Création d'un week-end",
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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Weekend du 10 - 11 Octobre 2023',
                      labelText: 'Titre du Week-end'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le champs est obligatoire';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: '4', labelText: 'Nombre de plongées'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le champs est obligatoire';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dateStart,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today_rounded),
                    labelText: 'Selectionnez la date de début du Week-end',
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _dateStart.text =
                            DateFormat('dd/MM/yyyy').format(pickedDate);
                      });
                    }
                  },
                  validator: (value) {
                    return valideStartDate(value);
                  },
                ),
                TextFormField(
                  controller: _dateEnd,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today_rounded),
                    labelText: 'Selectionnez la date de fin du Week-end',
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _dateEnd.text =
                            DateFormat('dd/MM/yyyy').format(pickedDate);
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le champs est obligatoire';
                    } 
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: (() async {
                      if (_formKey.currentState!.validate()) {
                        
                      }
                    }),
                    child: const Text('Suivant'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? valideStartDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le champs est obligatoire';
    } else {
      int dayStart = int.parse(value.substring(0, 2));
      int monthStart = int.parse(value.substring(3, 5));
      int yearStart = int.parse(value.substring(6, 10));
      DateTime start = DateTime(yearStart, monthStart, dayStart);
      if (start.isBefore(DateTime.now())) {
        return 'La date ne peut pas être antérieure à la date du jour';
      }
      if (_dateEnd.text.isNotEmpty) {
        int dayEnd = int.parse(_dateEnd.text.substring(0, 2));
        int monthEnd = int.parse(_dateEnd.text.substring(3, 5));
        int yearEnd = int.parse(_dateEnd.text.substring(6, 10));
        DateTime end = DateTime(yearEnd, monthEnd, dayEnd);
        if (start.isAfter(end)) {
          return 'La date de début du Weekend est supérieure à la date de fin';
        }
      }
    }
    return null;
  }
}
