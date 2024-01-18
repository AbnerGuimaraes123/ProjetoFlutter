import 'package:flutter/material.dart';
import '/view/detalhesProdutos.dart';


class ProdutoItem extends StatelessWidget {
  final String nome;
  final String descricao;
  final int quantidade;
  final double valor;
  final Function() onDelete;
  final Function() onEdit;

  ProdutoItem({
    Key? key,
    required this.nome,
    required this.descricao,
    required this.quantidade,
    required this.valor,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  void mostrarDetalhesDaProduto(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetalhesDoProduto(
          nome: nome,
          descricao: descricao,
          quantidade: quantidade,
          valor: valor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (_) {
        onDelete();
      },
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
      ),
      child: GestureDetector(
        onTap: () {
          mostrarDetalhesDaProduto(context);
        },
        child: Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: InkWell(
            hoverColor: Colors.grey[200],
            mouseCursor: SystemMouseCursors.click,
            onTap: () {
              mostrarDetalhesDaProduto(context);
            },
            child: ListTile(
              mouseCursor: SystemMouseCursors.click,
              contentPadding: EdgeInsets.all(16),
              title: Text(
                nome,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Preço: R\$$valor',
                style: TextStyle(fontSize: 18),
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: onEdit,
                color: Color.fromARGB(255, 14, 126, 126),
              ),
            ),
          ),
        ),
      ),
    );
  }
}