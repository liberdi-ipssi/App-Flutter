import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  late String uidExpediteur;
  late String uidDestinataire;
  late String message;
  late Timestamp heureEnvoi;

  Message(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    uidExpediteur = map["UIDEXP"];
    uidDestinataire = map["UIDDEST"];
    message = map["MSG"];
    heureEnvoi = map["HEURE"];
  }

  Message.vide() {
    uidExpediteur = "";
    uidDestinataire = "";
    message = "";
    heureEnvoi = Timestamp.now();
  }
}
