import 'package:flutter/material.dart';
import 'package:wup_dev_2/Pages/events.dart';
import 'package:wup_dev_2/Pages/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                PhotoLogo(),
                Text(
                  'Seja bem-vindo à WUP \n Voce é:',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 19.0),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 60, 0, 25),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Navegacao()));
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
                        child: new Text(
                          'USUÁRIO',
                          style: new TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
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
                        child: new Text(
                          'PRODUTOR',
                          style: new TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class PhotoLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('assets/cone 1.png');
    Image image = Image(image: assetImage, width: 300.0, height: 300.0);
    return Container(
        child: image,
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(0.0, 55.0, 0.0, 10.0));
  }
}
