import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Botoes extends StatelessWidget {
  final String texto;
  VoidCallback onPressed;

  Botoes({super.key, required this.texto, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
    ), child: Text(texto));
  }
}
