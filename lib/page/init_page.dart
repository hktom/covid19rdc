import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appcovid19/store/config_store.dart';

class InitPage extends StatefulWidget {
  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {

  String status='null';
  String error="connexion...";

  Future<void> initData() async {
    await Provider.of<ConfigStore>(context, listen: false).worldState();
    await Provider.of<ConfigStore>(context, listen: false).rdcState();
    
    if(Provider.of<ConfigStore>(context, listen: false).loadData=="DATA_HAS_LOADED")
    {
      return Navigator.of(context).pushReplacementNamed('/home_page');
    }

    if(Provider.of<ConfigStore>(context, listen: false).loadData=="DATA_HAS_NOT_LOADED")
    {
      return this.setState((){
        error="Erreur de connection";
        });
    }

  }
  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                child: Image.asset('assets/logo_stop_coronavirus_rdc.png'),
              ),
              flex: 0,
            ),
            SizedBox(height:40),
            Text(error),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}