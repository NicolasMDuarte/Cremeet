import 'package:empresa_app/inter_screens/bridge.dart';
import 'package:empresa_app/models/departamentos.dart';
import 'package:empresa_app/models/equipes.dart';
import 'package:empresa_app/models/funcionarios.dart';
import 'package:empresa_app/models/times.dart';
import 'package:empresa_app/screens/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:getwidget/getwidget.dart';

var _valueDep = List.filled(departamentos.length, false);
var _valueFunc = List.filled(funcionarios.length, false);
var _valueEq = List.filled(equipes.length, false);
var _valueTim = List.filled(times.length, false);
var _valueSendEmail = false;
var _valueSendSMS = false;

var avisoFunc = Colors.white;

Future<void> finalizar(context) async {
  bool temFunc = false;
  int posOrg = -1;
  int posOrgEq = -1;
  int posOrgTim = -1;
  int posOrgDep = -1;

  for (int i = 0; i < funcionarios.length; i++) {
    if (funcionarios[i].nome == Bridge.organizador) posOrg = i;
  }

  for (int i = 0; i < times.length; i++) {
    if (times[i].id == funcionarios[posOrg].idTime) posOrgTim = i;
  }

  for (int i = 0; i < equipes.length; i++) {
    if (equipes[i].id == funcionarios[posOrg].idEquipe) posOrgEq = i;
  }

  for (int i = 0; i < departamentos.length; i++) {
    if (departamentos[i].id == funcionarios[posOrg].idDepartamento)
      posOrgDep = i;
  }

  if (_valueFunc[posOrg] == false) {
    _valueFunc[posOrg] = true;
    _valueDep[posOrgDep] = true;
    _valueEq[posOrgEq] = true;
    _valueTim[posOrgTim] = true;

    posOrg = -1;
    return;
  }

  for (var item in _valueFunc) {
    if (item == true) temFunc = true;
  }

  if (!temFunc) {
    avisoFunc = Colors.red;
  } else {
    avisoFunc = Colors.white;

    Bridge.valueDep = _valueDep;
    Bridge.valueEq = _valueEq;
    Bridge.valueTim = _valueTim;
    Bridge.valueFunc = _valueFunc;
    print(Bridge.stringify());

    List<String> receptores = [];
    int _i = 0;
    for (var item in funcionarios) {
      if (Bridge.valueFunc[_i]) {
        receptores.add(item.email);
      }
      _i++;
    }
    List<String> receptoresSMS = [];
    _i = 0;
    for (var item in funcionarios) {
      if (Bridge.valueFunc[_i]) {
        receptoresSMS.add(item.cel);
      }
      _i++;
    }

    String donoReuniao = Bridge.organizador;
    String tipoEvento = Bridge.evento;
    String dataEvento = Bridge.data;
    String horaEvento = Bridge.horario;
    String localEvento = Bridge.local;

    if (_valueSendEmail) {
      try {
        Email email = Email(
          body:
              "Você foi convidado para ${tipoEvento.toString()} em ${localEvento.toString()} às ${horaEvento.toString()} do dia ${dataEvento.toString()} por ${donoReuniao.toString()}. Não deixe de comparecer!",
          subject: "Cremeet - Nova reunião agendada",
          recipients: receptores,
          isHTML: false,
        );
        await FlutterEmailSender.send(email);
      } catch (Exception) {
        print(Exception);
      }
    }
    if (_valueSendSMS) {
      try {
        await sendSMS(
                message:
                    "Você foi convidado para ${tipoEvento.toString()} em ${localEvento.toString()} às ${horaEvento.toString()} do dia ${dataEvento.toString()} por ${donoReuniao.toString()}. Não deixe de comparecer!",
                recipients: receptoresSMS)
            .timeout(Duration(seconds: 5000));
      } catch (Exception) {
        print(Exception);
      }
    }

    Bridge.addEvento();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }
}

class SelecionarCriar extends StatefulWidget {
  @override
  _SelecionarCriarState createState() => _SelecionarCriarState();
}

