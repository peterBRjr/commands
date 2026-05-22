class ProdutoModel {
  final String id;
  final String nome;
  final double preco;
  final String? descricao;
  final String? categoria;
  final bool ativo;

  ProdutoModel({
    required this.id,
    required this.nome,
    required this.preco,
    this.descricao,
    this.categoria,
    required this.ativo,
  });

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      id: json['id'],
      nome: json['nome'],
      preco: (json['preco'] as num).toDouble(),
      descricao: json['descricao'],
      categoria: json['categoria'],
      ativo: json['ativo'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'preco': preco,
      'descricao': descricao,
      'categoria': categoria,
      'ativo': ativo,
    };
  }
}
