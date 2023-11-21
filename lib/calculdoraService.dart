import 'package:http/http.dart' as http;
import 'dart:convert';

class Medicamento {
  final int id;
  final String nome;

  const Medicamento({required this.id, required this.nome});

  factory Medicamento.fromJson(Map<String, dynamic> json) {
    return Medicamento(id: json['id'], nome: json['nome']);
  }
}

class Via {
  final int id;
  final String nome;

  const Via({required this.id, required this.nome});

  factory Via.fromJson(Map<String, dynamic> json) {
    return Via(id: json['id'], nome: json['nome']);
  }
}

class Acesso {
  final int id;
  final String nome;

  const Acesso({required this.id, required this.nome});

  factory Acesso.fromJson(Map<String, dynamic> json) {
    return Acesso(id: json['id'], nome: json['nome']);
  }
}

class Apresentacao {
  final int id;
  final String laboratorio;
  final String marca;
  final String qtdApresentacao;

  const Apresentacao(
      {required this.id,
      required this.laboratorio,
      required this.marca,
      required this.qtdApresentacao});

  factory Apresentacao.fromJson(Map<String, dynamic> json) {
    return Apresentacao(
        id: json['id'],
        laboratorio: json['laboratorio']['nome'],
        marca: json['marca']['nome'],
        qtdApresentacao: json['qtd_apresentacao']);
  }
}

class CalculadoraService {
  final base_url = 'https://api.jkist.com.br';

  Future<List<Medicamento>> getMedicamentos() async {
    final response = await http.get(Uri.parse('$base_url/medicamento/all'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<Medicamento> medicamentos = [];

      for (var medicamento in data) {
        final entrada = medicamento;
        medicamentos.add(Medicamento.fromJson(entrada));
      }
      return medicamentos;
    } else {
      throw Exception('Falha ao buscar medicamentos.');
    }
  }

  Future<List<Apresentacao>> getApresentacaos(idMedicamento) async {
    final response = await http
        .get(Uri.parse('$base_url/apresentacao?idMedicamento=$idMedicamento'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<Apresentacao> apresentacao = [];

      for (var medicamento in data) {
        final entrada = medicamento;
        apresentacao.add(Apresentacao.fromJson(entrada));
      }
      return apresentacao;
    } else {
      throw Exception('Falha ao buscar apresentações.');
    }
  }

  Future<List<Via>> getVias() async {
    final response = await http.get(Uri.parse('$base_url/via/all'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<Via> via = [];

      for (var medicamento in data) {
        final entrada = medicamento;
        via.add(Via.fromJson(entrada));
      }
      return via;
    } else {
      throw Exception('Falha ao buscar vias.');
    }
  }

  Future<List<Acesso>> getAcessos() async {
    final response = await http.get(Uri.parse('$base_url/acesso/all'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<Acesso> acesso = [];

      for (var medicamento in data) {
        final entrada = medicamento;
        acesso.add(Acesso.fromJson(entrada));
      }
      return acesso;
    } else {
      throw Exception('Falha ao buscar acessos.');
    }
  }
}
