import 'package:flutter/material.dart';

class Mask extends StatefulWidget {
  @override
  _MaskState createState() => _MaskState();
}

class _MaskState extends State<Mask> {
  @override
  Widget build(BuildContext context) {
 return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color:Colors.black),
      ),
            body: Container(
        //width: MediaQuery.of(context).size.width *0.80,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  width: 150,
                  child: Image.asset('assets/logo_stop_coronavirus_rdc.png')),
              _textTitle("Quand utiliser un masque ?"),
              Divider(),
              Text(
                  "Si vous êtes en bonne santé, vous ne devez utiliser un masque que si vous vous occupez d’une personne présumée infectée par le 2019‑nCoV."),
              SizedBox(height: 5),
               Text(
                  "Portez un masque si vous toussez ou éternuez."),
                  SizedBox(height: 5),
               Text(
                  "Le masque n’est efficace que s’il est associé à un lavage des mains fréquent avec une solution hydroalcoolique ou à l’eau et au savon."),
                  SizedBox(height: 5),
               Text(
                  "Si vous portez un masque, il est important que vous sachiez l’utiliser et l’éliminer correctement."),
                  SizedBox(height: 30),
                  _textTitle("Comment mettre, utiliser, enlever et éliminer un masque?"),
              Divider(),
              Text("Avant de mettre un masque, se laver les mains avec une solution hydroalcoolique ou à l’eau et au savon"),
              SizedBox(height: 5),
              Text("Appliquer le masque de façon à recouvrir le nez et la bouche et veillez à l’ajuster au mieux sur votre visage"),
              SizedBox(height: 5),
              Text("Lorsque l’on porte un masque, éviter de le toucher; chaque fois que l’on touche un masque usagé, se laver les mains à l’aide d’une solution hydroalcoolique ou à l’eau et au savon"),
              SizedBox(height: 5),
              Text("Lorsqu’il s’humidifie, le remplacer par un nouveau masque et ne pas réutiliser des masques à usage unique"),
              SizedBox(height: 5),
              Text("Pour retirer le masque: l’enlever par derrière (ne pas toucher le devant du masque); le jeter immédiatement dans une poubelle fermée; se laver les mains avec une solution hydroalcoolique ou à l’eau et au savon"),
              SizedBox(height: 5),
            
            ],
          ),
        ),
      ),
    );
  }

    Widget _textTitle(label) {
    return Text(
      label,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          decorationStyle: TextDecorationStyle.solid),
    );
  }
  }