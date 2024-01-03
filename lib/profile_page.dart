import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:gestion_profil/models/profile.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  Profile myProfile =
      Profile(surname: "Mamadou", name: "Diallo", secret: "Je suis secret");
  late TextEditingController surname;
  late TextEditingController name;
  late TextEditingController secret;
  late TextEditingController age;

  bool showSecret = true;

  Map<String, bool> hobbies = {
    "Petanque": false,
    "Football": false,
    "Rugby": false,
    "Manga": false,
    'Food': false,
  };
  ImagePicker picker =new ImagePicker();
  File? imageFile;
  @override
  void initState() {
    super.initState();
    surname = TextEditingController();
    name = TextEditingController();
    secret = TextEditingController();
    age = TextEditingController();
    age.text=myProfile.age.toString();
    surname.text = myProfile.surname;
    name.text = myProfile.name;
    secret.text = myProfile.secret;
  }

  @override
  void dispose() {
    surname.dispose();
    name.dispose();
    secret.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double imageSize=MediaQuery.of(context).size.width/4;
    return Scaffold(
      appBar: AppBar(title: Text("Mon Profil")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Card(
                color: Colors.indigo,
                elevation: 10,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(myProfile.setName()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            child: (imageFile==null) ? Image.network("https://www.leparisien.fr/resizer/kFX1f5M7en6IOi4MaV_Duy44fYw=/932x582/cloudfront-eu-central-1.images.arcpublishing.com/leparisien/7NWKF2BBQZEAFGLDCNCLTNGQCQ.jpg") : Image.file(imageFile!,height: imageSize,width: imageSize),
                          ),
                          Column(
                            children: [
                              Text("Age ${myProfile.setAge()}"),
                              Text("Taille ${myProfile.setHeignt()}"),
                              Text("Genre ${myProfile.genderString()}"),
                            ],
                          )
                        ],
                      ),

                      Text("Hobbies ${myProfile.setHobbies()}"),
                      Text(
                          "Langage de programmation favoris ${myProfile.favoriteLang}"),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showSecret = !showSecret;
                            });
                          },
                          child: Text((showSecret)
                              ? "Cacher le secret"
                              : "Montrer le secret")),
                      (showSecret)
                          ? Text(myProfile.secret)
                          : Container(width: 0, height: 0),
                    ],
                  ),
                )),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: (()=>getImage(source: ImageSource.camera)), icon: Icon(Icons.camera_alt_rounded)),
                IconButton(onPressed: (()=>getImage(source: ImageSource.gallery)), icon: Icon(Icons.photo_album_rounded))
              ],
            ),
            Divider(
              color: Colors.deepOrangeAccent,
              thickness: 2,
            ),
            myTitle("Modifier les infos"),
            myTextField(controller: surname, hint: "Entrer votre prenom"),
            myTextField(controller: name, hint: "Entrer votre nom"),
            myTextField(
                controller: secret,
                hint: "Entrer votre secret",
                isSecret: true),
            myTextField(controller: age, hint: "Entrer votre age",type: TextInputType.number),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Genre : ${myProfile.genderString()}"),
                Switch(
                    value: myProfile.gender,
                    onChanged: (newBool) {
                      setState(() {
                        myProfile.gender = newBool;
                      });
                    })
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Taille : ${myProfile.setHeignt()}"),
                Slider(
                    value: myProfile.height,
                    min: 0,
                    max: 250,
                    onChanged: (newHeight) {
                      setState(() {
                        myProfile.height = newHeight;
                      });
                    })
              ],
            ),
            myHobbies(),
            Divider(
              color: Colors.deepOrangeAccent,
              thickness: 2,
            ),
            myRadios(),
          ],
        ),
      ),
    );
  }

  TextField myTextField(
      {required TextEditingController controller,
      required String hint,
      bool isSecret = false,TextInputType type=TextInputType.text}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hint),
      keyboardType: type,
      obscureText: isSecret,
      onSubmitted: ((value) => {updateUser()}),
    );
  }

  updateUser() {
    setState(() {
      myProfile = Profile(
          surname: (surname.text != myProfile.surname)
              ? surname.text
              : myProfile.surname,
          name: name.text,
          secret: secret.text);
    });
  }

  updateSecret() {
    setState(() {
      showSecret = !showSecret;
    });
    print("hello");
  }

  Column myHobbies() {
    List<Widget> widgets = [myTitle("Mes Hobbies")];
    hobbies.forEach((hobby, like) {
      Row r = Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(hobby),
          Checkbox(
              value: like,
              onChanged: (newBool) {
                setState(() {
                  hobbies[hobby] = newBool ?? false;
                  List<String> str = [];
                  hobbies.forEach((key, value) {
                    if (value == true) {
                      str.add(key);
                    }
                  });
                  myProfile.hobbies = str;
                });
              })
        ],
      );
      widgets.add(r);
    });

    return Column(
      children: widgets,
    );
  }

  Row myRadios() {
    List<Widget> w = [myTitle("Langage préféré")];
    List<String> langs=["Dart","Swift","Kotlin","Java","Python"];
    int index =langs.indexWhere((lang) => lang.startsWith(myProfile.favoriteLang));
    for(var x=0;x < langs.length;x++){
      Column c =Column(

        children: [
          Text(langs[x]),
          Radio(value: x, groupValue: index, onChanged: (newValue){
            setState(() {
              myProfile.favoriteLang=langs[newValue as int];
            });
          })
        ],
      );
      w.add(c);
    }
    return Row(
      children: w,
    );
  }

  Text myTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
  Future getImage({required ImageSource source}) async {
    final chosenFile= await picker.pickImage(source:source);
    {
       setState(() {
         if(chosenFile==null){
           print("Je n'ai rien ajouté");
         }else{
          imageFile= File(chosenFile.path);
         }
       });
    }
  }
}
