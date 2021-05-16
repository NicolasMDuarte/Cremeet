import 'package:empresa_app/models/departamentos.dart';
import 'package:empresa_app/models/equipes.dart';
import 'package:empresa_app/models/eventos.dart';
import 'package:empresa_app/models/funcionarios.dart';
import 'package:empresa_app/models/times.dart';
import 'package:empresa_app/screens/my_home_page.dart';

class Bridge {
  static var valueDep = [];
  static var valueFunc = [];
  static var valueEq = [];
  static var valueTim = [];
  static var organizador;
  static var evento;
  static var local;
  static var data;
  static var horario;
  static var eventoParaEditar;

  static void addEvento() {
    Evento evento = _criarEvento();

    eventos.add(evento);
    eventoSelecionado.add([evento.id, false]);

    valueDep = null;
    valueFunc = null;
    valueEq = null;
    valueTim = null;
    organizador = null;
    evento = null;
    local = null;
    data = null;
    horario = null;
  }

  static void putEvento() {
    Evento evento = _criarEvento();

    _excluirEvento();
    eventos.add(evento);
    eventoSelecionado.add([evento.id, false]);

    valueDep = null;
    valueFunc = null;
    valueEq = null;
    valueTim = null;
    organizador = null;
    evento = null;
    local = null;
    data = null;
    horario = null;
  }

  static String stringify() {
    return "$evento $local $data $horario $organizador $valueDep $valueFunc $valueEq $valueTim";
  }

  static String findDepartment(int id) {
    for (var item in departamentos) {
      if (item.id == id) return item.nome;
    }
    return "Nenhum";
  }

  static Evento _criarEvento() {
    var maiorId = 0;
    for (var item in eventos) {
      if (item.id > maiorId) maiorId = item.id;
    }
    var id = maiorId + 1;
    var idOrg;
    for (var item in funcionarios) {
      if (Bridge.organizador == item.nome) {
        idOrg = item.id;
        break;
      }
    }
    var deps = [];
    for (int i = 0; i < valueDep.length; i++) {
      if (valueDep[i] == true) {
        var dep;
        for (var item in departamentos) {
          if (item.id == i + 1) {
            dep = item.nome;
            break;
          }
        }
        deps.add(dep);
      }
    }
    var eqs = [];
    for (int i = 0; i < valueEq.length; i++) {
      if (valueEq[i] == true) {
        var eq;
        for (var item in equipes) {
          if (item.id == i + 1) {
            eq = item.nome;
            break;
          }
        }
        eqs.add(eq);
      }
    }
    var tms = [];
    for (int i = 0; i < valueTim.length; i++) {
      if (valueTim[i] == true) {
        var tm;
        for (var item in times) {
          if (item.id == i + 1) {
            tm = item.nome;
            break;
          }
        }
        tms.add(tm);
      }
    }
    var funs = [];
    for (int i = 0; i < valueFunc.length; i++) {
      if (valueFunc[i] == true) {
        var fun;
        for (var item in funcionarios) {
          if (item.id == i + 1) {
            fun = item.id;
            break;
          }
        }
        funs.add(fun);
      }
    }
    return evento = new Evento(id, idOrg, Bridge.evento, Bridge.local,
        Bridge.data, Bridge.horario, deps, eqs, tms, funs);
  }

  static void _excluirEvento() {
    for (int i = 0; i < eventoSelecionado.length; i++) {
      if (eventoSelecionado[i][1] == true) {
        for (var j = 0; j < eventos.length; j++) {
          if (eventoSelecionado[i][0] == eventos[j].id) eventos.removeAt(j);
        }
        eventoSelecionado[i] = [0, false];
      }
    }
  }
}
