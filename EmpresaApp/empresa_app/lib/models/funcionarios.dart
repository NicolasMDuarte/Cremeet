class Funcionario {
  int id;
  String nome;
  String apelido;
  String foto;
  int idDepartamento;
  int idTime;
  int idEquipe;
  String email;
  String cel;

  Funcionario(this.id, this.nome, this.apelido, this.foto, this.idDepartamento,
      this.idTime, this.idEquipe, this.email, this.cel);

  static void fromJson(List<dynamic> json) {
    funcionarios.clear();
    for (var dep in json) {
      funcionarios.add(Funcionario(
          dep['id'],
          dep['nome'],
          dep['apelido'],
          dep['foto'],
          dep['idDepartamento'],
          dep['idTime'],
          dep['idEquipe'],
          dep['email'],
          dep['cel']));
    }
    print('done func');
  }
}

var funcionarios = [];
