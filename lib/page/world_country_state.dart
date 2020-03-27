import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appcovid19/store/config_store.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:badges/badges.dart';

class WorldCountryState extends StatefulWidget {
  @override
  _WorldCountryStateState createState() => _WorldCountryStateState();
}

class _WorldCountryStateState extends State<WorldCountryState> {
  Widget _Textlabel(label) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.80,
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 22,
          ),
          textAlign: TextAlign.center,
        ));
  }

  Widget _listTile({icon, total, label}) {
    return ListTile(
      leading: FaIcon(
        icon,
        color: Colors.black,
      ),
      title: Text(label),
      trailing: Badge(
        badgeContent: Text(
          total==null?0.toString():total.toString(),
          style: TextStyle(color: Colors.white),
        ),
        shape: BadgeShape.square,
      ),
    );
  }

  Widget _renderListItem(item) {
    final cases = item["cases"];
    final death = item["deaths"];
    final day = item["day"];
    final time = item["time"];

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Column(
        children: <Widget>[
          _listTile(
              icon: FontAwesomeIcons.notesMedical,
              label: "Nouveau Cas",
              total: cases["new"]),
          Divider(),
          _listTile(
              icon: FontAwesomeIcons.stethoscope,
              label: "Malade",
              total: cases["active"]),
          Divider(),
          _listTile(
              icon: FontAwesomeIcons.ambulance,
              label: "Etat critique",
              total: cases["critical"]),
          Divider(),
          _listTile(
              icon: FontAwesomeIcons.userInjured,
              label: "Guéris",
              total: cases["recovered"]),
          Divider(),
          _listTile(
              icon: FontAwesomeIcons.procedures,
              label: "Decèdé",
              total: death["total"]),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;
    dynamic country = args["country"];

    return Scaffold(
            appBar: AppBar(
              centerTitle: true,
        title: Text(country["country"], style:TextStyle(fontSize: 20, color:Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.red[400],
        elevation: 0.0,
        actions: <Widget>[],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _renderListItem(country),
              SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Revenir à la liste',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red[400],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
