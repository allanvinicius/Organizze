import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financas/src/class/Movimentacoes.dart';
import 'package:financas/src/data/MovRepository.dart';
import 'package:flutter/material.dart';
import 'package:financas/src/screens/editar_screen.dart';
import 'package:intl/intl.dart';

class ResumoReceitas extends StatefulWidget {
  final Movimentacoes mov = Movimentacoes();

  @override
  _ResumoReceitasState createState() => _ResumoReceitasState();
}

class _ResumoReceitasState extends State<ResumoReceitas> {
  MovRepository repository = MovRepository();
  final dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[400],
      appBar: AppBar(
        title: Text('Receitas', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.greenAccent[400],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: repository.getStreamR(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return LinearProgressIndicator(
                backgroundColor: Colors.greenAccent[400],
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "+ " + "${mov.valor}",
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
                        color: Colors.white70,
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
                            // FlatButton(
                            //   onPressed: () {
                            //     _deletaMov(mov);
                            //   },
                            //   child: Text("Apagar"),
                            // ),
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
            content: Text('Você tem certeza que deseja excluir a receita ?'),
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
