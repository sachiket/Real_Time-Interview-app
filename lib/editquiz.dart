
import 'dart:async';
import 'package:med_app/admin_main.dart';
import 'package:flutter/material.dart';
import 'package:med_app/database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:med_app/auth.dart';

class EditquizPage extends StatefulWidget {
  static String routeName = '/edit_quiz';

  final String quizKey;
  final int num;

  EditquizPage({Key key, this.quizKey ,this.num}) : super(key: key);

  @override
  _EditquizPageState createState() => new _EditquizPageState();
}

class _EditquizPageState extends State<EditquizPage> {
  String name,answer,score,option1,option2,option3,option4;
  bool isSwitched = false;
  final _nameFieldTextController = new TextEditingController();
  static final strkey = new GlobalKey();

  StreamSubscription _subscriptionName;

  
  bool save(){
    final form = strkey.currentState;
    return true;
  }
  void submit(){
    if(save()&& widget.num==1){
      print(name);
      print(answer);
      print(score);
      Database.saveName(widget.quizKey, name);
      Database.saveanswer(widget.quizKey, answer);
      Database.saveScore(widget.quizKey, score);
      Database.saveoption1(widget.quizKey, option1);
      Database.saveoption2(widget.quizKey, option2);
      Database.saveoption3(widget.quizKey, option3);
      Database.saveoption4(widget.quizKey, option4);

      Navigator.push(context,
          new MaterialPageRoute(builder:(context)=>admin_home()));
    }else{
      print(name);
      print(answer);
      print(score);

      Database.createquiz().then((String quizKey){
        Database.saveName(quizKey, name);
        Database.saveanswer(quizKey, answer);
        Database.saveScore(quizKey, score);
        Database.saveoption1(quizKey, option1);
        Database.saveoption2(quizKey, option2);
        Database.saveoption3(quizKey, option3);
        Database.saveoption4(quizKey, option4);
      } );
      Navigator.push(context,
          new MaterialPageRoute(builder:(context)=>admin_home()));
    }

  }


  void submit2(){
    print(name);
    print(answer);
    print(score);
    Database.createquiz().then((String quizKey){
      var route = new MaterialPageRoute(builder: (BuildContext context){
        return new EditquizPage(quizKey: quizKey,num: 1,);
      });
      Navigator.of(context).push(route);
    } );
  }

  @override
  void initState() {
    _nameFieldTextController.clear();
    widget.num;

    Database.getNameStream(widget.quizKey, _updateName)
        .then((StreamSubscription s) => _subscriptionName = s);

    super.initState();
  }

