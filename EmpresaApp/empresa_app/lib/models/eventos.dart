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
}

var eventos = [];
