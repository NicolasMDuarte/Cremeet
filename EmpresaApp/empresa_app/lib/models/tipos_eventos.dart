class TiposEventos {
  int id;
  String nome;

  TiposEventos(this.id, this.nome);

  static void fromJson(List<dynamic> json) {
    eventos.clear();
    for (var dep in json) {
      eventos.add(TiposEventos(dep['id'], dep['nome']));
    }
    print('done tipos');
  }
}

var eventos = [
  TiposEventos(1, "Reunião"),
  TiposEventos(2, "Mini curso"),
  TiposEventos(3, "Palestra"),
  TiposEventos(4, "Apresentação"),
];
