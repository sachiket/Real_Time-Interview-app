import 'package:flutter/material.dart';
import 'package:med_app/database.dart';
import 'package:med_app/editquiz.dart';

class admin_home extends StatefulWidget{
  @override
  admin createState() => new admin();
}

class admin extends State<admin_home>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: new AppBar(
        actions: <Widget>[
          FlatButton.icon(onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=> history()));
          }, icon: new Icon(Icons.history,color:Colors.white ,),
//              color: Colors.white,
              label: new Text("history",
              style: new TextStyle(
                  color: Colors.white,
                  fontSize: 10.0),)),
          FlatButton.icon(
              onPressed: (){
                Navigator.pop(context);

//                push(context,
//                    MaterialPageRoute(builder: (context)=> Login()));
              },
              icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
              label: new Text('Logout',style: new TextStyle(
                color: Colors.white,
                fontSize: 10.0
              ),),)
        ],
      ),
      body: new Center(
        child: new Text("welcome admin",

            style: new TextStyle(fontSize: 42.0,color: Colors.white),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: (){
            _creatquiz();
          }),
    );
  }


  void _creatquiz(){

      var route = new MaterialPageRoute(builder: (BuildContext context){
        return new EditquizPage(num: 0);
      });
      Navigator.of(context).push(route);

  }
}

