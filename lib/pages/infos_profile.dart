import 'package:flutter/material.dart';
import 'package:gestion_profil/pages/modification_information.dart';

class InfosProfile extends StatefulWidget {
  const InfosProfile({super.key});

  @override
  State<InfosProfile> createState() => _InfosProfileState();
}

class _InfosProfileState extends State<InfosProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mon profil")),
      body: Column(
        children: [
          Container(
            color: Colors.blueAccent,
            height: 270,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  rowProfile(libelle: "Nom", valeur: "Mamadou Diallo",size: 20),
                   rowProfile(libelle: "Age", valeur: "24",size: 20),
                  rowProfile(libelle: "Taille", valeur: "0", size: 20),
                  rowProfile(libelle: "Hobbiues", valeur: "Mamadou", size: 20),
                  Column(children: [
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("Langage de programmation favoris :",
                            style: TextStyle(fontSize: 20,color: Colors.white70))),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("dart", style: TextStyle(fontSize: 15,color: Colors.white70)),
                    ),
                  ]),
                  Padding(padding: EdgeInsets.all(8),
                  child: ElevatedButton(onPressed: (){print('mariam');}, child: Text("Montrer le secret")),),
                ],
              ),
            ),
          ),
          Divider(color: Colors.blueAccent,thickness: 2),
          ModificationInformation(),
        ],
      ),
    );
  }
  Row rowProfile({required String libelle, required String valeur,required double size}) {
    TextStyle style=TextStyle(fontSize: size,color: Colors.white70,fontStyle: FontStyle.italic);
    return Row(
      children: [Text("$libelle :",style: style), Text("$valeur",style: style)],
    );
  }
}
