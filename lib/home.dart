import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/firebaseFirestoreService.dart';
import 'package:crud_firebase/modalViewForUpdate.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = "homePage";
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection("pruduct");

  final FireBaseFirestoreServices fireBaseFirestoreServices =
      FireBaseFirestoreServices();
  final ModalService _modalService = ModalService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Item List "),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () async {
                await _modalService.addModalService(context);
                setState(() {});
              },
              child: const Text(
                "Add more ",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: StreamBuilder(
        stream: _firebaseFirestore.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot["name"]),
                    subtitle: Text(documentSnapshot["price"].toString()),
                    leading: IconButton(
                      onPressed: () async {
                        await _modalService.updateModalService(
                            context, documentSnapshot);
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.upload,
                        color: Colors.teal,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        await fireBaseFirestoreServices
                            .deleteData(documentSnapshot);
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: MaterialButton(
                onPressed: () {},
                child: Text("Add Items"),
              ),
            );
          }
        },
      ),
    );
  }
}
