import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/firebaseFirestoreService.dart';

class ModalService {
  final _formKey = GlobalKey<FormState>();
  final FireBaseFirestoreServices fireBaseFirestoreServices =
      FireBaseFirestoreServices();
  String? title;
  int? price;
  Future<Container?> updateModalService(
          BuildContext context, DocumentSnapshot documentSnapshot) =>
      showModalBottomSheet(
          context: context,
          builder: (BuildContext ctext) {
            return Container(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Item name Required!";
                          }
                          title = value.toString();
                        },
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Price Required!";
                          }
                          price = int.parse(value);
                        },
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await fireBaseFirestoreServices.updateData(
                                documentSnapshot, title, price);
                          }
                        },
                        child: Text("Update"),
                      )
                    ],
                  )),
            );
          });

  Future<Container?> addModalService(BuildContext context) =>
      showModalBottomSheet(
          context: context,
          builder: (BuildContext ctext) {
            return Container(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Item name Required!";
                          }
                          title = value.toString();
                        },
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Price Required!";
                          }
                          price = int.parse(value);
                        },
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await fireBaseFirestoreServices.addData(
                                title, price);
                          }
                        },
                        child: Text("Update"),
                      )
                    ],
                  )),
            );
          });
}
