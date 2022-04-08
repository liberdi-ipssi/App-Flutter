import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_application_1/fonctions/firestoreHelper.dart';
import 'package:flutter_application_1/library/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class myDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return myDrawerState();
  }
}

class myDrawerState extends State<myDrawer>
    with SingleTickerProviderStateMixin {
  //variable
  String? cheminImage;
  String? nomImage;
  Uint8List? dataImage;
  bool click = false;

  late Animation animation;
  late AnimationController controller;

  boiteDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          if (Platform.isIOS) {
            return CupertinoAlertDialog(
              title: Text("Souhaitez-vous enregistrer l'image"),
              content: Image.memory(dataImage!),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Annuler")),
                ElevatedButton(
                    onPressed: () {
                      FirestoreHelper()
                          .stockage(nomImage!, dataImage!)
                          .then((value) {
                        setState(() {
                          cheminImage = value;
                          monProfil.logo = cheminImage;

                          Map<String, dynamic> map = {"LOGO": cheminImage};
                          FirestoreHelper().updateUser(monProfil.uid, map);
                        });
                      });
                      Navigator.pop(context);
                    },
                    child: Text("Enregistrer")),
              ],
            );
          } else {
            return AlertDialog(
              title: Text("Souhaitez-vous enregistrer l'image"),
              content: Image.memory(dataImage!),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Annuler")),
                ElevatedButton(
                    onPressed: () {
                      FirestoreHelper()
                          .stockage(nomImage!, dataImage!)
                          .then((value) {
                        setState(() {
                          cheminImage = value;
                          monProfil.logo = cheminImage;
                          Map<String, dynamic> map = {"LOGO": cheminImage};
                          FirestoreHelper().updateUser(monProfil.uid, map);
                        });
                      });
                    },
                    child: Text("Enregistrer")),
              ],
            );
          }
        });
  }

  recuperImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);
    if (result != null) {
      print("J'ai récupérer une image");
      setState(() {
        nomImage = result.files.first.name;
        dataImage = result.files.first.bytes;
        boiteDialog();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2),
        reverseDuration: Duration(seconds: 5))
      ..repeat();
    animation = Tween<double>(begin: 0, end: 150).animate(controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(20),
      child: bodyPage(),
    ));
  }

  Widget bodyPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //image récupéré

        (dataImage == null)
            ? Container()
            : Container(
                decoration: BoxDecoration(
                    image: DecorationImage(image: MemoryImage(dataImage!))),
              ),

        //logo
        InkWell(
          child: AnimatedContainer(
            duration: Duration(seconds: 2),
            curve: Curves.easeOutSine,
            height: (click) ? 50 : 150,
            width: (click) ? 50 : 150,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: (monProfil.logo != null)
                      ? NetworkImage(monProfil.logo!)
                      : NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/projetsqyavril2022.appspot.com/o/noImage.png?alt=media&token=dc26627a-5c9f-491b-8529-c8b44bfad00a"),
                  fit: BoxFit.fill,
                )),
          ),
          onTap: () {
            recuperImage();
            setState(() {
              click = !click;
            });
          },
        ),

        SizedBox(
          height: 10,
        ),

        //Nom et le prénom
        Text("${monProfil.prenom} ${monProfil.nom}")
      ],
    );
  }
}
