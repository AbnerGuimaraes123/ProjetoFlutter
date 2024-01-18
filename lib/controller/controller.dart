import 'package:abner/view/ProdutoItens.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/inputs.dart';


class Controller extends StatefulWidget {
  const Controller({Key? key}) : super(key: key);

  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  final controller = TextEditingController();
  final nomeController = TextEditingController();
  final descController = TextEditingController();
  final qtdController = TextEditingController();
  final valorController = TextEditingController();
  List<Map<String, dynamic>> ProdutoItems = [];

  @override
  void initState() {
    super.initState();
    carregarDadosDaAPI();
  }

  Future<void> carregarDadosDaAPI() async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/produtos/?format=json'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is List) {
        setState(() {
          ProdutoItems = List<Map<String, dynamic>>.from(data.map((item) {
            return {
              'id': item['id'],
              'nome': item['nome'],
              'desc': item['desc'],
              'qtd': item['qtd'],
              'valor': item['valor'],
            };
          }));
        });
      }
    } else {
      throw Exception('Falha ao carregar dados da API. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Erro na requisição da API: $e');
  }
}

void adicionarNovaProdutoItem(Map<String, dynamic> novaProdutoItem) async {
  try {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/produtos/add'), 
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(novaProdutoItem),
    );

    if (response.statusCode == 201) {
    
      carregarDadosDaAPI();
    } else {
      throw Exception('Falho ao adicionar. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Erro POST: $e');
  }
}

  void criarNovaProdutoItem() {
    showDialog(
      context: context,
      builder: ((context) {
        return Inputs(
          nomeController: nomeController,
          descController: descController,
          qtdController: qtdController,
          valorController: valorController,
          onCancelar: () {
            nomeController.clear();
            descController.clear();
            qtdController.clear();
            valorController.clear();
            Navigator.of(context).pop();
          },
          onSalvar: salvarProdutoItem,
        );
      }),
    );
  }

void salvarProdutoItem() {
  final novaProdutoItem = {
    'nome': nomeController.text,
    'desc': descController.text,
    'qtd': int.parse(qtdController.text),
    'valor': double.parse(valorController.text),
  };

  adicionarNovaProdutoItem(novaProdutoItem);

  nomeController.clear();
  descController.clear();
  qtdController.clear();
  valorController.clear();

  Navigator.of(context).pop();
}

  void editarProdutoItem(int index) {
    showDialog(
      context: context,
      builder: ((context) {
        nomeController.text = ProdutoItems[index]['nome'];
        descController.text = ProdutoItems[index]['desc'];
        qtdController.text = ProdutoItems[index]['qtd'].toString();
        valorController.text = ProdutoItems[index]['valor'].toString();
        return Inputs(
          nomeController: nomeController,
          descController: descController,
          qtdController: qtdController,
          valorController: valorController,
          onCancelar: () {
            nomeController.clear();
            descController.clear();
            qtdController.clear();
            valorController.clear();
            Navigator.of(context).pop();
          },
          onSalvar: () {
            setState(() {
              ProdutoItems[index]['nome'] = nomeController.text;
              ProdutoItems[index]['desc'] = descController.text;
              ProdutoItems[index]['qtd'] = int.parse(qtdController.text);
              ProdutoItems[index]['valor'] = double.parse(valorController.text);
            });
            nomeController.clear();
            descController.clear();
            qtdController.clear();
            valorController.clear();
            Navigator.of(context).pop();
          },
        );
      }),
    );
  }

  void deletarProdutoItem(int index) {
    setState(() {
      ProdutoItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 14, 126, 126),
      appBar: AppBar(
        title: Text('Armazem Lojinha Da Estrada'),
        backgroundColor: Color.fromARGB(180, 71, 160, 190),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: ProdutoItems.length,
        itemBuilder: (context, index) {
          return ProdutoItem(
            nome: ProdutoItems[index]['nome'],
            descricao: ProdutoItems[index]['desc'],
            quantidade: ProdutoItems[index]['qtd'],
            valor: ProdutoItems[index]['valor'],
            onDelete: () {
              deletarProdutoItem(index);
            },
            onEdit: () {
              editarProdutoItem(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 119, 153, 153),
        onPressed: () {
          criarNovaProdutoItem();
        },
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 124, 235, 55),
          
        ),
      ),
    );
  }
}
