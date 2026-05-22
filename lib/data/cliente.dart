class ClienteModel {
  final String id;
  final String cpf;
  final String nome;
  final DateTime? dataNascimento;
  final String? observacao;
  final bool ativo;

  ClienteModel({
    required this.id,
    required this.cpf,
    required this.nome,
    this.dataNascimento,
    this.observacao,
    required this.ativo,
  });

  factory ClienteModel.fromJson(Map<String, dynamic> json) {
    return ClienteModel(
      id: json['id'],
      cpf: json['cpf'],
      nome: json['nome'],
      dataNascimento: json['data_nascimento'] != null
          ? DateTime.parse(json['data_nascimento'])
          : null,
      observacao: json['observacao'],
      ativo: json['ativo'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cpf': cpf,
      'nome': nome,
      'data_nascimento': dataNascimento?.toIso8601String().split('T')[0],
      'observacao': observacao,
      'ativo': ativo,
    };
  }
}
