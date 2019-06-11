import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:med_app/database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:med_app/auth.dart';
import 'package:med_app/root_page.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

 class QPage extends StatefulWidget{
   QPage({this.auth, this.onSignOut});
   final BaseAuth auth;
   final VoidCallback onSignOut;

  @override
  page createState()=> new page();

}
class page extends State<QPage> {
   Auth aut = new Auth();
   List<String> flag = new List(50);
   bool signal = true;
   bool checkkey = true;
   String key = "";
   List arr = new List(10);



  Query _query;

  @override
  void initState() {
    widget.auth.currentUser();
    widget.onSignOut;
    for(int i = 0;i<10;i++){
      arr[i]=false;
    }
    Database.queryquiz().then((Query query) {
      setState(() {
        _query = query;
      });
    });



    super.initState();
  }

  @override


  Widget build(BuildContext context) {
    Widget body = new ListView(
      children: <Widget>[
        new ListTile(
          title: new Text("The list is empty..."),
        )
      ],
    );

    if (_query != null) {
      body = new FirebaseAnimatedList(
        query: _query,
        itemBuilder: (
            BuildContext context,
            DataSnapshot snapshot,
            Animation<double> animation,
            int index,
            ) {
          String quizKey = snapshot.key;
          Map map = snapshot.value;
          String name = map['name'] as String;
          String ans=map['answer'] as String;
          String score=map['score'] as String;
          String date=map['created'] as String;
          String option1=map['option1'] as String;
          String option2=map['option2'] as String;
          String option3=map['option3'] as String;
          String option4=map['option4'] as String;

          getcheckval(quizKey).then((val){

            setState(() {
              checkkey=val;
              arr[index]=val;

            });

            print("3  $checkkey"); //print statement 1
            print("3  $arr"); //print statement 1
          });

          print("origina val is $checkkey");//print statement 2
          print(arr[0]);
          print(arr[1]);
          print(arr[2]);




          return new Column(
            children: <Widget>[
              checkkey==false? new ListTile(
                title: new Text('$name'
                    '\n$checkkey'),
                onTap: () {
                  answer(ans,score,date,option1,option2,option3,option4,name,quizKey);
                },
              )
                  :new Container(width: 0, height: 0),

              new Divider(
                height: 2.0,
              )

            ],
          );









        },
      );
    }

    return new  WillPopScope(onWillPop: (){

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  RootPage(auth: widget.auth,)));

    },
      child: Scaffold(
        appBar: new AppBar(
          title: new Text("Today's Question"),
        ),
        body: body,
      ),

    );


  }
  


  void answer(String ans, String score,String date,String op1,String op2,String op3,String op4,String qes,String quizKey){
    print(ans);
    print(score);
    //flag.add(date);
    //DatabaseReference rootRef = FirebaseDatabase.instance.reference();
    //rootRef.child(path)



    Ans(context,ans,score,op1,op2,op3,op4,qes,quizKey);
  }

  _wrong(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Oops",
      desc: "Wrong Answer",
      buttons: [
        DialogButton(
          child: Text(
            "Back",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.push(context
              , new MaterialPageRoute(builder: (context)=>QPage(auth: widget.auth,onSignOut: widget.onSignOut,))),
          width: 150,
        )
      ],
    ).show();
  }




  _correct(context,String score) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Awesome Correct Answer",
      desc: "You got $score points",
      buttons: [
        DialogButton(
          child: Text(
            "Back",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.push(context
              , new MaterialPageRoute(builder: (context)=>QPage(auth: widget.auth,onSignOut: widget.onSignOut,))),
          width: 150,
        )
      ],
    ).show();
  }

  Ans(context,String ans,String score,String option1,String option2,String option3,String option4,String qes,String quizKey){
    String val;


    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.green,
      ),
    );


    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.info,
      title: "$qes",
      desc: "Enter you answer",
      content: Column(
        children: <Widget>[
          option1==null?
          TextField(
            //obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.question_answer),
              labelText: 'Answer',),
            onChanged:(String value){
              val=value;
              print(val);
            } ,
          ):
              RadioButtonGroup(labels: <String>[
                option1,
                option2,
                option3,
                option4
              ],
              onSelected: ((String value){
                val=value;
              }),
              )

        ],
      ),
      buttons: [
        DialogButton(

          child: Text(
            "Submit",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),

          onPressed: () {
            print(ans);
            print(val);
            if(val==ans){
              aut.createScore(score,quizKey);
              _correct(context,score);}
            else{
              aut.createScore('0',quizKey);
              _wrong(context);}




          },


          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }


   Future<bool> getcheckval(String quizKey) async{
     bool s = await Auth.checkKey(quizKey);
     return s;
   }








}




