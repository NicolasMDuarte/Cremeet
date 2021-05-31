import 'package:empresa_app/inter_screens/bridge.dart';
import 'package:empresa_app/models/eventos.dart';
import 'package:empresa_app/models/tipos_eventos.dart' as tipos_eventos;
import 'package:empresa_app/models/funcionarios.dart';
import 'package:empresa_app/models/locais.dart';
import 'package:empresa_app/screens/selecionar_editar_evento.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EditarEvento extends StatefulWidget {
  @override
  _EditarEventoState createState() => _EditarEventoState();
}

class _EditarEventoState extends State<EditarEvento> {
  var horario = "Horário";
  var data = "Data";

  Evento _eventoEdit = Bridge.eventoParaEditar;

  var avisoOrg = Colors.black54;
  var avisoEvento = Colors.black54;
  var avisoReuniao = Colors.black54;
  var avisoData = Colors.green;
  var avisoHora = Colors.green;

  Future<Null> _data(BuildContext context) async {
    var selectedDate;
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(
            int.parse(_eventoEdit.data.substring(6)),
            int.parse(_eventoEdit.data.substring(3, 5)),
            int.parse(_eventoEdit.data.substring(0, 2))),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(DateTime.now().year + 10));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        data = '';
        data += DateFormat.d().format(selectedDate).padLeft(2, '0');
        data += '/' + DateFormat.M().format(selectedDate).padLeft(2, '0');
        data += '/' + DateFormat.y().format(selectedDate);
        Bridge.data = data;
        avisoData = Colors.green;
      });
  }

  Future<Null> _hora(BuildContext context) async {
    var selectedTime;
    var hora;
    var minuto;

    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: int.parse(_eventoEdit.hora.substring(0, 2)),
          minute: int.parse(_eventoEdit.hora.substring(3))),
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        hora = selectedTime.hour.toString().padLeft(2, '0');
        minuto = selectedTime.minute.toString().padLeft(2, '0');
        horario = hora + ':' + minuto;
        Bridge.horario = horario;
        avisoHora = Colors.green;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_rounded)),
              alignment: Alignment.topLeft,
              margin: EdgeInsets.all(15),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    child: Text("Editar Evento",
                        style: GoogleFonts.lato(
                            fontSize: 40, fontStyle: FontStyle.italic)),
                    margin: EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                  ),
                  DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          labelText: "Selecione o organizador do evento",
                          labelStyle: TextStyle(color: avisoOrg)),
                      value: coletarOrg().nome,
                      onChanged: (String dono) {
                        setState(() {
                          Bridge.organizador = dono;
                          avisoOrg = Colors.black54;
                        });
                      },
                      items: funcionarios
                          .map((e) => DropdownMenuItem(
                                value: e.nome.toString(),
                                child: Text(e.nome),
                              ))
                          .toList()),
                  DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          labelText: "Selecione o tipo de evento",
                          labelStyle: TextStyle(color: avisoEvento)),
                      value: _eventoEdit.tipo,
                      onChanged: (String tipo) {
                        setState(() {
                          Bridge.evento = tipo;
                          avisoEvento = Colors.black54;
                        });
                      },
                      items: tipos_eventos.eventos
                          .map((e) => DropdownMenuItem(
                                value: e.nome,
                                child: Text(e.nome),
                              ))
                          .toList()),
                  DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          labelText: "Selecione o local da reunião",
                          labelStyle: TextStyle(color: avisoReuniao)),
                      value: _eventoEdit.local,
                      onChanged: (String local) {
                        setState(() {
                          Bridge.local = local;
                          avisoReuniao = Colors.black54;
                        });
                      },
                      items: locais
                          .map((e) => DropdownMenuItem(
                                value: e.nome,
                                child: Text(e.nome),
                              ))
                          .toList()),
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async => {_data(context)},
                            child: Text(data),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        avisoData)),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async => {_hora(context)},
                              child: Text(horario),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          avisoHora)),
                            ))
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    margin: EdgeInsets.only(top: 20),
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () => {
                        if (Bridge.data == null ||
                            Bridge.data == "" ||
                            Bridge.horario == null ||
                            Bridge.horario == "")
                          setState(() {
                            if (Bridge.data == null || Bridge.data == "")
                              avisoData = Colors.red;
                            else
                              avisoData = Colors.green;

                            if (Bridge.horario == null || Bridge.horario == "")
                              avisoHora = Colors.red;
                            else
                              avisoHora = Colors.green;
                          })
                        else
                          {
                            if (Bridge.organizador == null)
                              Bridge.organizador = coletarOrg().nome,
                            if (Bridge.evento == null)
                              Bridge.evento = _eventoEdit.tipo,
                            if (Bridge.local == null)
                              Bridge.local = _eventoEdit.local,
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SelecionarEditarEvento()))
                          }
                      },
                      child: Text("Próximo"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue)),
                    ),
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(top: 100),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Funcionario coletarOrg() {
  var idOrg = Bridge.eventoParaEditar.idOrg;
  for (var func in funcionarios) {
    if (func.id == idOrg) return func;
  }

  return null;
}
