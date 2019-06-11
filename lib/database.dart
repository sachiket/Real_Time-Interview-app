import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';



//final FirebaseOptions options = FirebaseOptions(
//    googleAppID: "1:150346587656:android:5f77d83f16bfc059",
//    apiKey: "AIzaSyApzb8pad6Jpr0d0l39a9FlxMIEKhTDGWs",
//    databaseURL:
//);






class Database {

  static Future<String> createquiz() async {
    String accountKey = await _getAccountKey();

    var quiz = <String, dynamic>{
      'name': '',
      'answer':'',
      'score':'',
      'created': _getDateNow(),
      'option1':'no options given',
      'option2':'no options given',
      'option3':'no options given',
      'option4':'no options given',

    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("quiz")
        .push();

    reference.set(quiz);

    return reference.key;
  }


  static Future<void> removeall() async {
    String accountKey = await _getAccountKey();

    return FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("quiz")
        .remove();
  }

  static Future<void> remove(String quizkey) async {
    String accountKey = await _getAccountKey();

    return FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("quiz")
        .child(quizkey)
        .remove();
  }

  static Future<void> saveName(String quizKey, String name) async {
    String accountKey = await _getAccountKey();

    return FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("quiz")
        .child(quizKey)
        .child('name')
        .set(name);
  }


  static Future<void> saveanswer(String quizKey, String name) async {
    String accountKey = await _getAccountKey();

    return FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("quiz")
        .child(quizKey)
        .child('answer')
        .set(name);
  }



  static Future<void> saveScore(String quizKey, String name) async {
    String accountKey = await _getAccountKey();

    return FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("quiz")
        .child(quizKey)
        .child('score')
        .set(name);
  }

  static Future<void> saveoption1(String quizKey, String name) async {
    String accountKey = await _getAccountKey();

    return FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("quiz")
        .child(quizKey)
        .child('option1')
        .set(name);
  }


  static Future<void> saveoption2(String quizKey, String name) async {
    String accountKey = await _getAccountKey();

    return FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("quiz")
        .child(quizKey)
        .child('option2')
        .set(name);
  }

  static Future<void> saveoption3(String quizKey, String name) async {
    String accountKey = await _getAccountKey();

    return FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("quiz")
        .child(quizKey)
        .child('option3')
        .set(name);
  }

  static Future<void> saveoption4(String quizKey, String name) async {
    String accountKey = await _getAccountKey();

    return FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("quiz")
        .child(quizKey)
        .child('option4')
        .set(name);
  }




//
  static Future<StreamSubscription<Event>> getNameStream(String quizKey,
      void onData(String name)) async {
    String accountKey = await _getAccountKey();

    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("quiz")
        .child(quizKey)
        .child("name")
        .onValue
        .listen((Event event) {
      String name = event.snapshot.value as String;
      if (name == null) {
        name = "";
      }
      onData(name);
    });

    return subscription;
  }

  static Future<Query> queryquiz() async {
    String accountKey = await _getAccountKey();

    return FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("quiz")
        .orderByChild("created");
    //use .equalto function
  }

  static Future<Query> querygetlast() async {
    String accountKey = await _getAccountKey();

    return FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("quiz")
        .orderByChild("created")
        .limitToLast(1);
    //use .equalto function
  }
  
  
}

Future<String> _getAccountKey() async {
  return '12345678';
}

String _getDateNow() {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
  return formatter.format(now);
}
