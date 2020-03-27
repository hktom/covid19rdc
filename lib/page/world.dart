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

  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text("Situation de Covid-19 dans le monde",
      style: TextStyle(fontSize: 14, color: Colors.white));
  final TextEditingController _filter = new TextEditingController();

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          onChanged: (value) {
            filterSearchResults(value);
          },
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: "Taper le nom d'un pays..."),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text("Situation de Covid-19 dans le monde",
            style: TextStyle(fontSize: 14, color: Colors.white));
        //filteredNames = names;
        _filter.clear();
        setState(() {
          itemList = worldCurrentSituation;
        });
      }
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
      appBar: AppBar(
        title: _appBarTitle,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.red[400],
        elevation: 0.0,
        actions: <Widget>[
          new IconButton(
            icon: _searchIcon,
            onPressed: _searchPressed,
          ),
        ],
      ),
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
