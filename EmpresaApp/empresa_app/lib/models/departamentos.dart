class Departamento {
  int id;
  String nome;

  Departamento(this.id, this.nome);

  factory Departamento.fromJson(List<dynamic> json) {
    return Departamento(json[0]['id'], json[0]['nome']);
  }
}

var departamentos = [
  Departamento(1, "Informática"),
  Departamento(2, "Qualidade"),
  Departamento(3, "Marketing"),
  Departamento(4, "Atendimento ao consumidor"),
];
