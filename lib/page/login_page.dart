import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              child: RaisedButton(onPressed: () {
                Navigator.of(context).pushNamed('/form_login_page', arguments: {'formType':'login'});
              }, child: Text("Se connecter", style: TextStyle(color:Colors.white),),color: Colors.blue[900],),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.80,
            child: FlatButton(onPressed: (){
              Navigator.of(context).pushNamed('/form_login_page', arguments: {
                'formType':'subscribe'
              });
            }, child: Text("Creer son compte")),
            )
          ],
        ),
      ),
    );
  }
}
