class Pessoa {
  final String nome;
  final String identificacao;
  final DateTime dataCadastro;
  final DateTime dataEntrada;
  DateTime? dataSaida;

  Pessoa({
    required this.nome,
    required this.identificacao,
    required this.dataCadastro,
    required this.dataEntrada,
    this.dataSaida,
  });

  bool get estaNoAmbiente => dataSaida == null;

  String get situacao => estaNoAmbiente ? 'No ambiente' : 'Saiu';

  void registrarSaida() {
    if (estaNoAmbiente) {
      dataSaida = DateTime.now();
    }
  }
}
