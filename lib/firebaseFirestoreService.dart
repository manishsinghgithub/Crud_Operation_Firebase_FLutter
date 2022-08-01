import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FireBaseFirestoreServices {
  final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection("pruduct");

  final TextEditingController _titleText = TextEditingController();
  final TextEditingController _subtitleText = TextEditingController();

  Future<void> updateData(
      [DocumentSnapshot? documentSnapshot, String? title, int? price]) async {
    if (documentSnapshot != null) {
      await _firebaseFirestore
          .doc(documentSnapshot.id)
          .update({"name": title, "price": price});
      log("updated Successfully");
    }
    log("Id or data not found: ");
  }

  Future<void> deleteData([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      await _firebaseFirestore.doc(documentSnapshot.id).delete();
      log("data deleted successfully");
    }

    log("Data not found in database to delete: ");
  }

  Future<void> addData([String? title, int? price]) async {
    if (title != null && price != null) {
      await _firebaseFirestore.add({"name": title, "price": price});
      log("added to database: ");
    }
    log("Data is missing:");
  }

  Stream<QuerySnapshot> getData() {
    Stream<QuerySnapshot> streamSnapshot = _firebaseFirestore.snapshots();
    return streamSnapshot;
  }
}
