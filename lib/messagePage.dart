import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/message.dart';
import 'fonctions/firestoreHelper.dart';

class messagePage extends StatefulWidget {
  String uidExpediteur;
  String uidDestinataire;

  messagePage({required this.uidExpediteur, required this.uidDestinataire});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return messageState();
  }
}

class messageState extends State<messagePage> {
  late String message;
  final fieldText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(), body: bodyPage());
  }

  void clearText() {
    fieldText.clear();
  }

  convertTimeStamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    String time =
        "${date.year}/${date.month}/${date.day} ${date.hour}:${date.minute}";
    return time;
  }

  //bloc de message
  blocMessage() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreHelper()
            .fire_message
            .where("UIDEXP", isEqualTo: widget.uidExpediteur)
            .where("UIDDEST", isEqualTo: widget.uidDestinataire)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            List documents = snapshot.data!.docs;
            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  Message message = Message(documents[index]);
                  if (widget.uidExpediteur == message.uidExpediteur &&
                          widget.uidDestinataire == message.uidDestinataire ||
                      widget.uidExpediteur == message.uidDestinataire &&
                          widget.uidDestinataire == message.uidExpediteur) {
                    return Container();
                  }
                  return Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                          "${message.message} ${convertTimeStamp(message.heureEnvoi)}"),
                    ),
                  );
                });
          }
        });
  }

  Widget bodyPage() {
    // bloc appelé + textinput + button
    return Container(
      child: blocMessage(),
    );

    /* Row(children: [
        Container(
          margin: const EdgeInsets.only(left: 2.5, top: 2.5),
          width: MediaQuery.of(context).size.width / 1.25,
          child: TextField(
            controller: fieldText,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.message),
              hintText: "Taper votre message",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              setState(() {
                message = value;
              });
            },
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(40, 55),
              primary: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {
            FirestoreHelper().newMessage(widget.uidExpediteur,
                widget.uidDestinataire, message, DateTime.now());
            clearText();
          },
          child: const Icon(Icons.send),
        ),
      ]) */
  }
}
