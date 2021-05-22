class Equipe {
  int id;
  String nome;

  Equipe(this.id, this.nome);

  static void fromJson(List<dynamic> json) {
    equipes.clear();
    for (var dep in json) {
      equipes.add(Equipe(dep['id'], dep['nome']));
    }
    print('done equipe');
  }
}

var equipes = [
  Equipe(1, "Manhã"),
  Equipe(2, "Tarde"),
  Equipe(3, "Noite"),
  Equipe(4, "Finais de semana"),
];
