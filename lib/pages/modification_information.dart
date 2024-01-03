import 'package:flutter/material.dart';

class ModificationInformation extends StatefulWidget {
  const ModificationInformation({super.key});

  @override
  State<ModificationInformation> createState() =>
      _ModificationInformationState();
}

class _ModificationInformationState extends State<ModificationInformation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Spacer(),
            Text("Modifier les informations",
                style: TextStyle(color: Colors.indigoAccent)),
            Spacer()
          ],
        ),
        TextField(
          decoration: InputDecoration(
              hintText: "entrez votre nom",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(2))),
        ),
        Divider(),
        TextField(
          decoration: InputDecoration(
              hintText: " Dites nous un seccret",
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(2))),
        ),

      ],
    );
  }
}
