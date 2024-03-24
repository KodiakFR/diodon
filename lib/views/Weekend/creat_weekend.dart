// ignore_for_file: use_build_context_synchronously

import 'package:diodon/entities/weekend.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:diodon/views/Widget/app_bar_custo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

final _formKey = GlobalKey<FormState>();

class CreateWeekend extends StatefulWidget {
  const CreateWeekend({super.key});

  @override
  State<CreateWeekend> createState() => _CreateWeekendState();
}

class _CreateWeekendState extends State<CreateWeekend> {
  final TextEditingController _controllerDate = TextEditingController();
  final TextEditingController _nbDive = TextEditingController();
  late DateTimeRange date;
  final IsarService isarService = IsarService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustoAppBar("Création d'un week end"),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 6),
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
                  controller: _controllerDate,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today_rounded),
                    labelText: 'Selectionnez la date de fin du Week-end',
                  ),
                  onTap: () async {
                    DateTimeRange? pickedDate = await showDateRangePicker(
                      context: context,
                      initialDateRange: DateTimeRange(
                          start: DateTime.now(), end: DateTime.now()),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2100),
                      keyboardType: TextInputType.datetime,
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _controllerDate.text =
                            "${DateFormat('dd/MM/yyyy').format(pickedDate.start)} - ${DateFormat('dd/MM/yyyy').format(pickedDate.end)}";
                        date = pickedDate;
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
                        final String month =
                            DateFormat.MMMM('fr').format(date.start);
                        final String tilte =
                            "Week-end du ${DateFormat('dd').format(date.start)} au ${DateFormat('dd').format(date.end)} $month ${date.start.year}";
                        Weekend weekend = Weekend()
                          ..title = tilte
                          ..nbDive = int.parse(_nbDive.text)
                          ..end = date.end
                          ..start = date.start;
                        bool isCreate = await isarService.saveWeekend(weekend);
                        if (isCreate) {
                          Weekend? weekend =
                              await isarService.getWeekendByTitle(tilte);
                          if (weekend != null) {
                            Navigator.pushNamed(context, "/addParticipants",
                                arguments: weekend);
                          }
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
                    child: const Text('Suivant'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
