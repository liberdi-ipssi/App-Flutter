import 'package:flutter/material.dart';
import 'package:flutter_application_1/messagePage.dart';
import 'package:flutter_application_1/model/utilisateur.dart';

import 'fonctions/firestoreHelper.dart';
import 'library/constants.dart';

class detailPage extends StatefulWidget {
  Utilisateur user;
  detailPage({required this.user});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return detailState();
  }
}

class detailState extends State<detailPage> {
  late String uid;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(), body: bodyPage());
  }

  Widget bodyPage() {
    return Column(children: [
      Card(
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: Hero(
              tag: widget.user.uid,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: (widget.user.logo != null)
                            ? NetworkImage(widget.user.logo!)
                            : NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/projetsqyavril2022.appspot.com/o/noImage.png?alt=media&token=dc26627a-5c9f-491b-8529-c8b44bfad00a"))),
              ),
            ),
            title: Text("${widget.user.prenom} ${widget.user.nom}"),
          )),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {
            FirestoreHelper().getIdentifiant().then((value) {
              setState(() {
                uid = value;
              });

              FirestoreHelper().getUtilisateur(uid).then((value) {
                setState(() {
                  monProfil = value;
                });
              });
            });
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return messagePage(
                  uidExpediteur: monProfil.uid,
                  uidDestinataire: widget.user.uid);
            }));
          },
          child: const Text("Envoyer un message")),
    ]);
  }
}
