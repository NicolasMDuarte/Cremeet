import 'dart:math';

import 'package:empresa_app/api_connection/api_connector.dart';
import 'package:empresa_app/inter_screens/bridge.dart';
import 'package:empresa_app/models/eventos.dart';
import 'package:empresa_app/models/funcionarios.dart';
import 'package:empresa_app/screens/criar_evento.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'editar_evento.dart';

var _avisoEventos = Colors.white;
var eventoSelecionado = [];
var _temSelec = false;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loaded = false;
  var carregamentoMsg = [
    "Tirando poeira do calendário...",
    "Fazendo carinho na conexão...",
    "Passando pano no Wi-Fi...",
    "Jogando queimada com o algoritmo...",
    "Dando comida pro servidor...",
    "Dando mamadeira pros bits..."
  ];

  Future loadData() async {
    carregamentoMsg.shuffle();
    loaded = await Connector.connectGet();
  }

  @override
  void initState() {
    super.initState();

    loadData().then((data) {
      setState(() {
        eventoSelecionado.clear();
        for (var event in eventos) {
          eventoSelecionado.add([event.id, false]);
        }
        loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      loadData();
      return Scaffold(
        body: Container(
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/logo.png'),
                height: 200,
              ),
              Container(
                child: Text("Cremeet",
                    style: GoogleFonts.lato(
                        fontSize: 40, fontStyle: FontStyle.italic)),
                margin: EdgeInsets.only(top: 0, bottom: 60),
              ),
              CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
              Container(
                child: Text(
                  carregamentoMsg[Random().nextInt(carregamentoMsg.length - 1)],
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                margin: EdgeInsets.only(top: 5),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          alignment: Alignment.center,
          color: Colors.green,
        ),
      );
    } else {
      return Scaffold(
        body: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Image(
                    image: AssetImage('assets/logo.png'),
                    height: 200,
                  ),
                  Container(
                    child: Text("Cremeet",
                        style: GoogleFonts.lato(
                            fontSize: 40, fontStyle: FontStyle.italic)),
                    margin: EdgeInsets.only(top: 0, bottom: 60),
                  )
                ],
              ),
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 40),
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    'Eventos',
                    style: GoogleFonts.lato(),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CriarEvento()))
                                },
                            child: Text("Criar")),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () => {
                                  setState(() {
                                    editar(context);
                                  })
                                },
                            child: Text("Editar")),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => {
                            setState(() {
                              excluir(context);
                            })
                          },
                          child: Text("Excluir"),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: eventos
                    .map((e) => CheckboxListTile(
                          title: Text(funcionarios[e.idOrg - 1].apelido +
                              " - " +
                              e.tipo),
                          subtitle:
                              Text(e.local + " - " + e.hora + " - " + e.data),
                          secondary: Image(
                              image:
                                  NetworkImage(funcionarios[e.idOrg - 1].foto)),
                          autofocus: false,
                          activeColor: Colors.green,
                          checkColor: Colors.white,
                          tileColor: _avisoEventos,
                          selected: _selecionado(e.id),
                          value: _selecionado(e.id),
                          onChanged: (bool value) {
                            setState(() {
                              selecionaEvento(e, value);
                            });
                          },
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      );
    }
  }
}

bool _selecionado(var id) {
  for (var item in eventoSelecionado) {
    if (item[0] == id) if (item[1] == true)
      return true;
    else
      return false;
  }

  return false;
}

void selecionaEvento(var e, var value) {
  if (true) {
    for (int i = 0; i < eventoSelecionado.length; i++)
      eventoSelecionado[i][1] = false;

    for (int i = 0; i < eventoSelecionado.length; i++) {
      if (eventoSelecionado[i][0] == e.id) eventoSelecionado[i][1] = value;
    }

    _avisoEventos = Colors.white;
  }
}

void excluir(var context) {
  _temSelec = false;
  for (var item in eventoSelecionado) {
    if (item[1] == true) {
      _temSelec = true;
    }
  }
  if (_temSelec) {
    _avisoEventos = Colors.white;
    for (int i = 0; i < eventoSelecionado.length; i++) {
      if (eventoSelecionado[i][1] == true) {
        for (var j = 0; j < eventos.length; j++) {
          if (eventoSelecionado[i][0] == eventos[j].id) {
            Connector.connectDelete(eventos[j].id);
            eventos.removeAt(j);
          }
        }
        eventoSelecionado[i] = [0, false];
      }
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  } else {
    _avisoEventos = Colors.red;
  }
}

void editar(var context) {
  _temSelec = false;
  for (var item in eventoSelecionado) {
    if (item[1] == true) {
      _temSelec = true;
    }
  }
  if (_temSelec) {
    _avisoEventos = Colors.white;
    primeiro:
    for (int i = 0; i < eventoSelecionado.length; i++) {
      if (eventoSelecionado[i][1] == true) {
        for (var j = 0; j < eventos.length; j++) {
          if (eventoSelecionado[i][0] == eventos[j].id) {
            Bridge.eventoParaEditar = eventos[j];
            break primeiro;
          }
        }
        eventoSelecionado[i] = [0, false];
      }
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditarEvento()));
  } else {
    _avisoEventos = Colors.red;
  }
}
