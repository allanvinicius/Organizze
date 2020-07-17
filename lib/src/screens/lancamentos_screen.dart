import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financas/src/class/Movimentacoes.dart';
import 'package:financas/src/data/MovRepository.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class LancamentosScreen extends StatefulWidget {
  final Movimentacoes mov = Movimentacoes();
  @override
  _LancamentosScreenState createState() => _LancamentosScreenState();
}

class _LancamentosScreenState extends State<LancamentosScreen> {
  // ignore: unused_field
  CalendarController _calendarController;
  var dataAtual = new DateTime.now();
  var formatter = new DateFormat('dd-MM-yyyy');
  var formatterCalendar = new DateFormat('MM-yyyy');
  String dataFormatada;
  MovRepository repository = MovRepository();

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _calendarController = CalendarController();
    });

    dataFormatada = formatterCalendar.format(dataAtual);
    //print(dataFormatada);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lançamentos'),
        backgroundColor: Colors.greenAccent[400],
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.visibility),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder(
        stream: repository.getStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          return _buildList(context, snapshot.data.documents);
          // return Container(
          //   height: 200,
          //   child: ListView(
          //     children: <Widget>[
          //       TableCalendar(
          //         calendarController: _calendarController,
          //         //locale: "pt_BR",
          //         headerStyle: HeaderStyle(
          //           formatButtonShowsNext: false,
          //           formatButtonVisible: false,
          //           centerHeaderTitle: true,
          //         ),
          //         calendarStyle: CalendarStyle(
          //           outsideDaysVisible: false,
          //         ),
          //         daysOfWeekStyle: DaysOfWeekStyle(
          //           weekdayStyle: TextStyle(color: Colors.transparent),
          //           weekendStyle: TextStyle(color: Colors.transparent),
          //         ),
          //         rowHeight: 1,
          //         initialCalendarFormat: CalendarFormat.month,
          //         onVisibleDaysChanged:
          //             (dateFirst, dateLast, CalendarFormat cf) {
          //           print(dateFirst);

          //           dataFormatada = formatterCalendar.format(dateFirst);

          //           print("DATA FORMATADA CALENDARIO $dataFormatada");
          //         },
          //       ),
          //       //     //Divider(),
          //       Column(
          //         children: <Widget>[
          //           Container(
          //             width: double.infinity,
          //             height: 100,
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: <Widget>[
          //                   Icon(
          //                     Icons.work,
          //                   ),
          //                   SizedBox(
          //                     width: 6,
          //                   ),
          //                   Column(
          //                     children: <Widget>[
          //                       Text(
          //                         'Saldo atual',
          //                         style: TextStyle(
          //                           fontSize: 15,
          //                         ),
          //                       ),
          //                       Text(
          //                         'R\$ 0,00',
          //                         style: TextStyle(
          //                           color: Colors.green,
          //                           fontSize: 20,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                   Spacer(),
          //                   InkWell(
          //                     child: Row(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: <Widget>[
          //                         Icon(
          //                           Icons.account_balance_wallet,
          //                         ),
          //                         SizedBox(
          //                           width: 6,
          //                         ),
          //                         Column(
          //                           children: <Widget>[
          //                             Text(
          //                               'Balanço Mensal',
          //                               style: TextStyle(
          //                                 fontSize: 15,
          //                               ),
          //                             ),
          //                             SizedBox(
          //                               width: 6,
          //                             ),
          //                             Text(
          //                               'R\$ 0,00',
          //                               style: TextStyle(
          //                                 color: Colors.green,
          //                                 fontSize: 20,
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ],
          //                     ),
          //                     onTap: () {},
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // );
        },
      ),
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
      height: 50,
      child: ListView(
        children: <Widget>[
          Card(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 40,
                    child: InkWell(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              mov.descricao,
                              style: TextStyle(
                                fontSize: 20,
                                //color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Text(
                          //     mov.data.toString(),
                          //     style: TextStyle(
                          //       fontSize: 20,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "R\$" + "${mov.valor}",
                              style: TextStyle(
                                fontSize: 20,
                                //color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
