import 'package:flutter/material.dart';
import 'package:wup_dev_2/Pages/home.dart';

class GeoPark extends StatefulWidget {
  @override
  _GeoParkState createState() => _GeoParkState();
}

class _GeoParkState extends State<GeoPark> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(179, 13, 106, 70),
            title: new Center(
              child: Text("GeoPark WUP"),
            ),
            actions: <Widget>[
              PopupMenuButton<int>(
                icon: Icon(Icons.menu, color: Colors.grey[600]),
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
                  Card(
                    child: new Container(
                      padding: EdgeInsets.fromLTRB(15, 20, 0, 15),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: new Border.all(color: Colors.black, width: 0.5),
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                      child: new InkWell(
                        child: new Row(
                          children: <Widget>[
                            new CircleAvatar(
                              backgroundImage: ExactAssetImage(
                                  'assets/imagens/peiropolis.jpeg'),
                              radius: 40,
                            ),
                            new SizedBox(
                              width: 25,
                            ),
                            new Column(
                              children: <Widget>[
                                new Text(
                                  'Peirópolis',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                new SizedBox(
                                  width: 50,
                                  height: 10,
                                ),
                                new Text('Rua B, 105'),
                                new Text('Aberto das 8:00 até 17:00')
                              ],
                            )
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
                        border: new Border.all(color: Colors.black, width: 0.5),
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                      child: new InkWell(
                        child: Row(
                          children: <Widget>[
                            new CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/imagens/memorial_chico_xavier.jpeg'),
                              radius: 40,
                            ),
                            new SizedBox(
                              width: 25,
                            ),
                            new Column(
                              children: <Widget>[
                                new Text('Memorial Chico Xavier',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                new SizedBox(
                                  width: 50,
                                  height: 10,
                                ),
                                new Text('Avenida Joao XXIII, 2011'),
                                new Text('Aberto das 13:00 até 18:00'),
                              ],
                            )
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

class GeoPark1 extends StatefulWidget {
  @override
  _GeoPark1State createState() => _GeoPark1State();
}

class _GeoPark1State extends State<GeoPark1> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: new Text("Informações do Evento"),
              actions: <Widget>[],
            ),
            backgroundColor: Colors.transparent,
            body: new ListView(
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: new Text(
                        "Nome: ",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Divider(),
                    new Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: new Text(
                        "Data: ",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Divider(),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: new Image.network(
                      'assets/image/memorial_chico_xavier.jpeg'),
                ),
                Divider(),
                new Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Descrição: ",
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                      color: Colors.transparent,
                    ),
                    Divider(),
                    InkWell(
                      child: Text(
                        "Endereço: ",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      child: Text(
                        "Contato: ",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ],
            ))
      ],
    );
  }
}
