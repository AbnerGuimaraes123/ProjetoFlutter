import 'package:flutter/material.dart';
import '/models/Botoes.dart';

class Inputs extends StatelessWidget {
  final TextEditingController nomeController;
  final TextEditingController descController;
  final TextEditingController qtdController;
  final TextEditingController valorController;
  final Function() onCancelar;
  final Function() onSalvar;

  Inputs({
    required this.nomeController,
    required this.descController,
    required this.qtdController,
    required this.valorController,
    required this.onCancelar,
    required this.onSalvar,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      content: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Novo Nome:'),
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                hintText: "Nome do Produto",
              ),
            ),

            Text('Nova Descrição:'),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                hintText: "Descrição da Produto",
              ),
            ),

            Text('Nova Quantidade:'),
            TextField(
              controller: qtdController,
              decoration: InputDecoration(
                hintText: "Quantidade da Produto",
              ),
            ),

            Text('Novo Valor:'),
            TextField(
              controller: valorController,
              decoration: InputDecoration(
                hintText: "Valor da Produto",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Botoes(texto: "Salvar", onPressed: onSalvar),
                const SizedBox(width: 50,),
                Botoes(texto: "Cancelar", onPressed: onCancelar),
              ],
            )
          ],
        ),
      ),
    );
  }
}
