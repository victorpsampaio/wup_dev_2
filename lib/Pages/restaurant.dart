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
          body: new Image.asset(
            'assets/fundo1.jpeg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0x00AFD4FF),
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
          backgroundColor: Color(0x00AFD4FF),
          body: new Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 20, 2),
              child: ListView(
                children: <Widget>[
                  Card(
                    child: new Container(
                      padding: EdgeInsets.fromLTRB(15, 20, 0, 15),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: new Border.all(
                            color: Colors.black, width: 0.5),
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                      child: new InkWell(

                        child: Row(
                          children: <Widget>[
                            new CircleAvatar(
                              backgroundImage:
                              NetworkImage('Imagem'),
                              radius: 40,
                            ),
                            new SizedBox(
                              width: 25,
                            ),
                            new Text('Rest 1'),
                            new SizedBox(
                              width: 50,
                            ),
                            new Text('Aberto'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: new Container(
                      padding: EdgeInsets.fromLTRB(15, 20, 0, 15),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: new Border.all(
                            color: Colors.black, width: 0.5),
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                      child: new InkWell(

                        child: Row(
                          children: <Widget>[
                            new CircleAvatar(
                              backgroundImage:
                              NetworkImage('Imagem'),
                              radius: 40,
                            ),
                            new SizedBox(
                              width: 25,
                            ),
                            new Text('Rest 2'),
                            new SizedBox(
                              width: 50,
                            ),
                            new Text('Aberto'),
                          ],
                        ),
                      ),
                    ),
                  ),Card(
                    child: new Container(
                      padding: EdgeInsets.fromLTRB(15, 20, 0, 15),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: new Border.all(
                            color: Colors.black, width: 0.5),
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                      child: new InkWell(

                        child: Row(
                          children: <Widget>[
                            new CircleAvatar(
                              backgroundImage:
                              NetworkImage('Imagem'),
                              radius: 40,
                            ),
                            new SizedBox(
                              width: 25,
                            ),
                            new Text('Rest 3'),
                            new SizedBox(
                              width: 50,
                            ),
                            new Text('Aberto'),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
        )
      ],
    );
  }
}
