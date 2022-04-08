import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  late String uidExpediteur;
  late String uidDestinataire;
  late String message;
  late DateTime heureEnvoi;

  Message(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    uidExpediteur = map["UIDEXP"];
    uidDestinataire = map["UIDDEST"];
    message = map["MSG"];
    Timestamp timestamp = map["HEURE"];
    heureEnvoi = timestamp.toDate();
  }

  Message.vide() {
    uidExpediteur = "";
    uidDestinataire = "";
    message = "";
    heureEnvoi = DateTime.now();
  }
}
