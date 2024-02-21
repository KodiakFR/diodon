import 'dart:io';
import 'package:diodon/entities/dive.dart';
import 'package:diodon/entities/dive_group.dart';
import 'package:diodon/entities/participant.dart';
import 'package:diodon/entities/weekend.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../bloc/user_bloc.dart';

final isarService = IsarService();

Future<Uint8List> generatePdf(Weekend weekend, BuildContext context) async {
  final pdf = pw.Document(title: "Feuille de sécurité");
  final List<Dive> dives = await isarService.getAllDiveByWeekend(weekend);
  final logoImage = pw.MemoryImage(
    (await rootBundle.load('images/cropped-logo_diodon-officiel2-carre-edited.jpg')).buffer.asUint8List()
  );
  Directory? dir = await getExternalStorageDirectory();
  String dirPath = "";
  if (dir != null) {
    dirPath = dir.path;
  }
  final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
  File file = File("$dirPath/${userBloc.state.name}_${userBloc.state.firstName}.png");
  final bytes = await file.readAsBytes();
  final byteData = bytes.buffer.asUint8List();
  final signature = pw.MemoryImage(byteData);

  for (var dive in dives) {
    final List<DiveGroup> diveGroups =
        await isarService.getAllDiveGroupForDive(dive);
    List<List<String>> participantTable = [];
    for (var diveGroup in diveGroups) {
      List<Participant> participants =
          await isarService.getAllDiverForDiveGroup(diveGroup);
      for (var participant in participants) {
        List<String> participantRow = [
          participant.name!,
          participant.firstName!,
          participant.diveLevel!,
          diveGroup.id.toString()
        ];
        participantTable.add(participantRow);
      }
    }
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      orientation: pw.PageOrientation.landscape,
      build: (pw.Context context) => [
        _headerPdf(dive),
        pw.SizedBox(height: 20),
        pw.ListView.builder(
            itemCount: diveGroups.length,
            itemBuilder: (context, index) {
              return pw.Column(children: [
                pw.Text(diveGroups[index].title!,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.GridView(
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 0.25,
                    children: [
                      _tableParticicpant(diveGroups[index], participantTable),
                      _tableDive(diveGroups, index),
                    ]),
              ]);
            }),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Image(logoImage,width: 125),
            pw.Image(signature, width: 150),
          ],
        ),
      ],
    ));
  }
  return pdf.save();
}

pw.Table _tableDive(List<DiveGroup> diveGroups, int index) {
  return pw.Table(
      tableWidth: pw.TableWidth.max,
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(children: [
          pw.Text(
              " Heure imm: ${DateFormat('HH:mm').format(diveGroups[index].hourImmersion!)}"),
          pw.Text(
              " Heure sortie: ${DateFormat('HH:mm').format(diveGroups[index].riseHour!)}"),
        ]),
        pw.TableRow(
          children: [
            pw.Text(' Consignes DP'),
            pw.Text(
                " Prof: ${diveGroups[index].dpDeep}m - Temps: ${diveGroups[index].dpTime} min'"),
          ],
        ),
        pw.TableRow(children: [
          pw.Text(' Réalisé'),
          pw.Text(
              " Prof: ${diveGroups[index].realDeep}m - Temps: ${diveGroups[index].realTime} min")
        ]),
        pw.TableRow(children: [
          pw.Text(" Palier : ${diveGroups[index].divingStop}"),
          pw.Text(
              diveGroups[index].standAlone == true ? " Autonome" : " Encadrée"),
        ])
      ]);
}

pw.Table _tableParticicpant(
    DiveGroup diveGroup, List<List<String>> participantTable) {
  const tableHeaders = [
    'Nom',
    'Prénom',
    'Niveau',
  ];
  List<List<String>> participantsDiveGroup = [];
  for (var participant in participantTable) {
    if (diveGroup.id.toString() == participant[3]) {
      participantsDiveGroup.add(participant);
    }
  }
  return pw.TableHelper.fromTextArray(
    cellPadding: const pw.EdgeInsets.only(left: 3),
    tableWidth: pw.TableWidth.max,
    headers: List<String>.generate(
      tableHeaders.length,
      (col) => tableHeaders[col],
    ),
    data: List<List<String>>.generate(
      participantsDiveGroup.length,
      (row) => List<String>.generate(
        tableHeaders.length,
        (col) => participantsDiveGroup[row][col],
      ),
    ),
  );
}

pw.Widget _headerPdf(Dive dive) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
    children: [
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text("Date: ${DateFormat('dd/MM/yyyy').format(dive.dateDepart)}"),
          pw.Text("Navire: ${dive.boat}"),
          pw.Text("Pilote: ${dive.captain}"),
          pw.Text("DP: ${dive.dp}"),
          pw.Text("Sécu: "),
        ],
      ),
      pw.Column(
        children: [
          pw.Text("Feuille de sécurité",
              style: const pw.TextStyle(fontSize: 20)),
          pw.Text(
              "Total personnel embarqué: ${dive.nbPeople.toString()} dont ${dive.nbDiver} plongeurs"),
        ],
      ),
      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
        pw.Text("Site: ${dive.divingSite}"),
        pw.Text(
            "Heure de départ: ${DateFormat("HH:mm").format(dive.dateDepart)}")
      ])
    ],
  );
}
