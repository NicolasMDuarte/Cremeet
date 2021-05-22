class Evento {
  var id;
  var idOrg;
  var tipo;
  var local;
  var data;
  var hora;
  var departamentos = [];
  var equipes = [];
  var times = [];
  var idFuncs = [];

  Evento(this.id, this.idOrg, this.tipo, this.local, this.data, this.hora,
      this.departamentos, this.equipes, this.times, this.idFuncs);

  static void fromJson(List<dynamic> json) {
    eventos.clear();
    for (var dep in json) {
      eventos.add(Evento(
          dep['id'],
          dep['idOrg'],
          dep['tipo'],
          dep['local'],
          dep['data'],
          dep['hora'],
          dep['departamentos'],
          dep['equipes'],
          dep['times'],
          dep['idFuncs']));
    }
    print('done evento');
  }

  Map<dynamic, dynamic> toJson() {
    var json = {
      'id': this.id,
      'idOrg': this.idOrg,
      'tipo': this.tipo,
      'local': this.local,
      'data': this.data,
      'hora': this.hora,
      'departamentos': this.departamentos,
      'equipes': this.equipes,
      'times': this.times,
      'idFuncs': this.idFuncs
    };

    return json;
  }
}

var eventos = [];
