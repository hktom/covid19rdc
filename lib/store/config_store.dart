import 'dart:convert';
import 'dart:io';
import 'package:appcovid19/ressource/userAuth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigStore extends ChangeNotifier {
  String login = "NULL";
  String loadData = "NULL";
  dynamic userData;
  Map<String, dynamic> currentSituation = {};
  List<dynamic> worldCurrentSituation = [];

  String resultTest;
  String resultReport;

  Map questions = {
    'fievre':
        'Pensez-vous avoir eu de la fièvre ces derniers jours (frissons, sueurs) ?',
    'toux':
        'Avez-vous une toux ou une augmentation de votre toux habituelle ces derniers jours ?',
    'courbature':
        'Avez-vous des douleurs musculaires ou des courbatures inhabituelles ces derniers jours ?',
    'gorge': 'Avez-vous un mal de gorge apparu ces derniers jours ?',
    'diarrhee':
        'Avez-vous de la diarrhée ces dernièrs 24 heures (au moins 3 selles molles) ?',
    'fatigue': 'Avez-vous une fatigue inhabituelle ces derniers jours ?',
    'alimentation':
        'Avez-vous des difficultés importantes pour vous alimenter ou boire depuis plus de 24h? ',
    'respiratoire':
        'Avez-vous vu apparaître une gêne respiratoire ou une augmentation de votre gêne respiratoire habituelle ? ',
    'age': 'Avez-vous plus de 50 ans?',
    'poids': 'Pesez-vous plud de 70Kg ?',
    'cardiaque':
        'Avez-vous de l’hypertension artérielle ? Ou avez-vous une maladie cardiaque ou vasculaire ? Ou prenez-vous un traitement à visée cardiologique ? ',
    'diabetique': 'Êtes-vous diabétique ?',
    'cancer': 'Avez-vous ou avez-vous eu un cancer ?',
    'pneumologue':
        'Avez-vous une maladie respiratoire ? Ou êtes-vous suivi par un pneumologue ? ',
    'dialyse': 'Avez-vous une insuffisance rénale chronique dialysée ? ',
    'foie': 'Avez-vous une maladie chronique du foie ?',
    'grossesse': 'Êtes-vous enceinte ?',
    'defense':
        'Avez-vous une maladie connue pour diminuer vos défenses immunitaires',
    'traitement':
        'Prenez-vous un traitement immunosuppresseur ? C’est un traitement qui diminue vos défenses contre les infections. Voici quelques exemples : corticoïdes, méthotrexate,ciclosporine, tacrolimus, azathioprine, cyclophosphamide (liste non exhaustive). '
  };

  Map questionsAlert = {
    'fievre': 'La personne a t-elle de la fièvre ?',
    'toux':
        'A t-elle une toux ou une augmentation de la toux habituelle ces derniers jours ?',
    'courbature':
        'A t-elle des douleurs musculaires ou des courbatures inhabituelles ces derniers jours ?',
    'gorge': 'A t-elle un mal de gorge apparu ces derniers jours ?',
    'diarrhee':
        'A t-elle de la diarrhée ces dernièrs 24 heures (au moins 3 selles molles) ?',
    'fatigue': 'A t-elle une fatigue inhabituelle ces derniers jours ?',
    'alimentation':
        'Avez-vous des difficultés importantes pour vous alimenter ou boire depuis plus de 24h? ',
    'respiratoire':
        'A t-elle vu apparaître une gêne respiratoire ou une augmentation de son gêne respiratoire habituelle ? ',
    'age': 'A t-elle plus de 50 ans?',
    'poids': 'A t-elle plud de 70Kg ?',
    'diabetique': 'Est t-elle diabétique ?',
    'cancer': 'A t-elle ou avait elle eu un cancer ?',
    'pneumologue': 'A t-elle une maladie respiratoire ?',
    'dialyse': 'A t-elle une insuffisance rénale chronique dialysée ? ',
    'foie': 'A t-elle une maladie chronique du foie ?',
    'grossesse': 'Est t-elle enceinte ?',
    'defense':
        'A t-elle une maladie connue pour diminuer ses défenses immunitaires',
    'traitement':
        'Prend t un traitement immunosuppresseur ? C’est un traitement qui diminue vos défenses contre les infections. Voici quelques exemples : corticoïdes, méthotrexate,ciclosporine, tacrolimus, azathioprine, cyclophosphamide (liste non exhaustive). '
  };

  Map index = {
    0: 'fievre',
    1: 'toux',
    2: 'courbature',
    3: 'gorge',
    4: 'diarrhee',
    5: 'fatigue',
    6: 'alimentation',
    7: 'respiratoire',
    8: 'age',
    9: 'poids',
    10: 'cardiaque',
    11: 'diabetique',
    12: 'cancer',
    13: 'pneumologue',
    14: 'dialyse',
    15: 'foie',
    16: 'grossesse',
    17: 'defense',
    18: 'traitement',
  };

  void autoDiagnostic({List<bool> input}) {
    if ((input[0] || input[1]) &&
        (input[1] || input[3]) &&
        (input[2] || input[0]) &&
        input[4]) {
      resultTest =
          "nous vous conseillons de rester à votre domicile et de contacter votre médecin en cas d’apparition de nouveaux symptômes. Vous pourrez aussi utiliser à nouveau l’application pour réévaluer vos symptômes.";
    } else {
      resultTest =
          "Votre situation ne relève probablement pas du Covid-19. N’hésitez pas à contacter votre médecin en cas de doute. Vous pouvez refaire le test en cas de nouveau symptôme pour réévaluer la situation. Pour toute information concernant le Covid-19, composer le 222.";
    }
  }

  void AlertDiagnostic({List<bool> input}) {
    if ((input[0] || input[1]) &&
        (input[1] || input[3]) &&
        (input[2] || input[0]) &&
        input[4]) {
      resultTest =
          "nous vous conseillons de rester à votre domicile et de contacter votre médecin en cas d’apparition de nouveaux symptômes. Vous pourrez aussi utiliser à nouveau l’application pour réévaluer vos symptômes.";
    } else {
      resultTest =
          "Sa situation ne relève probablement pas du Covid-19. N’hésitez pas à contacter votre médecin en cas de doute. Vous pouvez refaire le test en cas de nouveau symptôme pour réévaluer la situation. Pour toute information concernant le Covid-19, composer le 222.";
    }
  }

  dynamic _read(filename) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$filename');
      dynamic data = await file.readAsString();
      return data;
    } catch (e) {
      print(e.toString());
    }
  }

  _save(filename, data) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$filename');
    await file.writeAsString(data);
  }

  Future<void> worldState() async {
    try {
      var url = 'https://covid-193.p.rapidapi.com/statistics';
      var headers = {
        "x-rapidapi-host": "covid-193.p.rapidapi.com",
        "x-rapidapi-key": "3057aea93cmsh39f0c368e02c27ep1bb0eajsn72c57e6469ac"
      };
      dynamic response = await http.get(url, headers: headers);
      worldCurrentSituation = json.decode(response.body)['response'];

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('worldCurrentSituation', response.toString());
      // loadData = "DATA_HAS_LOADED";
    } catch (e) {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // dynamic response = prefs.getString('worldCurrentSituation');
      // worldCurrentSituation = json.decode(response.body)['response'];
      loadData = "DATA_HAS_NOT_LOADED";
    }
  }

  Future<void> rdcState() async {
    try {
      var url = 'https://stopcoronavirusrdc.info/api/lastpandemicstat';
      dynamic response = await http.get(url);
      currentSituation = json.decode(response.body)['data'];
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('currentSituation', response.toString());
      loadData = "DATA_HAS_LOADED";
    } catch (e) {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // dynamic response = prefs.getString('currentSituation');
      // currentSituation = json.decode(response.body)['data'];
      loadData = "DATA_HAS_NOT_LOADED";
    }
  }

  Future<void> isLog() async {
    try {
      UserAuth userauth = new UserAuth();
      final checking = await userauth.checkLog();
      if (checking == true) {
        login = "IS_LOGIN";
      } else {
        login = "IS_NOT_LOGIN";
      }
    } catch (e) {
      login = e.toString();
    }
  }

  Future<void> signin(input) async {
    try {
      UserAuth userauth = new UserAuth();
      await userauth.logEmailPassword(
          email: input['email'], password: input['password']);
      login = "IS_LOGIN";
      userData = input;
    } catch (e) {
      login = e.toString();
    }
  }

  Future<void> signup(input) async {
    try {
      UserAuth userauth = new UserAuth();
      await userauth.createEmailPassword(
          email: input['email'], password: input['password']);
      login = "IS_LOGIN";
      userData = input;
    } catch (e) {
      login = e.toString();
    }
  }

  Future<void> logout() async {
    try {
      UserAuth userauth = new UserAuth();
      await userauth.logOut();
      login = "NULL";
      userData = {};
    } catch (e) {
      login = e.toString();
    }
  }

  Future<void> isLogin() async {
    try {
      UserAuth userauth = new UserAuth();
      final log = await userauth.checkLog();
      log == true ? login = "IS_LOGIN" : login = "NULL";
      userData = {};
    } catch (e) {
      login = e.toString();
    }
  }
}
