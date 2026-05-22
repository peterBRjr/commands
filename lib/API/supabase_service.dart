import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/comanda.dart';
import '../data/cliente.dart';
import '../data/produto.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  final SupabaseClient _client = Supabase.instance.client;

  // Obter cliente por ID
  Future<ClienteModel?> getClienteById(String id) async {
    try {
      final response = await _client
          .from('clientes')
          .select()
          .eq('id', id)
          .maybeSingle();

      if (response == null) return null;
      return ClienteModel.fromJson(response);
    } catch (e) {
      debugPrint('Erro ao buscar cliente: $e');
      return null;
    }
  }

  // Obter comanda por código QR
  Future<ComandaModel?> getComandaByQr(String qrCode) async {
    try {
      final response = await _client
          .from('comandas')
          .select()
          .eq('codigo_qr', qrCode)
          .maybeSingle();

      if (response == null) return null;
      return ComandaModel.fromJson(response);
    } catch (e) {
      debugPrint('Erro ao buscar comanda por QR: $e');
      return null;
    }
  }

  // Obter lista de produtos ativos
  Future<List<ProdutoModel>> getProdutos() async {
    try {
      final response = await _client
          .from('produtos')
          .select()
          .eq('ativo', true)
          .order('nome', ascending: true);

      return (response as List)
          .map((item) => ProdutoModel.fromJson(item))
          .toList();
    } catch (e) {
      debugPrint('Erro ao buscar produtos: $e');
      return [];
    }
  }

  // Atualizar itens consumidos e valor atual da comanda
  Future<bool> atualizarConsumoComanda(
      String comandaId, List<String> itensConsumidos, double valorAtual) async {
    try {
      await _client.from('comandas').update({
        'itens_consumidos': itensConsumidos,
        'valor_atual': valorAtual,
      }).eq('id', comandaId);
      return true;
    } catch (e) {
      debugPrint('Erro ao atualizar consumo da comanda: $e');
      return false;
    }
  }

  // Abrir/Ativar comanda para um cliente
  Future<bool> ativarComanda(String comandaId, String clienteId) async {
    try {
      await _client.from('comandas').update({
        'cliente_id': clienteId,
        'status': 'Ativa',
        'valor_atual': 0.0,
        'itens_consumidos': [],
      }).eq('id', comandaId);
      return true;
    } catch (e) {
      debugPrint('Erro ao ativar comanda: $e');
      return false;
    }
  }
}
