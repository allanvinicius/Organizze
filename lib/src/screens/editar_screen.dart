import 'package:financas/src/class/Movimentacoes.dart';
import 'package:financas/src/data/MovRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Editar extends StatefulWidget {
  final Movimentacoes mov;

  const Editar(this.mov);

  @override
  _EditarState createState() => _EditarState();
}

class _EditarState extends State<Editar> {
  MovRepository repository = MovRepository();
  final _formKey = GlobalKey<FormBuilderState>();
  String valor;
  String descricao;
  DateTime data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar despesas ou receitas"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: FormBuilder(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              FormBuilderTextField(
                attribute: "valor",
                decoration: InputDecoration(
                  hintText: "Valor",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                initialValue: widget.mov.valor,
                onChanged: (val) {
                  setState(() {
                    valor = val;
                  });
                },
              ),
              SizedBox(height: 20),
              FormBuilderTextField(
                attribute: "descrição",
                decoration: InputDecoration(
                  hintText: "Descrição",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                initialValue: widget.mov.descricao,
                onChanged: (val) {
                  setState(() {
                    descricao = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              FormBuilderDateTimePicker(
                  decoration: InputDecoration(
                    hintText: "Clique e coloque a data que deseja",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  attribute: "Data",
                  inputType: InputType.date,
                  initialValue: widget.mov.data,
                  onChanged: (text) {
                    setState(() {
                      widget.mov.data = text;
                    });
                  }),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.greenAccent[700],
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancelar",
                    ),
                  ),
                  RaisedButton(
                    color: Colors.greenAccent[700],
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        if (_formKey.currentState.validate()) {
                          Navigator.of(context).pop();
                          if (valor != null) widget.mov.valor = valor;
                          if (descricao != null)
                            widget.mov.descricao = descricao;
                          repository.updateMov(widget.mov);
                        }
                      }
                    },
                    child: Text(
                      "Atualizar",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
