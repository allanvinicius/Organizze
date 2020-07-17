import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financas/src/class/Movimentacoes.dart';

class MovRepository {
  CollectionReference collection =
      Firestore.instance.collection("movimentacoes");

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Stream<QuerySnapshot> getStreamR() {
    return collection.where("tipo", isEqualTo: 1).snapshots();
  }

  Stream<QuerySnapshot> getStreamD() {
    return collection.where("tipo", isEqualTo: 2).snapshots();
  }

  Future<DocumentReference> addMov(Movimentacoes mov) {
    return collection.add(mov.toJson());
  }

  updateMov(Movimentacoes mov) async {
    await collection
        .document(mov.reference.documentID)
        .updateData(mov.toJson());
  }

  deleteMov(Movimentacoes mov) async {
    await collection.document(mov.reference.documentID).delete();
  }
}
