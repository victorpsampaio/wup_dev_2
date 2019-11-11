import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:wup_dev_2/Pages/creation.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController senhaCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: <Widget>[
          Scaffold(
            body: new Image.asset(
              'assets/fundo2.jpeg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                PhotoLogo(),
                SizedBox(height: 40,),
                Container(
                  decoration: new BoxDecoration(
                    color: Color(0xBBFFFFFF),
                    border: new Border.all(color: Colors.black, width: 0.5),
                    borderRadius: new BorderRadius.circular(5.0),
                  ),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        labelText: "E-mail",
                        hintText: "E-mail",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                    ),
                    controller: emailCon,

                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text.isEmpty || !text.contains("@"))
                        return "E-mail Invalido";
                    },
                  ),
                ),
                Divider(),

                Container(
                  decoration: new BoxDecoration(
                    color: Color(0xBBFFFFFF),
                    border: new Border.all(color: Colors.black, width: 0.5),
                    borderRadius: new BorderRadius.circular(5.0),
                  ),

                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Senha",
                        labelText: "Senha",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))

                    ),
                    obscureText: true,
                    controller: senhaCon,
                    validator: (text){
                      if(text.isEmpty || text.length <6)
                        return "Senha Invalida";
                    },
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(20.0,40.0,20.0,0.0),
                    child: InkWell(
                      onTap: (){

                        if(_formKey.currentState.validate()){
                          FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailCon.text, password: senhaCon.text
                          ).then( (_){
                            Navigator.push(context,  MaterialPageRoute(builder: (context) => Creation()));
                          })..catchError((e){
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: new Text("Erro ao entrar"),
                                    content: new Text("Senha e email não coincidem"),
                                    actions: <Widget>[
                                      new FlatButton(
                                          child: new Text("Fechar"),
                                          onPressed: (){Navigator.pop(context);}
                                      )
                                    ],
                                  );
                                }
                            );
                          });

                        }
                      },
                      child: new Container(
                        width: 280.0,
                        height: 45.0,
                        decoration: new BoxDecoration(
                          color: Color(0xBBFFFFFF),
                          border: new Border.all(color: Colors.black, width: 0.5),
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        child: new Center(
                          child: new Text('ENTRAR',
                            style: new TextStyle( color: Colors.black),
                          ),
                        ),
                      ),
                    )
                ),
                SizedBox(height: 10,),
                Center(child:
                Column(children: <Widget>[
                  Text("Para virar produtor e criar eventos") ,
                  Text("entre em contato com"),
                  Text("wuproject@gmail.com"),
                ],)
                  ,)
              ],
            ),
          )
        ],
      ),
    );
  }
}






class PhotoLogo extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    AssetImage assetImage = AssetImage('assets/cone 1.png');
    Image image = Image(image: assetImage, width: 200.0,height: 200.0);
    return Container(child: image, alignment: Alignment.center,padding: EdgeInsets.fromLTRB(0.0, 55.0, 0.0, 0.0));
  }
}