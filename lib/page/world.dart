import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:provider/provider.dart';
import 'package:appcovid19/store/config_store.dart';
import 'package:badges/badges.dart';

class World extends StatefulWidget {
  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> {
  List<dynamic> worldCurrentSituation = [];
  List<dynamic> dummySearchList = [];
  List<dynamic> dummyList = [];
  List<dynamic> itemList = [];
  String appbar="simpleappbar";

  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text("Situation de Covid-19 dans le monde",
      style: TextStyle(fontSize: 14, color: Colors.white));
  final TextEditingController _filter = new TextEditingController();

  AppBar _simpleAppBar() {
    return AppBar(
      title: new Text("Situation de Covid-19 dans le monde",
          style: TextStyle(fontSize: 14, color: Colors.white)),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.red[400],
      elevation: 0.0,
      actions: <Widget>[
        new IconButton(
          icon: Icon(Icons.search),
          onPressed: ()=>_searchPressed("searchappbar"),
        ),
      ],
    );
  }

  AppBar _searchAppBar() {
    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.close), onPressed: () => _searchPressed("simpleappbar")),
      title: TextField(
        autofocus: true,
        onChanged: (value) {
          filterSearchResults(value);
        },
        controller: _filter,
        decoration: new InputDecoration(
            fillColor: Colors.white,
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
            hintText: "Chercher un pays..."),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.red[400],
      elevation: 0.0,
    );
  }

  void _searchPressed(appbar) {
    setState(() {
      this.appbar=appbar;
      this.itemList = worldCurrentSituation;
    });
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      worldCurrentSituation.forEach((item) {
        if (item['country'] == query) {
          dummySearchList = [];
          dummySearchList.add(item);
          setState(() {
            itemList = dummySearchList;
          });
        }
      });
    } else {
      setState(() {
        itemList = worldCurrentSituation;
      });
    }
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

  Widget _listItem(item) {
    final country = item["country"];
    final dateupate = item["day"];
    final total = item["cases"]["total"];
    return ListTile(
      onTap: () {
        Navigator.of(context)
            .pushNamed('/world_country_state', arguments: {'country': item});
      },
      title: Text(country),
      subtitle: Text("$dateupate"),
      trailing: Badge(
        badgeContent: Text(
          total.toString(),
          style: TextStyle(color: Colors.white),
        ),
        shape: BadgeShape.square,
      ),
    );
  }

  void initState() {
    worldCurrentSituation =
        Provider.of<ConfigStore>(context, listen: false).worldCurrentSituation;
    itemList =
        Provider.of<ConfigStore>(context, listen: false).worldCurrentSituation;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: this.appbar=="simpleappbar"?_simpleAppBar():_searchAppBar(),
      body: Container(
          //width: MediaQuery.of(context).size.width *0.80,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: itemList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Column(
                  children: <Widget>[
                    _listItem(itemList[index]),
                    Divider(),
                  ],
                );
              })),
    );
  }
}
