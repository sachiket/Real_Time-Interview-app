
import 'package:flutter/material.dart';
import 'package:med_app/auth.dart';




class ListPage extends StatefulWidget {



  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>  {
  Future<String> s =Auth.getScore();
  int total = 0;
  String _sum="";





  @override
  void initState() {
   getdata().then((val){
     setState(() {
      _sum=val.toString();
     });
   });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    ListTile makeListTile() => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Icon(Icons.autorenew, color: Colors.white),
      ),
      title: Text(
        "Your Score",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

      subtitle: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                // tag: 'hero',
                child: LinearProgressIndicator(
                    backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                    value: 20,
                    valueColor: AlwaysStoppedAnimation(Colors.green)),
              )),

        ],
      ),
      trailing:
      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
      onTap: () {
//        Navigator.push(
//            context,
//            MaterialPageRoute(
//                builder: (context) => DetailPage(lesson: lesson)));
      },
    );



    ListTile makeListTile2() => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                )),
        child: Icon(Icons.score, color: Colors.white),
      ),
      title: Text(_sum
        ,
        style: TextStyle(color: Colors.white,fontSize: 30.0),
      ),

    );

    Card makeCard() => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile(),
      ),
    );

    Card makeCard2() => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile2(),
      ),
    );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(10.0)),
          makeCard(),
          Padding(padding: EdgeInsets.all(10.0)),
          makeCard2()


        ],

      ),
    );


    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text("DashBoard"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: makeBody,
      //bottomNavigationBar: makeBottom,
    );
  }
  Future<String> getdata() async{
    String s = await Auth.getScore();
    return s;
  }
}


