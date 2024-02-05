import 'package:diodon/entities/dive.dart';
import 'package:diodon/entities/dive_group.dart';
import 'package:diodon/entities/participant.dart';
import 'package:diodon/entities/weekend.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

final isarService = IsarService();

Future<Uint8List> generatePdf(Weekend weekend) async {
  final pdf = pw.Document(title: "Feuille de sécurité");
  final List<Dive> dives = await isarService.getAllDiveByWeekend(weekend);

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
          diveGroup.id.toString()
        ];
        participantTable.add(participantRow);
      }
    }
    pdf.addPage(
      pw.MultiPage(
          orientation: pw.PageOrientation.landscape,
          build: (pw.Context context) => [
                pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
                    _headerPdf(dive),
                    pw.ListView.builder(
                        itemCount: diveGroups.length,
                        itemBuilder: (context, index) {
                          return pw.Padding(
                            padding: const pw.EdgeInsets.only(bottom: 20),
                            child: pw.Column(children: [
                              pw.Table(border: pw.TableBorder.all(), children: [
                                pw.TableRow(
                                  children: [
                                    pw.Text('${diveGroups[index].title}'),
                                    pw.Text(diveGroups[index].standAlone == true
                                        ? "Autonome"
                                        : "Encadrée"),
                                    pw.Text(
                                        "Heure imm: ${DateFormat('HH:mm').format(diveGroups[index].hourImmersion!)}"),
                                    pw.Text(
                                        "Heure imm: ${DateFormat('HH:mm').format(diveGroups[index].riseHour!)}"),
                                  ],
                                ),
                                pw.TableRow(
                                  children: [
                                    pw.Text(
                                        'Consignes DP | Prof: ${diveGroups[index].dpDeep}m - Temps: ${diveGroups[index].dpTime} min'),
                                    pw.Text(
                                        'Réalisé | Prof: ${diveGroups[index].realDeep}m - Temps: ${diveGroups[index].realTime} min'),
                                    pw.Text(
                                        "Palier : ${diveGroups[index].divingStop}")
                                  ],
                                ),
                              ]),
                              _tableParticicpant(
                                  diveGroups[index], participantTable),
                            ]),
                          );
                        }),
                  ],
                ),
              ]),
    );
  }
  return pdf.save();
}

_tableParticicpant(DiveGroup diveGroup, List<List<String>> participantTable) {
  List<List<String>> participantsDiveGroup = [];
  for (var participant in participantTable) {
    if (diveGroup.id.toString() == participant[2]) {
      participantsDiveGroup.add(participant);
    }
  }
  return pw.TableHelper.fromTextArray(data: participantsDiveGroup);
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
