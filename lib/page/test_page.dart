import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appcovid19/store/config_store.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List currentQuestion;
  Map questions;
  List<bool> reponses=[];
  Map index;

  String btnText = "Suivant";
  int indexQuestion = 0;

  int _radioValue = 0;

  void diagnostic() {
    Provider.of<ConfigStore>(context, listen: false).autoDiagnostic(input: reponses);

    Navigator.of(context).pushReplacementNamed('/result');
    
  }

  void checkedQuestions() {
    indexQuestion++;
    _radioValue==0?reponses.add(false):reponses.add(true);

    if (indexQuestion < questions.length) {
      currentQuestion = [
        {
          'index': questions[indexQuestion],
          'label': questions[index[indexQuestion]],
          'response': _radioValue,
        }
      ];
    } else {
      btnText = "Voir le diagnostic";
    }

    this.setState(() {});
  }

  void _handleRadioValueChange(int value) {
    this.setState(() {
      _radioValue = value;
    });
  }

  @override
  void initData() {
    questions =
        Provider.of<ConfigStore>(context, listen: false).questions;
    index = Provider.of<ConfigStore>(context, listen: false).index;

    currentQuestion = [
      {
        'index': questions[indexQuestion],
        'label': questions[index[indexQuestion]],
        'response': _radioValue,
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Depistage',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple[200],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _Questionlabel(),
              btnText != "Voir le diagnostic" ? _radioButton() : Text(''),
              SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                child: RaisedButton(
                  onPressed: () {
                    btnText != "Voir le diagnostic"
                        ? checkedQuestions()
                        : diagnostic();
                  },
                  child: Text(
                    btnText,
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.purple[300],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _Questionlabel() {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.80,
        child: Text(
          btnText != "Voir le diagnostic"
              ? currentQuestion[0]['label'].toString()
              : "Continuer pour voir un diagnostic rapide, si vos symptomes sont alarmantes, nous vous mettrons en contact avec un hopital",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 22,
          ),
          textAlign: TextAlign.center,
        ));
  }

  Widget _radioButton() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Radio(
          value: 1,
          groupValue: _radioValue,
          onChanged: _handleRadioValueChange,
        ),
        new Text(
          'Oui',
          style: new TextStyle(fontSize: 16.0),
        ),
        new Radio(
          value: 0,
          groupValue: _radioValue,
          onChanged: _handleRadioValueChange,
        ),
        new Text(
          'Non',
          style: new TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
