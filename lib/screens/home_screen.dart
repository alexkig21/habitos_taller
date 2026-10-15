import 'package:flutter/material.dart';
import '../models/habito.dart';
import '../widgets/encabezado_widget.dart';
import '../widgets/habito_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Lista inicial vacía. Los hábitos se agregan dinámicamente[cite: 1]
  List<Habito> habitosActivos = [];

  // Los 6 hábitos que pediste para elegir
  final List<Habito> catalogoHabitos = [
    Habito(id: '1', nombre: 'Tomar Agua', icono: Icons.water_drop, meta: 8),
    Habito(id: '2', nombre: 'Estudiar Programación', icono: Icons.computer, meta: 3),
    Habito(id: '3', nombre: 'Hacer Ejercicio', icono: Icons.fitness_center, meta: 1),
    Habito(id: '4', nombre: 'Leer un Libro', icono: Icons.menu_book, meta: 2),
    Habito(id: '5', nombre: 'Meditar', icono: Icons.self_improvement, meta: 1),
    Habito(id: '6', nombre: 'Dormir 8 horas', icono: Icons.bed, meta: 1),
  ];

  void incrementarHabito(int index) {
    setState(() {
      habitosActivos[index].contador++; // Actualiza la interfaz[cite: 2]
    });
  }

  void reiniciarDia() {
    setState(() {
      // Como solicitaste: se quitan al darle reiniciar y los contadores vuelven a 0[cite: 1]
      for (var habito in catalogoHabitos) {
        habito.contador = 0;
      }
      habitosActivos.clear();
    });
  }

  void mostrarModalAgregarHabito() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 400,
          child: Column(
            children: [
              const Text(
                'Selecciona un Hábito',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: catalogoHabitos.length,
                  itemBuilder: (context, index) {
                    final habito = catalogoHabitos[index];
                    final bool yaAgregado = habitosActivos.any((h) => h.id == habito.id);
                    
                    return ListTile(
                      leading: Icon(habito.icono, color: Colors.deepPurple, size: 30),
                      title: Text(habito.nombre, style: const TextStyle(fontSize: 16)),
                      trailing: yaAgregado
                          ? const Text('Agregado', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
                          : ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  habitosActivos.add(habito);
                                });
                                Navigator.pop(context); // Cierra el modal tras agregar
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                              child: const Text('Agregar', style: TextStyle(color: Colors.white)),
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Control de Hábitos', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: reiniciarDia,
            tooltip: 'Reiniciar Día',
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const EncabezadoWidget(), // Composición del Stateless[cite: 2]
          Expanded(
            child: habitosActivos.isEmpty
                ? const Center(
                    child: Text(
                      'No hay hábitos.\nPresiona + para agregar uno.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: habitosActivos.length,
                    itemBuilder: (context, index) {
                      return HabitoCard( // Composición de los widgets[cite: 2]
                        habito: habitosActivos[index],
                        onIncrement: () => incrementarHabito(index),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: mostrarModalAgregarHabito,
        label: const Text('Agregar Hábito', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}