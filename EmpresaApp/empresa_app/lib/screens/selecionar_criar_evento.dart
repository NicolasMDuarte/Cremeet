import 'package:empresa_app/inter_screens/bridge.dart';
import 'package:empresa_app/models/departamentos.dart';
import 'package:empresa_app/models/equipes.dart';
import 'package:empresa_app/models/funcionarios.dart';
import 'package:empresa_app/models/times.dart';
import 'package:empresa_app/screens/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

var _valueDep = List.filled(departamentos.length, false);
var _valueFunc = List.filled(funcionarios.length, false);
var _valueEq = List.filled(equipes.length, false);
var _valueTim = List.filled(times.length, false);

var avisoFunc = Colors.white;

void finalizar(context) {
  //bool temDep = false;
  //bool temEq = false;
  //bool temTime = false;
  bool temFunc = false;

  /*for (var item in _valueDep) {
    if (item == true) temDep = true;
  }
  for (var item in _valueEq) {
    if (item == true) temEq = true;
  }
  for (var item in _valueTim) {
    if (item == true) temTime = true;
  }*/
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
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: [
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
                                      _valueFunc[item.id - 1] = false;
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
                        subtitle: Text(Bridge.findDepartment(e.idDepartamento)),
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
                            if (_valueDep[e.idDepartamento - 1] == true) {
                              _valueFunc[e.id - 1] = value;
                              avisoFunc = Colors.white;
                            }
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              Container(
                padding: EdgeInsets.only(top: 25),
                child: ElevatedButton(
                    onPressed: () => {
                          setState(() {
                            finalizar(context);
                          })
                        },
                    child: Text("Criar Evento")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
