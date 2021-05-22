class Departamento {
  int id;
  String nome;

  Departamento(this.id, this.nome);

  static void fromJson(List<dynamic> json) {
    departamentos.clear();
    for (var dep in json) {
      departamentos.add(Departamento(dep['id'], dep['nome']));
    }
    print('done dep');
  }
}

var departamentos = [
  Departamento(1, "Informática"),
  Departamento(2, "Qualidade"),
  Departamento(3, "Marketing"),
  Departamento(4, "Atendimento ao consumidor"),
];
