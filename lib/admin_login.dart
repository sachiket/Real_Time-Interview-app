import 'package:flutter/material.dart';
import 'package:med_app/primary_button.dart';
import 'package:med_app/admin_main.dart';


class Login extends StatefulWidget {
//  Login({Key key, this.auth}) : super(key: key);


  //final BaseAuth auth;


  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum FormType {
  login,
  register
}

class _LoginPageState extends State<Login> {
  static final formKey = new GlobalKey<FormState>();

  initState() {
    super.initState();
    //widget.auth;
    //widget.key;



  }

  String email;
  String password;

  FormType _formType = FormType.login;
  //String _authHint = '';

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }


  List<Widget> usernameAndPassword() {
    return [
      padded(child: new TextFormField(
        key: new Key('email'),
        decoration: new InputDecoration(labelText: 'Email'),
        autocorrect: false,
        validator: (val) => val.isEmpty ? 'Wrong Email' : null,
        onSaved: (val) => this.email=val
      )),
      padded(child: new TextFormField(
        key: new Key('password'),
        decoration: new InputDecoration(labelText: 'Password'),
        obscureText: true,
        autocorrect: false,
        validator: (val) => val.isEmpty ? 'Wrong Password' : null,
        onSaved: (val) => this.password=val
      )),
      Padding(padding: EdgeInsets.all(10))
    ];
  }
  void validateAndSubmit(){
    if(validateAndSave()){
    String a,b;
    a=email;
    b=password;
    print(a);
    print(b);
    if(a=="master"&&b=="ApnaTimeAyeGa"){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => admin_home()),
      );}}


  }


  List<Widget> submitWidgets() {
        return [
          new PrimaryButton(
              key: new Key('login'),
              text: 'Login',
              height: 44.0,
              onPressed: validateAndSubmit
          ),
        ];
  }



  @override
  Widget build(BuildContext context) {
    return new  Scaffold(
        appBar: new AppBar(
          title: new Text("admin login"),
        ),
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        body: new SingleChildScrollView(child: new Container(
            padding: const EdgeInsets.all(16.0),
            child: new Column(
                children: [
                  new Card(
                      child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Container(
                                padding: const EdgeInsets.all(16.0),
                                child: new Form(
                                    key: formKey,
                                    child: new Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: usernameAndPassword() + submitWidgets(),
                                    )
                                )
                            ),
                          ])
                  ),
                ]
            )
        ))
    );
  }








  Widget padded({Widget child}) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }
}

