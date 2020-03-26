import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:provider/provider.dart';
import 'package:appcovid19/store/config_store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _renderCardButton({label, icon, colors, link}) {
    return TouchableOpacity(
      onTap: () {
        link != "#" ? Navigator.of(context).pushNamed(link) : print('');
      },
      child: Container(
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 3),
        //color: Colors.red,
        decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //Icon(icon(icon)),
              Icon(
                icon,
                color: Colors.white,
              ),
              Text(
                label,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void menuLink(link)
  {
    Navigator.of(context).push(link);
  }

  Widget _renderGrid_one() {
    return Row(
      children: <Widget>[
        Expanded(
          child: _renderCardButton(
              label: "Confirmé 45",
              icon: Icons.local_hospital,
              colors: Colors.orange[400],
              link: "#"),
          flex: 1,
        ),
        Expanded(
          child: _renderCardButton(
              label: "Guéris 1",
              icon: Icons.supervised_user_circle,
              colors: Colors.green[200],
              link: "#"),
          flex: 1,
        ),
        Expanded(
          child: _renderCardButton(
              label: "Décès 3",
              icon: Icons.departure_board,
              colors: Colors.blue[200],
              link: "#"),
          flex: 1,
        ),
      ],
    );
  }

  Widget _renderGrid_two() {
    return Row(
      children: <Widget>[
        Expanded(
          child: _renderCardButton(
              label: "Actif 41",
              icon: Icons.perm_identity,
              colors: Colors.red[400],
              link: "#"),
          flex: 1,
        ),
        Expanded(
          child: _renderCardButton(
              label: "Despistage",
              icon: Icons.store_mall_directory,
              colors: Colors.purple[200],
              link: "/test_page"),
          flex: 1,
        ),
        Expanded(
          child: _renderCardButton(
              label: "Signaler",
              icon: Icons.add_alert,
              colors: Colors.green[200],
              link: "/report_page"),
          flex: 1,
        ),
      ],
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

  Widget _menuDrawer(){

    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                image: DecorationImage(
                    image: AssetImage("assets/urgent_covid.jpeg"),
                    fit: BoxFit.cover),
              ),
              child: Text(''),
            ),
            ListTile(
              leading: Icon(Icons.polymer),
              title: Text("Comment se proteger"),
              onTap: (){
                Navigator.of(context).pushNamed("/protection");
                },
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text("Comment utiliser un masque"),
              onTap: (){
                Navigator.of(context).pushNamed("/mask");
              },
            ),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text("Se deconnecter"),
              onTap: () async {
                await Provider.of<ConfigStore>(context, listen: false).logout();
                Navigator.of(context).pushReplacementNamed("/login_page");
              },
            ),
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[],
      ),
      drawer: _menuDrawer(),
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
              SizedBox(height: 20),
              _renderGrid_one(),
              SizedBox(height: 20),
              _renderGrid_two(),
              SizedBox(height: 30),
              _textTitle("Qu’est-ce qu’un coronavirus ?"),
              Divider(),
              Text(
                  "Les coronavirus forment une vaste famille de virus qui peuvent être pathogènes chez l’homme et chez l’animal. On sait que, chez l’être humain, plusieurs coronavirus peuvent entraîner des infections respiratoires dont les manifestations vont du simple rhume à des maladies plus graves comme le syndrome respiratoire du Moyen-Orient (MERS) et le syndrome respiratoire aigu sévère (SRAS). Le dernier coronavirus qui a été découvert est responsable de la maladie à coronavirus 2019 (COVID-19)."),
              SizedBox(height: 30),
              _textTitle("Quels sont les symptômes de la COVID-19 ?"),
              Divider(),
              Text(
                  "Les symptômes les plus courants de la COVID-19 sont la fièvre, la fatigue et une toux sèche. Certains patients présentent des douleurs, une congestion nasale, un écoulement nasal, des maux de gorge ou une diarrhée. Ces symptômes sont généralement bénins et apparaissent de manière progressive. Certaines personnes, bien qu’infectées, ne présentent aucun symptôme et se sentent bien. La plupart (environ 80 %) des personnes guérissent sans avoir besoin de traitement particulier. Environ une personne sur six contractant la maladie présente des symptômes plus graves, notamment une dyspnée. Les personnes âgées et celles qui ont d’autres problèmes de santé (hypertension artérielle, problèmes cardiaques ou diabète) ont plus de risques de présenter des symptômes graves. Toute personne qui a de la fièvre, qui tousse et qui a des difficultés à respirer doit consulter un médecin."),
              SizedBox(height: 30),
              _textTitle("Quels sont les symptômes de la COVID-19 ?"),
              Divider(),
              Text(
                  "Les symptômes les plus courants de la COVID-19 sont la fièvre, la fatigue et une toux sèche. Certains patients présentent des douleurs, une congestion nasale, un écoulement nasal, des maux de gorge ou une diarrhée. Ces symptômes sont généralement bénins et apparaissent de manière progressive. Certaines personnes, bien qu’infectées, ne présentent aucun symptôme et se sentent bien. La plupart (environ 80 %) des personnes guérissent sans avoir besoin de traitement particulier. Environ une personne sur six contractant la maladie présente des symptômes plus graves, notamment une dyspnée. Les personnes âgées et celles qui ont d’autres problèmes de santé (hypertension artérielle, problèmes cardiaques ou diabète) ont plus de risques de présenter des symptômes graves. Toute personne qui a de la fièvre, qui tousse et qui a des difficultés à respirer doit consulter un médecin."),
              SizedBox(height: 30),
              _textTitle("Comment la COVID-19 se propage-t-elle ?"),
              Divider(),
              Text(
                  "La COVID-19 est transmise par des personnes porteuses du virus. La maladie peut se transmettre d’une personne à l’autre par le biais de gouttelettes respiratoires expulsées par le nez ou par la bouche lorsqu’une personne tousse ou éternue. Ces gouttelettes peuvent se retrouver sur des objets ou des surfaces autour de la personne en question. On peut alors contracter la COVID-19 si on touche ces objets ou ces surfaces et si on se touche ensuite les yeux, le nez ou la bouche. Il est également possible de contracter la COVID-19 en inhalant des gouttelettes d’une personne malade qui vient de tousser ou d’éternuer. C’est pourquoi il est important de se tenir à plus d’un mètre d’une personne malade."),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
