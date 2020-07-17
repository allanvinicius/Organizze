import 'package:cloud_firestore/cloud_firestore.dart';

class Movimentacoes {
  //String data;
  DateTime data;
  String valor;
  int tipo;
  String descricao;

  DocumentReference reference;

  Movimentacoes(
      {this.data, this.valor, this.tipo, this.descricao, this.reference});

  factory Movimentacoes.fromSnapshot(DocumentSnapshot snapshot) {
    Movimentacoes mov = Movimentacoes.fromJson(snapshot.data);
    mov.reference = snapshot.reference;
    return mov;
  }

  factory Movimentacoes.fromJson(Map<dynamic, dynamic> json) =>
      _movFromJson(json);

  Map<String, dynamic> toJson() => _movToJson(this);
}

Movimentacoes _movFromJson(Map<dynamic, dynamic> json) {
  return Movimentacoes(
    valor: json['valor'] as String,
    descricao: json['descricao'] as String,
    //data: json['data'] as String,
    tipo: json['tipo'] as int,
    data: json['data'] == null ? null : (json['data'] as Timestamp).toDate(),
  );
}

Map<String, dynamic> _movToJson(Movimentacoes instance) => <String, dynamic>{
      'valor': instance.valor,
      'descricao': instance.descricao,
      'tipo': instance.tipo,
      'data': instance.data,
    };
