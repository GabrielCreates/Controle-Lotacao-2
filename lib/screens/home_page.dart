import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/pessoa.dart';
import '../theme/app_colors.dart';
import '../widgets/pessoa_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Capacidade da Academia definida no Checkpoint 01.
  static const int capacidadeMaxima = 30;

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final List<Pessoa> _pessoas = [];

  int get _presentes => _pessoas.where((p) => p.estaNoAmbiente).length;

  @override
  void dispose() {
    _nomeController.dispose();
    _idController.dispose();
    super.dispose();
  }

  void _mostrarMensagem(String texto, {Color cor = AppColors.sucesso}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(texto, style: const TextStyle(color: Colors.white)),
          backgroundColor: cor,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _cadastrar() {
    final nome = _nomeController.text.trim();
    final identificacao = _idController.text.trim();

    if (nome.isEmpty || identificacao.isEmpty) {
      _mostrarMensagem('Preencha o nome e a identificação.',
          cor: AppColors.erro);
      return;
    }

    final duplicada = _pessoas.any(
      (p) => p.identificacao.toLowerCase() == identificacao.toLowerCase(),
    );
    if (duplicada) {
      _mostrarMensagem('Identificação já utilizada.', cor: AppColors.erro);
      return;
    }

    if (_presentes >= capacidadeMaxima) {
      _mostrarMensagem(
        'Ambiente lotado! Não é possível registrar uma nova entrada.',
        cor: AppColors.erro,
      );
      return;
    }

    final agora = DateTime.now();
    setState(() {
      _pessoas.insert(
        0,
        Pessoa(
          nome: nome,
          identificacao: identificacao,
          dataCadastro: agora,
          dataEntrada: agora,
        ),
      );
    });
    _nomeController.clear();
    _idController.clear();
    FocusScope.of(context).unfocus();
    _mostrarMensagem('Pessoa cadastrada com sucesso!');
  }

  Future<void> _registrarSaida(Pessoa pessoa) async {
    if (!pessoa.estaNoAmbiente) {
      _mostrarMensagem('${pessoa.nome} já registrou a saída.',
          cor: AppColors.erro);
      return;
    }

    final confirmou = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Registrar saída?'),
        content: Text('Deseja realmente registrar a saída de ${pessoa.nome}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('CANCELAR'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('CONFIRMAR'),
          ),
        ],
      ),
    );

    if (!mounted) return;
    if (confirmou != true) {
      _mostrarMensagem('Operação cancelada.', cor: AppColors.neutro);
      return;
    }
    // Revalida: o estado pode ter mudado enquanto o diálogo estava aberto.
    if (!pessoa.estaNoAmbiente) return;

    setState(pessoa.registrarSaida);
    _mostrarMensagem('Saída registrada com sucesso!');
  }

  void _excluir(Pessoa pessoa) {
    setState(() => _pessoas.remove(pessoa));
    _mostrarMensagem('Registro excluído com sucesso!');
  }

  InputDecoration _decoracao(String rotulo, IconData icone) {
    return InputDecoration(
      labelText: rotulo,
      prefixIcon: Icon(icone),
      filled: true,
      fillColor: AppColors.superficie,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _cabecalho() {
    return Row(
      children: [
        const Icon(Icons.fitness_center, color: AppColors.destaque, size: 32),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CONTROLE DE LOTAÇÃO DE ACADEMIA',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.oswald(fontSize: 20, color: Colors.white),
              ),
              Text(
                'Academia • Gerenciamento de acessos',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.textoSecundario,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _contador(bool lotado) {
    final cor = lotado ? AppColors.erro : AppColors.destaque;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.superficie,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.groups, color: cor),
              const SizedBox(width: 8),
              Text(
                'Pessoas no ambiente',
                style: GoogleFonts.inter(color: AppColors.textoSecundario),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '$_presentes / $capacidadeMaxima',
            style: GoogleFonts.oswald(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: lotado ? AppColors.erro : Colors.white,
            ),
          ),
          if (lotado)
            Text(
              'Ambiente lotado!',
              style: GoogleFonts.inter(
                color: AppColors.erro,
                fontWeight: FontWeight.w600,
              ),
            ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _presentes / capacidadeMaxima,
            color: cor,
            backgroundColor: AppColors.neutro,
          ),
        ],
      ),
    );
  }

  Widget _formulario() {
    return Column(
      children: [
        TextField(
          controller: _nomeController,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          decoration: _decoracao('Nome', Icons.person),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _idController,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _cadastrar(),
          decoration: _decoracao('Identificação / matrícula', Icons.badge),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: _cadastrar,
            icon: const Icon(Icons.login),
            label: Text(
              'CADASTRAR ENTRADA',
              style: GoogleFonts.oswald(fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.destaque,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _lista() {
    if (_pessoas.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.fitness_center,
                size: 48, color: AppColors.neutro),
            const SizedBox(height: 8),
            Text(
              'Nenhuma pessoa cadastrada.',
              style: GoogleFonts.inter(color: AppColors.textoSecundario),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: _pessoas.length,
      itemBuilder: (context, index) {
        final pessoa = _pessoas[index];
        return PessoaItem(
          pessoa: pessoa,
          onSaida: () => _registrarSaida(pessoa),
          onExcluir: () => _excluir(pessoa),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final lotado = _presentes >= capacidadeMaxima;

    return Scaffold(
      // Evita overflow do Column quando o teclado abre.
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _cabecalho(),
              const SizedBox(height: 16),
              _contador(lotado),
              const SizedBox(height: 16),
              _formulario(),
              const SizedBox(height: 16),
              Expanded(child: _lista()),
            ],
          ),
        ),
      ),
    );
  }
}
