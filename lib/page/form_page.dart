import 'package:appcovid19/store/config_store.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:provider/provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

class LoginFormPage extends StatefulWidget {
  @override
  _LoginFormPageState createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> {
  final _formKey = GlobalKey<FormState>();
  final Map myuserData={};
  ProgressDialog activityDialog;
  String status='null';

  Future<void> signin()async{
    activityDialog.show();
    await Provider.of<ConfigStore>(context, listen: false).signin(myuserData);
    status=Provider.of<ConfigStore>(context, listen: false).login;
    if(status=='IS_LOGIN'){
      Navigator.of(context).pushReplacementNamed('/home_page');
        }
        else
        {
          this.setState((){});
          activityDialog.hide();
        }
  }

  Future<void> signup()async{
    activityDialog.show();
    await Provider.of<ConfigStore>(context, listen: false).signup(myuserData);
    status=Provider.of<ConfigStore>(context, listen: false).login;
    if(status=='IS_LOGIN'){
      Navigator.of(context).pushReplacementNamed('/home_page');
        }
        else
        {
          this.setState((){});
          activityDialog.hide();
        }
    
  }

  Widget _renderFormLogin() {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          SizedBox(height: 20),
          Text('Se connecter'),
          textField(
              type: 'email',
              error: 'email ne reste pas vide',
              fieldvalue: 'email'),

          textField(
              type: 'password',
              error: 'password ne reste pas vide',
              fieldvalue: 'password'),

          SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              child: RaisedButton(onPressed: () {
                 if (_formKey.currentState.validate()) {
                    signin();
                 }
              }, child: Text("Se connecter", style: TextStyle(color:Colors.white),),color: Colors.blue[900],),
            ),


          
        ]));
  }

    Widget _renderFormSubscribe() {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          SizedBox(height: 20),
          Text('Creer son compte'),
          textField(
              type: 'Nom Complet',
              error: 'nom ne reste pas vide',
              fieldvalue: 'Nom'),

          textField(
              type: 'Numero de telephone',
              error: 'phone ne reste pas vide',
              fieldvalue: 'phone'),

           textField(
              type: 'Age',
              error: 'age ne reste pas vide',
              fieldvalue: 'age'),

          textField(
              type: 'email',
              error: 'email ne reste pas vide',
              fieldvalue: 'email'),  

          _selectField(),  

          textField(
              type: 'password',
              error: 'password ne reste pas vide',
              fieldvalue: 'password'),

          SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              child: RaisedButton(onPressed: () {
                if (_formKey.currentState.validate()) {
                    signup();
                 }
              }, child: Text("Je creer mon compte", style: TextStyle(color:Colors.white),),color: Colors.blue[900],),
            ),
          
        ]));
  }

    void showToast(String msg) {
        Toast.show(msg, context, duration: 3, gravity:  Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context).settings.arguments;
    activityDialog=new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    status=='null'?print(''):showToast(status);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  child: Image.asset('assets/logo_stop_coronavirus_rdc.png'),
                ),
                flex: 0,
              ),
              args['formType']=="login"?
              _renderFormLogin(): _renderFormSubscribe(),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget textField({type, error, fieldvalue}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.80,
      child: TextFormField(
        obscureText: type == 'password' ? true : false,
        decoration: InputDecoration(
          labelText: fieldvalue,
        ),
        onChanged: (value){
          setState(() {
            myuserData[type]=value;
          });
        },
        validator: (value) {
          if (value.isEmpty) {
            return error.toString();
          }
          return null;
        },
      ),
    );
  }

  Widget _selectField(){
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.80,
      child: DropDownFormField(
                  required: true,
                  titleText: 'Genre',
                  value: myuserData['sexe'],
                  onChanged: (value) {
                    setState(() {
                      myuserData['sexe'] = value;
                    });
                  },
                  dataSource: [
                    {
                      "display": "Homme",
                      "value": "M",
                    },
                    {
                      "display": "Femme",
                      "value": "F",
                    },
                    
                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
    );
  }
}
