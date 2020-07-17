import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financas/src/class/Movimentacoes.dart';
import 'package:financas/src/data/MovRepository.dart';
import 'package:financas/src/screens/editar_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResumoDespesas extends StatefulWidget {
  final Movimentacoes mov = Movimentacoes();

  @override
  _ResumoDespesasState createState() => _ResumoDespesasState();
}

class _ResumoDespesasState extends State<ResumoDespesas> {
  final MovRepository repository = MovRepository();
  final dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent[700],
      appBar: AppBar(
        title: Text(
          'Despesas',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent[700],
      ),
      body: StreamBuilder(
          stream: repository.getStreamD(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return LinearProgressIndicator(
                backgroundColor: Colors.redAccent[700],
              );
            return _buildList(context, snapshot.data.documents);
          }),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final mov = Movimentacoes.fromSnapshot(snapshot);

    if (mov == null) {
      return Container();
    }

    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 80,
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        mov.descricao,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        mov.data == null ? "" : dateFormat.format(mov.data),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white60,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "- " + "${mov.valor}",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: "Apagar",
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white60,
                      ),
                      onPressed: () {
                        _deletaMov(mov);
                      },
                    ),
                  ],
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Suas opções"),
                          content: Text("O que você deseja fazer ?"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Editar(mov),
                                  ),
                                );
                              },
                              child: Text("Editar"),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancelar"),
                            ),
                          ],
                        );
                      });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _deletaMov(Movimentacoes movs) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Atenção!"),
            content: Text('Você tem certeza que deseja excluir a despesa ?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "CANCELAR",
                ),
              ),
              FlatButton(
                onPressed: () {
                  repository.deleteMov(movs);
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                ),
              ),
            ],
          );
        });
  }
}
