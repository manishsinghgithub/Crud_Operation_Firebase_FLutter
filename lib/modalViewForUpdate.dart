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
            return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Item Name:",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Item name Required!";
                          }
                          title = value.toString();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Item price:",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Price Required!";
                          }
                          price = int.parse(value);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await fireBaseFirestoreServices.updateData(
                              documentSnapshot, title, price);
                        }
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    )
                  ],
                ));
          });

  Future<Container?> addModalService(BuildContext context) =>
      showModalBottomSheet(
          context: context,
          builder: (BuildContext ctext) {
            return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Name of item",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Item name Required!";
                          }
                          title = value.toString();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Price of item",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Price Required!";
                          }
                          price = int.parse(value);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    MaterialButton(
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await fireBaseFirestoreServices.addData(title, price);
                        }
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Add Data",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    )
                  ],
                ));
          });
}
