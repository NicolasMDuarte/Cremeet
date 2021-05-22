class Time {
  int id;
  String nome;

  Time(this.id, this.nome);

  static void fromJson(List<dynamic> json) {
    times.clear();
    for (var dep in json) {
      times.add(Time(dep['id'], dep['nome']));
    }
    print('done times');
  }
}

var times = [
  Time(1, "Fix-it"),
  Time(2, "Programação"),
  Time(3, "Propaganda no Instagram"),
  Time(4, "FAQ"),
];
