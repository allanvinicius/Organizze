import 'package:financas/src/screens/tabs_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email, password;
  bool saveAttempted = false;
  final formKey = GlobalKey<FormState>();

  void _registerUser({String email, String pw}){
    _auth.createUserWithEmailAndPassword(email: email, password: pw)
      .then((authResult) {
        setState(() {
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text('Usuário cadastrado com sucesso !'),
                content: Text('Você será redirecionado para a tela inicial do app!'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => TabsScreen(),
                        ),
                      );
                    }, 
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              );
            }
          );
        });
      })
      .catchError((err){
        print(err.code);
        if (err.code == 'ERROR_EMAIL_ALREADY_IN_USE'){
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text(
                  'Usuário já existe !',
                ),
                content: Text("Cadastre um novo usuário!"),
                actions: <Widget>[
                  FlatButton(
                    onPressed: (){
                      setState(() {
                        Navigator.of(context).pop();
                      });
                    }, 
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.black
                      ),
                    ),
                  ),
                ],
              );
            }
          );
        }
      });
  }


    Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(
            top: 20, 
            left: 40, 
            right: 40,
          ),
          color: Colors.greenAccent[400],
          child: ListView(
            children: <Widget>[
              SizedBox(
                width: 128,
                height: 128,
                child: Image.asset("images/logo.png"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                autovalidate: saveAttempted,
                onChanged: (textValue){
                  setState(() {
                    email = textValue;
                  });
                },
                validator: (emailValue){
                  if (emailValue.isEmpty) {
                    return 'E-mail obrigatório !';
                  }

                  String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                    "\\@" +
                    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                    "(" +
                    "\\." +
                    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                    ")+";
                  RegExp regExp = new RegExp(p);

                  if (regExp.hasMatch(emailValue)){
                    return null;
                  }
                  return 'E-mail inválido !';
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "E-mail",
                  labelStyle: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                autovalidate: saveAttempted,
                onChanged: (textValue) {
                  setState(() {
                    password = textValue;
                  });
                },
                validator: (pwValue){
                  if (pwValue.isEmpty) {
                    return 'Senha obrigatória !';
                  }
                  if (pwValue.length < 8) {
                    return 'Senha deve conter pelo menos 8 caracteres !';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1],
                    colors: [
                      Color(0XFFFFFFFF),
                      Color(0XFFFFFFFF),
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: SizedBox.expand(
                  child: FlatButton( 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Cadastrar",
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent[400],
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          child: SizedBox(
                            height: 28,
                            width: 28,
                            child: Icon(Icons.arrow_forward, color: Colors.greenAccent[400]),
                          ),
                        ),
                      ],
                    ),
                    onPressed: (){
                      setState(() {
                        saveAttempted = true;
                      });

                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        _registerUser(email: email, pw: password);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ), 
    );
  }
}