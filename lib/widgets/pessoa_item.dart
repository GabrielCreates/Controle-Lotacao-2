import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/pessoa.dart';
import '../theme/app_colors.dart';

class PessoaItem extends StatelessWidget {
  final Pessoa pessoa;
  final VoidCallback onSaida;
  final VoidCallback onExcluir;

  const PessoaItem({
    super.key,
    required this.pessoa,
    required this.onSaida,
    required this.onExcluir,
  });

  static final DateFormat _formato = DateFormat('dd/MM/yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    final presente = pessoa.estaNoAmbiente;
    final detalhe = GoogleFonts.inter(
      color: AppColors.textoSecundario,
      fontSize: 13,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Slidable(
        key: ValueKey(pessoa.identificacao),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.55,
          children: [
            SlidableAction(
              onPressed: (_) => onSaida(),
              backgroundColor: AppColors.destaque,
              foregroundColor: Colors.white,
              icon: Icons.logout,
              label: 'SAÍDA',
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(12)),
            ),
            SlidableAction(
              onPressed: (_) => onExcluir(),
              backgroundColor: AppColors.erro,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'EXCLUIR',
              borderRadius:
                  const BorderRadius.horizontal(right: Radius.circular(12)),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.superficie,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                presente ? Icons.fitness_center : Icons.directions_walk,
                color: presente ? AppColors.destaque : AppColors.neutro,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pessoa.nome,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.oswald(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('ID: ${pessoa.identificacao}', style: detalhe),
                    Text(
                      'Cadastro: ${_formato.format(pessoa.dataCadastro)}',
                      style: detalhe,
                    ),
                    Text(
                      'Entrada: ${_formato.format(pessoa.dataEntrada)}',
                      style: detalhe,
                    ),
                    if (pessoa.dataSaida != null)
                      Text(
                        'Saída: ${_formato.format(pessoa.dataSaida!)}',
                        style: detalhe,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: presente ? AppColors.sucesso : AppColors.neutro,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  pessoa.situacao,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
