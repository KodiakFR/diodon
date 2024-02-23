// ignore_for_file: use_build_context_synchronously

import 'package:diodon/entities/weekend.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

final _formKey = GlobalKey<FormState>();

class UpdateWeekend extends StatefulWidget {
  const UpdateWeekend({super.key});

  @override
  State<UpdateWeekend> createState() => _UpdateWeekend();
}

class _UpdateWeekend extends State<UpdateWeekend> {
  final TextEditingController _controllerStart = TextEditingController();
  final TextEditingController _controllerEnd = TextEditingController();
  final TextEditingController _nbDive = TextEditingController();
  late DateTime startDate;
  late DateTime endDate;
  final IsarService isarService = IsarService();
  @override
  Widget build(BuildContext context) {
    final weekend = ModalRoute.of(context)!.settings.arguments as Weekend;
    _nbDive.text = weekend.nbDive.toString();
    _controllerStart.text = DateFormat('dd/MM/yyyy').format(weekend.start);
    _controllerEnd.text = DateFormat('dd/MM/yyyy').format(weekend.end);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Modification du ${weekend.title}",
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.home, size: 40),
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, "/homePage", (route) => false),
            ),
          ]),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  controller: _nbDive,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration:
                      const InputDecoration(labelText: 'Nombre de plongées'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le champs est obligatoire';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerStart,
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
                        _controllerStart.text =
                            DateFormat('dd/MM/yyyy').format(pickedDate);
                      });
                    }
                  },
                  validator: (value) {
                    return valideStartDate(value);
                  },
                ),
                TextFormField(
                  controller: _controllerEnd,
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
                        _controllerEnd.text =
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
                        await initializeDateFormatting('fr');
                        Weekend updateweekend = Weekend()
                          ..id = weekend.id
                          ..title = weekend.title
                          ..nbDive = int.parse(_nbDive.text)
                          ..end = endDate
                          ..start = startDate;
                        bool isUpdate =
                            await isarService.updateWeekend(updateweekend);
                        if (isUpdate) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/homePage", (route) => false);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Un Weekend avec le même nom existe déjà',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }
                    }),
                    child: const Text('Enregistrer'))
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
      startDate = DateTime(yearStart, monthStart, dayStart);
      if (startDate.isBefore(DateTime.now())) {
        return 'La date ne peut pas être antérieure à la date du jour';
      }
      if (_controllerEnd.text.isNotEmpty) {
        int dayEnd = int.parse(_controllerEnd.text.substring(0, 2));
        int monthEnd = int.parse(_controllerEnd.text.substring(3, 5));
        int yearEnd = int.parse(_controllerEnd.text.substring(6, 10));
        endDate = DateTime(yearEnd, monthEnd, dayEnd);
        if (startDate.isAfter(endDate)) {
          return 'La date de début du Weekend est supérieure à la date de fin';
        }
      }
    }
    return null;
  }
}
