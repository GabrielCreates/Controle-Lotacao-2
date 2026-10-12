import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/home_page.dart';
import 'theme/app_colors.dart';

void main() => runApp(const ControleLotacaoApp());

class ControleLotacaoApp extends StatelessWidget {
  const ControleLotacaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData.dark(useMaterial3: true);
    return MaterialApp(
      title: 'Controle de Lotação 2.0',
      debugShowCheckedModeBanner: false,
      theme: base.copyWith(
        scaffoldBackgroundColor: AppColors.fundo,
        colorScheme: base.colorScheme.copyWith(primary: AppColors.destaque),
        textTheme: GoogleFonts.interTextTheme(base.textTheme),
      ),
      home: const HomePage(),
    );
  }
}
