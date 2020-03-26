import 'package:appcovid19/ressource/userAuth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ConfigStore extends ChangeNotifier {
  dynamic login;
  Map userData={};

  Map resultTest={
    'result':'',
  };

  Map resultReport={
    'result':''
  };

  Map questionsSymptomes={
    'fievre':'Pensez-vous avoir eu de la fièvre ces derniers jours (frissons, sueurs) ?',

    'toux':'Avez-vous une toux ou une augmentation de votre toux habituelle ces derniers jours ?',

    'courbature':'Avez-vous des douleurs musculaires ou des courbatures inhabituelles ces derniers jours ?',

    'gorge':'Avez-vous un mal de gorge apparu ces derniers jours ?',

    'diarrhee':'Avez-vous de la diarrhée ces dernièrs 24 heures (au moins 3 selles molles) ?',

    'fatigue':'Avez-vous une fatigue inhabituelle ces derniers jours ?',

    'alimentation':'Avez-vous des difficultés importantes pour vous alimenter ou boire depuis plus de 24h? ',

    'respiratoire':'Avez-vous vu apparaître une gêne respiratoire ou une augmentation de votre gêne respiratoire habituelle ? ',

    'autres':'Comment vous sentez-vous, Avez-vous d’autre symptôme?'

  };

  Map questionsPronostics={
    'age':'Quel est votre âge ?',
    'poids':'Quel est votre poids ? ',
    'taille':'Quelle est votre taille ?',
    'cardiaque':'Avez-vous de l’hypertension artérielle ? Ou avez-vous une maladie cardiaque ou vasculaire ? Ou prenez-vous un traitement à visée cardiologique ? ',
    'diabetique':'Êtes-vous diabétique ?',
    'cancer':'Avez-vous ou avez-vous eu un cancer ?',
    'pneumologue':'Avez-vous une maladie respiratoire ? Ou êtes-vous suivi par un pneumologue ? ',
    'dialyse':'Avez-vous une insuffisance rénale chronique dialysée ? ',
    'foie':'Avez-vous une maladie chronique du foie ?',
    'grossesse':'Êtes-vous enceinte ?',
    'defense':'Avez-vous une maladie connue pour diminuer vos défenses immunitaires',
    'traitement':'Prenez-vous un traitement immunosuppresseur ? C’est un traitement qui diminue vos défenses contre les infections. Voici quelques exemples : corticoïdes, méthotrexate,ciclosporine, tacrolimus, azathioprine, cyclophosphamide (liste non exhaustive). '
  };

  void autoDiagnostic({Map input, type})
  {
    if((input['fievre'] || input['toux']) && (input['toux']||input['gorge']) && (input['courbature']||input['fievre']) && input['diarrhee']){

      if(type=="sans facteur pronostique")
      {
        if(input['age']<=50){
          resultTest['result']="nous vous conseillons de rester à votre domicile et de contacter votre médecin en cas d’apparition de nouveaux symptômes. Vous pourrez aussi utiliser à nouveau l’application pour réévaluer vos symptômes.";
        }
        else if(input['age'] >50 && input['age'] <=69){
          resultTest['result']="nous vous conseillons de rester à votre domicile et de contacter votre médecin en cas d’apparition de nouveaux symptômes. Vous pourrez aussi utiliser à nouveau l’application pour réévaluer vos symptômes.";
        }
        else
        {
          resultTest['result']="nous vous conseillons de rester à votre domicile et de contacter votre médecin en cas d’apparition de nouveaux symptômes. Vous pourrez aussi utiliser à nouveau l’application pour réévaluer vos symptômes.";
        }
      }

    }
    else
    {
      resultTest['result']="Votre situation ne relève probablement pas du Covid-19. N’hésitez pas à contacter votre médecin en cas de doute. Vous pouvez refaire le test en cas de nouveau symptôme pour réévaluer la situation. Pour toute information concernant le Covid-19, composer le 222.";
    }


  }

  Future<void> signin(input)async{

    UserAuth userauth= new UserAuth();
    try {
      await userauth.logEmailPassword(email:input['email'], password:input['password']);
      login=true;
      userData=input;
    } catch (e) {
      login=e.toString();
    }
  }


  Future<void> signup(input)async{

    UserAuth userauth= new UserAuth();
    try {
      await userauth.createEmailPassword(email:input['email'], password:input['password']);
      login=true;
      userData=input;
    } catch (e) {
      login=e.toString();
    }
  }





}