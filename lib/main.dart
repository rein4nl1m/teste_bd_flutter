import 'package:flutter/material.dart';
import 'package:test_bd/db/db_connection.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Básico',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD Básico"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Insert"),
              onPressed: () {_inserir();},
            ),
            RaisedButton(
              child: Text("Consultar"),
              onPressed: () {_consultar();},
            ),
            RaisedButton(
              child: Text("Atualizar"),
              onPressed: () {_atualizar();},
            ),
            RaisedButton(
              child: Text("Deletar"),
              onPressed: () {_deletar();},
            ),
          ],
        ),
      ),
    );
  }

  void _inserir() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : 'Arroz',
      DatabaseHelper.columnAmount: 3
    };

    final id = await dbHelper.insertItem(row);
    print('linha inserida id: $id');
  }

  void _consultar() async {
    final todasLinhas = await dbHelper.queryAllRowsItem();
    print('Consulta todas as linhas:');
    todasLinhas.forEach((row) => print(row));
  }

  void _atualizar() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId : 1,
      DatabaseHelper.columnName : 'Feijão',
      DatabaseHelper.columnAmount: 5
    };

    final linhasAfetadas = await dbHelper.updateItem(row);
    print('atualizadas $linhasAfetadas linha(s)');
  }

  void _deletar() async {
    final id = await dbHelper.queryRowCountItem();
    final linhaDeletada = await dbHelper.deleteItem(id);
    print('Deletada(s) $linhaDeletada linha(s): linha $id');
  }
}