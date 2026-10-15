import 'package:flutter/material.dart';
import '../models/habito.dart';

class HabitoCard extends StatelessWidget {
  final Habito habito;
  final VoidCallback onIncrement;

  const HabitoCard({
    super.key,
    required this.habito,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    // Lógica para el reto opcional: barra de progreso y cambio de estilo[cite: 3]
    final double progreso = (habito.contador / habito.meta).clamp(0.0, 1.0);
    final bool metaAlcanzada = habito.contador >= habito.meta;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      // Cambia de color al llegar a la meta[cite: 3]
      color: metaAlcanzada ? Colors.green.shade50 : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: metaAlcanzada ? Colors.green : Colors.deepPurple,
                      child: Icon(habito.icono, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          habito.nombre,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Meta diaria: ${habito.meta}',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '${habito.contador}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: onIncrement,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                        backgroundColor: metaAlcanzada ? Colors.green : Colors.deepPurple,
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progreso,
              backgroundColor: Colors.grey.shade200,
              color: metaAlcanzada ? Colors.green : Colors.deepPurple,
              minHeight: 8,
              borderRadius: BorderRadius.circular(10),
            )
          ],
        ),
      ),
    );
  }
}
