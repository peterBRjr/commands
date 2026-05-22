class ComandaModel {
  final String id;
  final String clienteId;
  final String codigoQr;
  final double valorAtual;
  final double limiteCredito;
  final String status;
  final List<String> itensConsumidos;

  ComandaModel({
    required this.id,
    required this.clienteId,
    required this.codigoQr,
    required this.valorAtual,
    required this.limiteCredito,
    required this.status,
    required this.itensConsumidos,
  });

  factory ComandaModel.fromJson(Map<String, dynamic> json) {
    return ComandaModel(
      id: json['id'],
      clienteId: json['cliente_id'],
      codigoQr: json['codigo_qr'],
      valorAtual: (json['valor_atual'] as num).toDouble(),
      limiteCredito: (json['limite_credito'] as num).toDouble(),
      status: json['status'],
      itensConsumidos: json['itens_consumidos'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cliente_id': clienteId,
      'codigo_qr': codigoQr,
      'valor_atual': valorAtual,
      'limite_credito': limiteCredito,
      'status': status,
      'itens_consumidos': itensConsumidos,
    };
  }
}
