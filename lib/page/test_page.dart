import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appcovid19/store/config_store.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List currentQuestion;

  //questions label
  Map questionSymptomes;
  Map questionPronostics;

  //user input
  List<dynamic> inputQuestionSymptomes=[];
  List<dynamic> inputQuestionPronostics=[];

  //questions index
  Map questionSymptomesIndex;
  Map questionPronosticsIndex;

  String btnText = "Suivant";
  int indexQuestion=0;

  int _radioValue = 0;

  void diagnostic(){


  }

  void checkedQuestions() {
    indexQuestion++;

    if (indexQuestion < questionSymptomes.length) {
      currentQuestion = [
        {
          'index': questionSymptomesIndex[indexQuestion],
          'label': questionSymptomes[questionSymptomesIndex[indexQuestion]],
          'response':  _radioValue,
        }
      ];
    }
    else
    {
      btnText = "Voir le diagnostic";
    }

    this.setState((){});
  }

  void _handleRadioValueChange(int value) {
    this.setState(() {
      _radioValue = value;
    });
  }

  @override
  void initData() {
    questionSymptomes =
        Provider.of<ConfigStore>(context, listen: false).questionsSymptomes;

    questionSymptomesIndex = Provider.of<ConfigStore>(context, listen: false)
        .questionsSymptomesIndex;

    questionPronostics =
        Provider.of<ConfigStore>(context, listen: false).questionsPronostics;

    questionPronosticsIndex = Provider.of<ConfigStore>(context, listen: false)
        .questionsPronosticsIndex;

    print("DEBBUG ${questionSymptomesIndex[0]}");

    currentQuestion = [
      {
        'index': questionSymptomesIndex[indexQuestion],
        'label': questionSymptomes[questionSymptomesIndex[indexQuestion]],
        'response':  _radioValue,
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
              btnText != "Voir le diagnostic"?_radioButton():Text(''),
              SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                child: RaisedButton(
                  onPressed: () {
                    btnText != "Voir le diagnostic"?
                    checkedQuestions():
                    diagnostic();

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

  Widget _Questionlabel(){

    return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: 
                  
                  Text(
                    btnText != "Voir le diagnostic"?
                    currentQuestion[0]['label'].toString():
                    "Continuer pour voir un diagnostic rapide, si vos symptomes sont alarmantes, nous vous mettrons en contact avec un hopital",
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
