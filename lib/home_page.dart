import 'package:flutter/material.dart';
import 'package:med_app/auth.dart';
import 'package:med_app/home_question_page.dart';
import 'package:med_app/score_result.dart';

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignOut});
  final BaseAuth auth;
  final VoidCallback onSignOut;




  @override
  Widget build(BuildContext context) {

    void _signOut() async {
      try {
        await auth.signOut();
        onSignOut();
      } catch (e) {
        print(e);
      }

    }

    return new Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      drawer:new Drawer(
        child: new ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new DrawerHeader(
              child: new Text("options"),
              decoration: BoxDecoration(
                color: Color.fromRGBO(58, 66, 86, 1.0),
              ),
            ),


            new ListTile(
              title: new Text("View Question"),
              onTap: (){
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context)=>QPage(auth: auth,onSignOut: onSignOut,)));
              },
            ),

            new ListTile(
              title: new Text("Dashboard"),
              onTap: (){
                Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context)=>ListPage()));
              },
            ),


          ],
        ),
      ),
      appBar: new AppBar(
        actions: <Widget>[
          new FlatButton(
              onPressed: _signOut,
              child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white))
          )
        ],
      ),
      body: new Center(
        child: new Text(
          'Welcome',
          style: new TextStyle(fontSize: 42.0,
          color: Colors.white),
        ),
      )
    );
  }
}