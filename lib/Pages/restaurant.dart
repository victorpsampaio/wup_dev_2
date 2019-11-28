import 'package:flutter/material.dart';
import 'package:wup_dev_2/Pages/home.dart';

class Restaurante extends StatefulWidget {
  @override
  _RestauranteState createState() => _RestauranteState();
}

class _RestauranteState extends State<Restaurante> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(179, 13, 106, 70),
            title: new Center(
              child: Text("Restaurante WUP"),
            ),
            actions: <Widget>[
              PopupMenuButton<int>(
                icon: Icon(Icons.menu, color: Colors.white),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Text("Sair"),
                  )
                ],
                onSelected: (value) {
                  if (value == 1) {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
              )
            ],
          ),
          backgroundColor: Colors.grey[600],
          body: new Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 20, 2),
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      new Text("Em Construção",style: TextStyle(color: Colors.white,fontSize: 40),),
                      new Image.asset('assets/Construcao.png'),
                    ],
                  )
                ]
              )),
        )
      ],
    );
  }
}
