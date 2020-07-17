import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class RelatoriosScreen extends StatefulWidget {
  @override
  _RelatoriosScreenState createState() => _RelatoriosScreenState();
}

class _RelatoriosScreenState extends State<RelatoriosScreen> {
  CalendarController _calendarController;
  var dataAtual = new DateTime.now();
  var formatter = new DateFormat('dd-MM-yyyy');
  var formatterCalendar = new DateFormat('MM-yyyy');
  String dataFormatada;

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
        title: Text('Relatórios'),
        backgroundColor: Colors.greenAccent[400],
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: <Widget>[
          TableCalendar(
            calendarController: _calendarController,
            //locale: "pt_BR",
            headerStyle: HeaderStyle(
              formatButtonShowsNext: false,
              formatButtonVisible: false,
              centerHeaderTitle: true,
            ),
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Colors.transparent),
              weekendStyle: TextStyle(color: Colors.transparent),
            ),
            rowHeight: 1,
            initialCalendarFormat: CalendarFormat.month,
            onVisibleDaysChanged: (dateFirst, dateLast, CalendarFormat cf) {
              print(dateFirst);

              dataFormatada = formatterCalendar.format(dateFirst);

              print("DATA FORMATADA CALENDARIO $dataFormatada");
            },
          ),
          Container(
            height: 200,
            width: double.minPositive,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                  topLeft: Radius.zero,
                  topRight: Radius.zero,
                ),
              ),
              child: Text('DESPESAS X RECEITAS'),
            ),
          ),
        ],
      ),
    );
  }
}
