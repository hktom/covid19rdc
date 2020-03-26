import 'package:flutter/material.dart';

class Protection extends StatefulWidget {
  @override
  _ProtectionState createState() => _ProtectionState();
}

class _ProtectionState extends State<Protection> {
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
              _textTitle("Se laver fréquemment les mains"),
              Divider(),
              Text(
                  "Se laver fréquemment les mains avec une solution hydroalcoolique ou à l’eau et au savon Pourquoi? Se laver les mains avec une solution hydroalcoolique ou à l’eau et au savon tue le virus s’il est présent sur vos mains."),
              SizedBox(height: 30),
              _textTitle("Éviter les contacts proches"),
              Divider(),
              Text(
                  "Maintenir une distance d’au moins 1 mètre avec les autres personnes, en particulier si elles toussent, éternuent ou ont de la fièvre"),
              SizedBox(height: 5),
              Text("Pourquoi? Lorsqu’une personne infectée par un virus respiratoire, comme la COVID-19, tousse ou éternue, elle projette de petites gouttelettes contenant le virus. Si vous êtes trop près, vous pouvez inhaler le virus."),
              SizedBox(height: 30),
              _textTitle("Éviter de se toucher les yeux, le nez et la bouche."),
              Divider(),
              Text(
                  "Pourquoi? Les mains sont en contact avec de nombreuses surfaces qui peuvent être contaminées par le virus. Si vous vous touchez les yeux, le nez ou la bouche, vous risquez d’être en contact avec le virus présent sur ces surfaces."),
              SizedBox(height: 30),
              _textTitle("Respecter les règles d’hygiène respiratoire"),
              Divider(),
              Text(
                  "Se couvrir la bouche et le nez avec le pli du coude ou avec un mouchoir en cas de toux ou d’éternuement – jeter le mouchoir immédiatement après dans une poubelle fermée et se laver les mains avec une solution hydroalcoolique ou à l’eau et au savon."),
              SizedBox(height: 5),
              Text("Pourquoi ? Se couvrir la bouche et le nez en cas de toux ou d’éternuement permet d’éviter la propagation des virus et autres agents pathogènes."),
              SizedBox(height: 30),
              SizedBox(height: 30),
              _textTitle("Tenez-vous informé et suivez les conseils de votre médecin"),
              Divider(),
              Text(
                  "Tenez-vous au courant des dernières évolutions concernant la COVID-19. Suivez les conseils de votre médecin, des autorités de santé nationales et locales ou de votre employeur pour savoir comment vous protéger et protéger les autres de la COVID-19."),
              SizedBox(height: 5),
              Text("Pourquoi ? Ce sont les autorités nationales et locales qui disposent des informations les plus récentes sur la propagation ou non de la COVID-19 dans la région où vous vous trouvez. Elles sont les mieux placées pour expliquer ce que les personnes dans votre région devraient faire pour se protéger."),
              SizedBox(height: 30),
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