import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CriarEvento extends StatefulWidget {
  @override
  _CriarEventoState createState() => _CriarEventoState();
}

class _CriarEventoState extends State<CriarEvento> {
  var horario;
  var data;

  Future<Null> _horario(BuildContext context) async{
    var selectedDate;
        final DateTime picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101));
  if (picked != null)
    setState(() {
      selectedDate = picked;
      _dateController.text = DateFormat.yMd().format(selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  child: Text("Criar Evento",
                      style: GoogleFonts.lato(
                          fontSize: 40, fontStyle: FontStyle.italic)),
                  margin: EdgeInsets.only(top: 40, bottom: 20),
                  alignment: Alignment.center,
                ),
                DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        labelText: "Selecione o organizador do evento"),
                    onChanged: (String dono) {
                      setState(() {});
                    },
                    items: ["Fun1", "Fun2", "Fun3"]
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList()),
                DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        labelText: "Selecione o tipo de evento"),
                    onChanged: (String tipo) {
                      setState(() {});
                    },
                    items: [
                      "Reunião",
                      "Mini Curso",
                      "Palestra",
                      "Apresentação",
                      "Teste de Produto"
                    ]
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList()),
                DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        labelText: "Selecione o local da reunião"),
                    onChanged: (String local) {
                      setState(() {});
                    },
                    items: [
                      "Sala do Café",
                      "Sala 7",
                      "Jardim de Inverno",
                      "Praça das Américas"
                    ]
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList()),
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () => {
                                horario = await showTimePicker(
                                context: context,
                                initialTime: selectedTime,
                              );
                            }, child: Text("Data")),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () => {}, child: Text("Hora")))
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  margin: EdgeInsets.only(top: 20),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
