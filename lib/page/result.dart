import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appcovid19/store/config_store.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _Textlabel(Provider.of<ConfigStore>(context, listen: false)
                .resultTest
                .toString()),
            SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/home_page');
                },
                child: Text(
                  'Revenir au home',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.purple[300],
              ),
            )
          ],
        ),
      ),
    );
  }
}
