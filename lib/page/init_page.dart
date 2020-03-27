import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appcovid19/store/config_store.dart';

class InitPage extends StatefulWidget {
  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {

  String status='null';

  Future<void> initData() async {
    //await Provider.of<ConfigStore>(context, listen: false).isLogin();
    //status=Provider.of<ConfigStore>(context, listen: false).login;
    // if(status=='IS_LOGIN'){
    //   Navigator.of(context).pushReplacementNamed('/home_page');
    //     }
    //     else
    //     {
    //       Navigator.of(context).pushReplacementNamed('/login_page');

    //     }
    await Provider.of<ConfigStore>(context, listen: false).worldState();
    await Provider.of<ConfigStore>(context, listen: false).rdcState().then((result){
      Navigator.of(context).pushReplacementNamed('/home_page');
    });
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
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}