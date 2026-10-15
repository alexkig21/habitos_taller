import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:alejandrin/main.dart'; // Mantén el nombre de tu paquete aquí

void main() {
  testWidgets('Flujo de Control de Hábitos smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verifica que inicia vacío
    expect(find.text('No hay hábitos.\nPresiona + para agregar uno.'), findsOneWidget);

    // Abre el catálogo de hábitos
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Toca el botón "Agregar" del primer hábito
    await tester.tap(find.text('Agregar').first);
    await tester.pumpAndSettle();

    // Verifica que el hábito se agregó (el contador inicia en 0)
    expect(find.text('0'), findsWidgets);

    // Incrementa el hábito (buscando el botón de sumar dentro de la tarjeta)
    await tester.tap(find.byIcon(Icons.add).last);
    await tester.pump();

    // Verifica que el contador incrementó a 1
    expect(find.text('1'), findsWidgets);
  });
}