class Contato {
  final int? id;
  final String nome;
  final String telefone;
  final String email;

  Contato(
      {this.id,
      required this.nome,
      required this.telefone,
      required this.email});

  factory Contato.fromMap(Map<String, dynamic> json) {
    return Contato(
      id: json['id'],
      nome: json['nome'],
      telefone: json['telefone'],
      email: json['email'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'email': email,
    };
  }
}
