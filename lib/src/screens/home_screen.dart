//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financas/src/components/Resumo_despesas.dart';
import 'package:financas/src/components/Resumo_receitas.dart';
import 'package:financas/src/data/MovRepository.dart';
import 'package:financas/src/tema.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String saldoAtual = "";
  String saldoR = "";
  String saldoD = "";
  bool _visible = false;
  DocumentSnapshot doc;
  MovRepository repository = MovRepository();

  // _addvalor() {
  //   return StreamBuilder(
  //     stream: repository.getStream(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) return CircularProgressIndicator();
  //       return ListView.builder(
  //         itemCount: snapshot.data.documents.length,
  //         itemBuilder: (context, index) {
  //           DocumentSnapshot doc = snapshot.data.documents[index];
  //         },
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 250,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          // InkWell(
                          //   child: CircleAvatar(),
                          //   onTap: () {},
                          // ),
                          //Spacer(),
                          IconButton(
                            tooltip: "Tema claro/escuro",
                            icon: Icon(Icons.brightness_6),
                            onPressed: () {
                              Provider.of<Tema>(context, listen: false)
                                  .swapTheme();
                            },
                          ),
                        ],
                      ),
                      Visibility(
                        visible: _visible,
                        maintainState: true,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: repository.getStream(),
                            builder: (context, snapshot) {
                              for (var i = 0;
                                  i < snapshot.data.documents.length;
                                  i++) {
                                doc = snapshot.data.documents[i];
                              }
                              return Text(
                                //'R\$ 0,00',
                                'R\$ ' + doc['valor'].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                      ),
                      Container(height: 10),
                      Text(
                        'Saldo geral',
                        textAlign: TextAlign.center,
                      ),
                      Container(height: 10),
                      IconButton(
                        icon: Icon(
                            _visible ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _visible = !_visible;
                          });
                        },
                      ),
                      Container(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 10,
                            ),
                            InkWell(
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    child: Icon(
                                      Icons.arrow_upward,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors.greenAccent[400],
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        'Receitas',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Visibility(
                                        visible: _visible,
                                        maintainState: true,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: repository.getStreamR(),
                                            builder: (context, snapshot) {
                                              for (var i = 0;
                                                  i <
                                                      snapshot.data.documents
                                                          .length;
                                                  i++) {
                                                doc =
                                                    snapshot.data.documents[i];
                                              }
                                              return Text(
                                                //'R\$ 0,00',
                                                'R\$ ' +
                                                    doc['valor'].toString(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.green,
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResumoReceitas(),
                                  ),
                                );
                              },
                            ),
                            Spacer(),
                            InkWell(
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    child: Icon(
                                      Icons.arrow_downward,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors.redAccent[700],
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        'Despesas',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Visibility(
                                        visible: _visible,
                                        maintainState: true,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: repository.getStreamD(),
                                            builder: (context, snapshot) {
                                              for (var i = 0;
                                                  i <
                                                      snapshot.data.documents
                                                          .length;
                                                  i++) {
                                                doc =
                                                    snapshot.data.documents[i];
                                              }
                                              return Text(
                                                //'R\$ 0,00',
                                                "R\$ " +
                                                    doc['valor'].toString(),
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 20,
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResumoDespesas(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 20,
              ),
              Text(
                'Cartões de crédito',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                height: 230,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 30,
                      ),
                      Icon(
                        Icons.payment,
                        size: 35,
                      ),
                      Container(
                        height: 20,
                      ),
                      Text(
                        'Você ainda não tem nenhum cartão de crédito cadastrado.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: 10),
                      Text('Melhore seu controle financeiro agora!'),
                      Container(height: 10),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text('ADICIONAR NOVO CARTÃO'),
                        color: Colors.greenAccent[400],
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              Container(height: 20),
              Text(
                'Despesas por categoria',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 150,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(height: 30),
                      Icon(
                        Icons.pie_chart,
                        size: 35,
                      ),
                      Container(
                        height: 20,
                      ),
                      Text(
                        'Você não tem despesas cadastradas nesse mês.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      Text(
                          'Adicione seus gastos no mês atual para ver seus gráficos.'),
                    ],
                  ),
                ),
              ),
              Container(height: 20),
              Text(
                'Relatório Mensal',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 230,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(height: 30),
                      Icon(
                        Icons.assignment,
                        size: 35,
                      ),
                      Container(
                        height: 20,
                      ),
                      Text(
                        'Você ainda não tem um planejamento definido para esse mês.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      Text('Melhore seu controle financeiro agora!'),
                      Container(height: 10),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text('DEFINIR MEU PLANEJAMENTO'),
                        color: Colors.greenAccent[400],
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
