// ignore_for_file: prefer_const_constructors, dead_code, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/message.dart';
import 'fonctions/firestoreHelper.dart';
import 'package:flutter_application_1/model/utilisateur.dart';

class messagePage extends StatefulWidget {
  String uidExpediteur;
  String uidDestinataire;
  String user;

  messagePage(
      {required this.uidExpediteur,
      required this.uidDestinataire,
      required this.user});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return messageState();
  }
}

class ChatMessage{
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
  }
class messageState extends State<messagePage> {
  late String message;
  final fieldText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "<https://randomuser.me/api/portraits/men/5.jpg>"),
                    maxRadius: 20,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "${widget.user}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Online",
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 13),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: blocMessage());
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
    List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

    return Stack(
      children: <Widget>[
        ListView.builder(
          itemCount: messages.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 10,bottom: 10),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index){
            return Container(
              padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
              child: Align(
                alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (messages[index].messageType  == "receiver"?Colors.grey.shade200:Colors.blue[200]),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(messages[index].messageContent, style: TextStyle(fontSize: 15),),
                ),
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            height: 60,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 18,
                  ),
                  backgroundColor: Colors.blue,
                  elevation: 0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
