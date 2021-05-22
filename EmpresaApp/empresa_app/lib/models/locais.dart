class Local {
  int id;
  String nome;

  Local(this.id, this.nome);

  static void fromJson(List<dynamic> json) {
    locais.clear();
    for (var dep in json) {
      locais.add(Local(dep['id'], dep['nome']));
    }
    print('done local');
  }
}

var locais = [
  Local(1, "Sala do Café"),
  Local(2, "Praça"),
  Local(3, "Sala de Reuniões"),
  Local(4, "Sala 07"),
];
