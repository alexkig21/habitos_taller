import 'package:flutter/material.dart';

class Habito {
  final String id;
  final String nombre;
  final IconData icono;
  final int meta;
  int contador;

  Habito({
    required this.id,
    required this.nombre,
    required this.icono,
    required this.meta,
    this.contador = 0,
  });
}
