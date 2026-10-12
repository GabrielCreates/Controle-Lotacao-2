
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:controle_lotacao/main.dart';

void main() {
  testWidgets('Aplicativo de controle de lotação abre corretamente',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ControleLotacaoApp());

    expect(find.byType(ControleLotacaoApp), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
