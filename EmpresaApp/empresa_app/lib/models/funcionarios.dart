class Funcionario {
  int id;
  String nome;
  String apelido;
  String foto;
  int idDepartamento;
  int idTime;
  int idEquipe;

  Funcionario(this.id, this.nome, this.apelido, this.foto, this.idDepartamento,
      this.idTime, this.idEquipe);

  static void fromJson(List<dynamic> json) {
    funcionarios.clear();
    for (var dep in json) {
      funcionarios.add(Funcionario(dep['id'], dep['nome'], dep['apelido'],
          dep['foto'], dep['idDepartamento'], dep['idTime'], dep['idEquipe']));
    }
    print('done func');
  }
}

var funcionarios = [];