class _SelecionarCriarState extends State<SelecionarCriar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Column(
            children: [
              Container(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_rounded)),
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 5, top: 15, bottom: 15),
              ),
              Container(
                child: Text("Filtros"),
              ),
              GFAccordion(
                  title: "Departamentos",
                  collapsedIcon: Icon(Icons.add),
                  expandedIcon: Icon(Icons.minimize),
                  contentChild: Column(
                      children: departamentos
                          .map(
                            (e) => CheckboxListTile(
                              title: Text(e.nome),
                              subtitle: Text('Departamento'),
                              secondary: Icon(Icons.house_rounded),
                              autofocus: false,
                              activeColor: Colors.green,
                              checkColor: Colors.white,
                              selected: _valueDep[e.id - 1],
                              value: _valueDep[e.id - 1],
                              onChanged: (bool value) {
                                setState(() {
                                  _valueDep[e.id - 1] = value;
                                  for (var item in funcionarios) {
                                    if (item.idDepartamento == e.id) {
                                      if (_valueDep[e.id - 1] == false)
                                        _valueFunc[item.id - 1] = false;
                                      else {
                                        if (_valueDep[
                                                    item.idDepartamento - 1] ==
                                                true &&
                                            _valueEq[item.idEquipe - 1] ==
                                                true &&
                                            _valueTim[item.idTime - 1] ==
                                                true) {
                                          _valueFunc[item.id - 1] = value;
                                          avisoFunc = Colors.white;
                                        }
                                      }
                                    }
                                  }
                                });
                              },
                            ),
                          )
                          .toList())),
              GFAccordion(
                  title: "Equipes",
                  collapsedIcon: Icon(Icons.add),
                  expandedIcon: Icon(Icons.minimize),
                  contentChild: Column(
                    children: equipes
                        .map((e) => CheckboxListTile(
                              title: Text(e.nome),
                              subtitle: Text('Equipes'),
                              secondary: Icon(Icons.alarm),
                              autofocus: false,
                              activeColor: Colors.green,
                              checkColor: Colors.white,
                              selected: _valueEq[e.id - 1],
                              value: _valueEq[e.id - 1],
                              onChanged: (bool value) {
                                setState(() {
                                  _valueEq[e.id - 1] = value;
                                  for (var item in funcionarios) {
                                    if (item.idEquipe == e.id) {
                                      if (_valueEq[e.id - 1] == false)
                                        _valueFunc[item.id - 1] = false;
                                      else {
                                        if (_valueDep[
                                                    item.idDepartamento - 1] ==
                                                true &&
                                            _valueEq[item.idEquipe - 1] ==
                                                true &&
                                            _valueTim[item.idTime - 1] ==
                                                true) {
                                          _valueFunc[item.id - 1] = value;
                                          avisoFunc = Colors.white;
                                        }
                                      }
                                    }
                                  }
                                });
                              },
                            ))
                        .toList(),
                  )),
              GFAccordion(
                title: "Times",
                collapsedIcon: Icon(Icons.add),
                expandedIcon: Icon(Icons.minimize),
                contentChild: Column(
                  children: times
                      .map((e) => CheckboxListTile(
                            title: Text(e.nome),
                            subtitle: Text('Times'),
                            secondary: Icon(Icons.people),
                            autofocus: false,
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                            selected: _valueTim[e.id - 1],
                            value: _valueTim[e.id - 1],
                            onChanged: (bool value) {
                              setState(() {
                                _valueTim[e.id - 1] = value;
                                for (var item in funcionarios) {
                                  if (item.idTime == e.id) {
                                    if (_valueTim[e.id - 1] == false)
                                      _valueFunc[item.id - 1] = false;
                                    else {
                                      if (_valueDep[item.idDepartamento - 1] ==
                                              true &&
                                          _valueEq[item.idEquipe - 1] == true &&
                                          _valueTim[item.idTime - 1] == true) {
                                        _valueFunc[item.id - 1] = value;
                                        avisoFunc = Colors.white;
                                      }
                                    }
                                  }
                                }
                              });
                            },
                          ))
                      .toList(),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Column(
                children: funcionarios
                    .map(
                      (e) => CheckboxListTile(
                        title: Text("${e.apelido} (${e.nome})"),
                        subtitle: Text(
                            "${Bridge.findDepartment(e.idDepartamento)} - ${Bridge.findSection(e.idEquipe)} - ${Bridge.findTeam(e.idTime)}"),
                        secondary: Image(
                          image: NetworkImage(e.foto),
                          width: 35,
                        ),
                        autofocus: false,
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                        tileColor: avisoFunc,
                        selected: _valueFunc[e.id - 1],
                        value: _valueFunc[e.id - 1],
                        onChanged: (bool value) {
                          setState(() {
                            if (_valueDep[e.idDepartamento - 1] == true &&
                                _valueEq[e.idEquipe - 1] == true &&
                                _valueTim[e.idTime - 1] == true) {
                              _valueFunc[e.id - 1] = value;
                              avisoFunc = Colors.white;
                            }
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              Divider(
                thickness: 2,
              ),
              Container(
                child: Column(
                  children: [
                    SwitchListTile(
                        title: Text("Alertar participantes"),
                        subtitle: Text("E-mail"),
                        value: _valueSendEmail,
                        onChanged: (bool value) {
                          setState(() {
                            _valueSendEmail = value;
                          });
                        }),
                    SwitchListTile(
                        title: Text("Alertar participantes"),
                        subtitle: Text("SMS"),
                        value: _valueSendSMS,
                        onChanged: (bool value) {
                          setState(() {
                            _valueSendSMS = value;
                          });
                        }),
                    Container(
                      child: ElevatedButton(
                          onPressed: () => {
                                setState(() {
                                  finalizar(context);
                                })
                              },
                          child: Text("Criar Evento")),
                      margin: EdgeInsets.only(top: 5),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