  @override
  void dispose() {
    if (_subscriptionName != null) {
      _subscriptionName.cancel();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: new ListView(
        children: <Widget>[

          new Padding(padding: new EdgeInsets.all(15)),


          new ListTile(
            title: new TextField(
              controller: _nameFieldTextController,
              decoration: new InputDecoration(
                  icon: new Icon(Icons.edit),
                  labelText: "Quiz Question",
                  hintText: "Enter the Quiz Questions..."
              ),
              onChanged: (String value) {
                this.name=value;
               // Database.saveName(widget.quizKey, value);
              },
            ),
          ),



          new Padding(padding: new EdgeInsets.all(15)),




          new ListTile(
            title: new TextField(
//              controller: _nameFieldTextController,
              decoration: new InputDecoration(
                  icon: new Icon(Icons.question_answer),
                  labelText: "Answer",
                  hintText: "Enter the answer of the Questions..."
              ),
              onChanged: (String value) {
                this.answer=value;
               // Database.saveanswer(widget.quizKey, value);
              },
            ),
          ),

          new Padding(padding: new EdgeInsets.all(15)),




          new ListTile(

            title: new TextField(
//              controller: _nameFieldTextController,
              decoration: new InputDecoration(
                  icon: new Icon(Icons.score),
                  labelText: "Score",
                  hintText: "Score for correct answer..."
              ),
              onChanged: (String value) {
                this.score=value;
               // Database.saveScore(widget.quizKey, value);
              },
            ),
          ),
          new Padding(padding: new EdgeInsets.all(10)),
        

          widget.num==1?
          new SwitchListTile(
            title: new Text("         Edit Options",
              textAlign: TextAlign.start,
              style: new TextStyle(
                  color: Colors.grey
              ),),
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
            activeTrackColor: Colors.lightBlueAccent,
            activeColor: Colors.blue,


          )
          :  new SwitchListTile(
            title: new Text("         Add MCQ",
              textAlign: TextAlign.start,
              style: new TextStyle(
                  color: Colors.grey
              ),),
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,


          ),
          isSwitched==true?
          new ListTile(
            title: new TextField(
//              controller: _nameFieldTextController,
              decoration: new InputDecoration(
                  icon: new Icon(Icons.looks_one),
                  labelText: "Option 1",
                  hintText: "Enter option 1..."
              ),
              onChanged: (String value) {
                setState(() {
                  option1 = value;
                });
                // Database.saveanswer(widget.quizKey, value);
              },
            ),
          ): new Padding(padding: new EdgeInsets.all(0)),



          isSwitched==true?
          new ListTile(
            title: new TextField(
//              controller: _nameFieldTextController,
              decoration: new InputDecoration(
                  icon: new Icon(Icons.looks_two),
                  labelText: "Option 2",
                  hintText: "Enter option 2..."
              ),
              onChanged: (String value) {
                setState(() {
                  option2 = value;
                });

                // Database.saveanswer(widget.quizKey, value);
              },
            ),
          ):new Padding(padding: new EdgeInsets.all(0)),



          isSwitched==true?
          new ListTile(
            title: new TextField(
//              controller: _nameFieldTextController,
              decoration: new InputDecoration(
                  icon: new Icon(Icons.looks_3),
                  labelText: "Option 3",
                  hintText: "Enter option 3..."
              ),
              onChanged: (String value) {
                setState(() {
                  option3 = value;
                });
                // Database.saveanswer(widget.quizKey, value);
              },
            ),
          ):new Padding(padding: new EdgeInsets.all(0)),




          isSwitched==true?
          new ListTile(
            title: new TextField(
//              controller: _nameFieldTextController,
              decoration: new InputDecoration(
                  icon: new Icon(Icons.looks_4),
                  labelText: "Option 4",
                  hintText: "Enter option 4..."
              ),
              onChanged: (String value) {
                setState(() {
                  option4 = value;
                });
                // Database.saveanswer(widget.quizKey, value);
              },
            ),
          ):new Padding(padding: new EdgeInsets.all(0)),



          
          new Padding(padding: new EdgeInsets.all(15)),

          widget.num ==1? new FlatButton(

              onPressed: submit,
              color: Colors.blue,
              key: new Key("Submit"),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10)
              ),
              child: new Text("Submit")

          ):
          new FlatButton(

          onPressed: submit,
          color: Colors.green,
          key: new Key("Submit"),
          shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10)
          ),
          child: new Text("Submit")),

          
          
          
          
          
        ],
      ),
    );
  }

  void _updateName(String name) {
    _nameFieldTextController.value = _nameFieldTextController.value.copyWith(
      text: name,
    );
  }
}


class history extends StatefulWidget{
  @override
  history_page createState()=> new history_page();
}
class history_page extends State<history>{

  Query _query;

  void deletcurrent(String quizkey){
     Database.remove(quizkey);

  }
  
  
  void delet(){
    Database.removeall();
    return;
  }

  @override
  void initState() {
    Database.queryquiz().then((Query query) {
      setState(() {
        _query = query;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = new GestureDetector(
      child:new ListView(
        children: <Widget>[
          new ListTile(
            title: new Text("The list is empty..."),
          )
        ],
      ) ,
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
          String ans = map['answer'] as String;
          String score =map['score'] as String;
          String option1 =map['option1'] as String;
          String option2 =map['option2'] as String;
          String option3 =map['option3'] as String;
          String option4 =map['option4'] as String;
          if(option1==option2&&option3==option4&&option1==null&&option3==null){
            option1=option2=option3=option4='no options given';
          }
          return new Column(
            children: <Widget>[
              new Padding(padding: EdgeInsets.all(20)),
               new GestureDetector(
                 child:  new ListTile(
                   title: new Text('$name\n'
                       'Answer : $ans\n'
                       'Score : $score\n'
                       'option1 : $option1\n'
                       'option2 : $option2\n'
                       'option3 : $option3\n'
                       'option4 : $option4'

                   ),

                   onTap: () {
                     _edit(quizKey);
                   },
                 ),
                 onVerticalDragCancel:((){
                   deletcurrent(quizKey);
          }),
               ),


              new Divider(
                height: 3.0,
              ),
            ],
          );
        },
      );
    }

    return new WillPopScope(onWillPop: (){

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  admin_home()));

    },
    child:   Scaffold(
      appBar: new AppBar(
        title: new Text("History",
          style: new TextStyle(
            fontSize: 22,
            fontStyle: FontStyle.italic
          ),

        ),
        actions: <Widget>[
          new FlatButton(onPressed: delet, 
              child: Text("Clear All",
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 15
                ),

              ),
              
              
          )
        ],
      ),
      body: body,
    ),
    );
  }



void _edit(String quizKey){
    var route = new MaterialPageRoute(builder:
    (context)=>new EditquizPage(quizKey: quizKey,num: 1,)
    );
    Navigator.of(context).push(route);

}
}