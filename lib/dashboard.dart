import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/detailPage.dart';
import 'package:flutter_application_1/fonctions/firestoreHelper.dart';
import 'package:flutter_application_1/library/constants.dart';
import 'package:flutter_application_1/messagePage.dart';
import 'package:flutter_application_1/model/utilisateur.dart';
import 'package:flutter_application_1/widgets/myDrawer.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  String uid;

  DashBoard({required this.uid});

  @override
  State<StatefulWidget> createState() {
    return DashBoardState();
  }
}

class DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / 1.5,
        color: Colors.blue,
        child: myDrawer(),
      ),
      appBar: AppBar(
        title: const Text("Contact"),
      ),
      body: bodyPage(),
    );
  }

  Widget bodyPage() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreHelper().fire_user.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            List documents = snapshot.data!.docs;
            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  Utilisateur user = Utilisateur(documents[index]);
                  if (monProfil.uid == user.uid) {
                    return Container();
                  }
                  return Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: Hero(
                        tag: user.uid,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: (user.logo != null)
                                      ? NetworkImage(user.logo!)
                                      : NetworkImage(
                                          "https://firebasestorage.googleapis.com/v0/b/projetsqyavril2022.appspot.com/o/noImage.png?alt=media&token=dc26627a-5c9f-491b-8529-c8b44bfad00a"))),
                        ),
                      ),
                      title: Text("${user.prenom} ${user.nom}"),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return messagePage(
                              uidExpediteur: monProfil.uid,
                              user: "${user.prenom} ${user.nom}",
                              uidDestinataire: user.uid);
                        }));
                      },
                    ),
                  );
                });
          }
        });
  }
}
