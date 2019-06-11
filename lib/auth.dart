import 'dart:async';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class BaseAuth {

  Future<String> currentUser();
  Future<String> signIn(String email, String password);
  Future<String> createUser(String email, String password);
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true; 
    } else {
      return false;
    }
  }

  Future<String> signIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }

  Future<String> createUser(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user != null ? user.uid : null;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  static Future<String> getScore()async{
    String user = await _getKey();
    int _sum = 0;
    String s = "";

    DatabaseReference db = FirebaseDatabase.instance.reference().child("user accounts").child(user);
    return db.once().then((DataSnapshot snapshot){
      Map map = snapshot.value;
      map.forEach((key,map){
        String score=map['score'] as String;
        //print(score);
       // print(key);
        int n = num.parse(score);
        _sum=_sum+n;
        s=_sum.toString();

        //print(sum);
      });
      return s;

    }).then((val){

       return val;
    });

  }


  static Future<bool> checkKey(String quizKey)async{
    String user = await _getKey();
    bool s = false;

    DatabaseReference db = FirebaseDatabase.instance.reference().child("user accounts").child(user);
    return db.once().then((DataSnapshot snapshot){
      Map map = snapshot.value;
      map.forEach((key,map){
        String qKey=map['quizKey'] as String;
        if(qKey==quizKey)
          s=true;


      });
      return s;


    }).then((val){
      //print("2 $val");

      return val;
    });

  }





   Future<String> createScore(String score,String quizKey) async{
     FirebaseUser user = await _firebaseAuth.currentUser();
     print("the score is $score");

     var signal = <String, dynamic>{
       'score': score,
       'flag': '1',
       'created': _getDateNow(),
       'quizKey' : quizKey

     };



         DatabaseReference reference = FirebaseDatabase.instance
             .reference()
             .child("user accounts")
             .child(user.uid)
             .push();

         reference.set(signal);

         return reference.key;

//         DatabaseReference reference1 = FirebaseDatabase.instance.reference();
//         reference1.child("user accounts").child(user.uid).once().then((DataSnapshot snapshot){
//           Map map=snapshot.value;
//           String scorekey = snapshot.key;
//           String oldScore=map['score'] as String;
//
//           String s;
//
//               int n2= num.parse(score);
//               int n1=num.parse(oldScore);
//               int sum=n1+n2;
//               s=sum.toString();



//
//           return FirebaseDatabase.instance
//               .reference()
//               .child("user accounts")
//               .child(user.uid)
//               .child(key)
//               .child('score')
//               .set(s);
//         });


       }






  }




String _getDateNow() {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
  return formatter.format(now);

}
Future<String> _getKey() async {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser user = await _firebaseAuth.currentUser();
  return user.uid;
}
