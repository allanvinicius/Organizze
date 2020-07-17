//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financas/src/class/Movimentacoes.dart';
import 'package:financas/src/data/MovRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// ignore: must_be_immutable
class DialogRD extends StatefulWidget {
  String valor;
  String descricao;
  int tipo;
  DateTime data;

  final Movimentacoes movimentacoes;
  // final Receita rec;
  // final Despesa desp;

  DialogRD({Key key, this.movimentacoes}) : super(key: key);

  @override
  _DialogRDState createState() => _DialogRDState();
}

class _DialogRDState extends State<DialogRD> {
  bool edit;

  int _groupValueRadio = 1;
  // ignore: unused_field
  Color _colorContainer = Colors.greenAccent[400];
  // ignore: unused_field
  Color _colorTextButtom = Colors.green;

  MovRepository repository;

  @override
  void initState() {
    super.initState();

    if (widget.movimentacoes != null) {
      print(widget.movimentacoes.toString());

      if (widget.movimentacoes.tipo == 2) {
        _groupValueRadio = 2;
        _colorContainer = Colors.red[300];
        _colorTextButtom = Colors.red[300];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'R\$ ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.06,
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      maxLength: 7,
                      style: TextStyle(fontSize: width * 0.05),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      maxLines: 1,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        hintText: "0.00",
                        hintStyle: TextStyle(color: Colors.white54),
                        contentPadding: EdgeInsets.only(
                            left: width * 0.04,
                            top: width * 0.041,
                            bottom: width * 0.041,
                            right: width * 0.04),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.04),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.04),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                      ),
                      onChanged: (text) => widget.valor = text,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    activeColor: Colors.green[900],
                    value: 1,
                    groupValue: _groupValueRadio,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _groupValueRadio = value;
                        _colorContainer = Colors.greenAccent[400];
                        _colorTextButtom = Colors.green;
                        widget.tipo = value;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.01),
                    child: Text("Receita"),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    activeColor: Colors.red[900],
                    value: 2,
                    groupValue: _groupValueRadio,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _groupValueRadio = value;
                        _colorContainer = Colors.redAccent[700];
                        _colorTextButtom = Colors.red[300];
                        widget.tipo = value;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.01),
                    child: Text("Despesa"),
                  ),
                ],
              ),
              TextFormField(
                maxLength: 20,
                style: TextStyle(fontSize: width * 0.05),
                keyboardType: TextInputType.text,
                maxLines: 1,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  labelText: "Descrição",
                  labelStyle: TextStyle(color: Colors.white54),
                  contentPadding: EdgeInsets.only(
                      left: width * 0.04,
                      top: width * 0.041,
                      bottom: width * 0.041,
                      right: width * 0.04),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.04),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.04),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (text) => widget.descricao = text,
              ),
              Container(
                child: FormBuilderDateTimePicker(
                    initialValue: DateTime.now(),
                    //locale: Locale("pt_BR"),
                    attribute: "Data",
                    inputType: InputType.date,
                    onChanged: (text) {
                      setState(() {
                        widget.data = text;
                      });
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
