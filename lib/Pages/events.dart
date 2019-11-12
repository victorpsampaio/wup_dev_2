import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wup_dev_2/Pages/creation.dart';
import 'package:wup_dev_2/Pages/geopark.dart';
import 'package:wup_dev_2/Pages/home.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wup_dev_2/Pages/restaurant.dart';
import 'package:wup_dev_2/main.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Navegacao extends StatefulWidget {
  @override
  _NavegacaoState createState() => _NavegacaoState();
}

class _NavegacaoState extends State<Navegacao> {
  int _page = 0;

  final _pageOptions = [
    EventPage(),
    Restaurante(),
    GeoPark(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.deepPurple,
        animationDuration: Duration(milliseconds: 600),
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.black,
        animationCurve: Curves.easeInOut,
        items: <Widget>[
          Column(
            children: <Widget>[
              Icon(
                Icons.event,
                size: 20,
                color: Colors.white,
              ),
              Text('Eventos',
                  style: TextStyle(color: Colors.white, fontSize: 10))
            ],
          ),
          Column(
            children: <Widget>[
              Icon(Icons.restaurant_menu, size: 20, color: Colors.white),
              Text(
                'Restaurante',
                style: TextStyle(color: Colors.white, fontSize: 10),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Icon(Icons.explore, size: 20, color: Colors.white),
              Text('GeoPark',
                  style: TextStyle(color: Colors.white, fontSize: 10))
            ],
          )
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      drawer: AppDrawer(),
      body: _pageOptions[_page],
    );
  }
}

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return EventList();
  }
}

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Evento').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return BackLogo();
          default:
            return new Stack(
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
                      child: Text("Eventos WUP"),
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
                            FirebaseAuth.instance.signOut();
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          }
                        },
                      )
                    ],
                  ),
                  backgroundColor: Color(0x00AFD4FF),
                  body: new Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 20, 2),
                    child: ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return new Card(
                          child: new Container(
                            padding: EdgeInsets.fromLTRB(15, 20, 0, 15),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: new Border.all(
                                  color: Colors.black, width: 0.5),
                              borderRadius: new BorderRadius.circular(5.0),
                            ),
                            child: new InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailEvent(
                                            document['Nome'],
                                            document['Data'],
                                            document['Imagem'],
                                            document['Endereco'],
                                            document['Descricao'],
                                            document['Link'],
                                            document['RedeSocial'],
                                            document['Site'])));
                              },
                              child: Row(
                                children: <Widget>[
                                  new CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(document['Imagem']),
                                    radius: 40,
                                  ),
                                  new Container(
                                      padding: EdgeInsets.all(40),
                                      child: Column(
                                        children: <Widget>[
                                          new Text(document['Nome']),
                                          new Text(document['Data']),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            );
        }
      },
    );
  }
}

class DetailEvent extends StatefulWidget {
  final String nome;
  final String data;
  final String imagem;
  final String endereco;
  final String descricao;
  final String link;
  final String site;
  final String rede;
  DetailEvent(
      [this.nome,
      this.data,
      this.imagem,
      this.endereco,
      this.descricao,
      this.link,
      this.rede,
      this.site]);

  @override
  _DetailEventState createState() => _DetailEventState();
}

class _DetailEventState extends State<DetailEvent> {
  void _openCall() async {
    await launch("tel://" + widget.link);
  }

  void _openMap() async {
    String url =
        "https://www.google.com/maps/search/?api=1&query=" + widget.endereco;
    if (await canLaunch(url)) {
      await launch(url);
    } else
      throw 'could not lauch';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: new Image.asset(
            'assets/back4.jpeg',
            color: Color.fromARGB(255, 0, 255, 255),
            colorBlendMode: BlendMode.color,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),
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
                        "Nome: " + widget.nome,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Divider(),
                    new Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: new Text(
                        "Data: " + widget.data,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Divider(),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: new Image.network(widget.imagem),
                ),
                Divider(),
                new Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Descrição: " + widget.descricao,
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                      color: Colors.transparent,
                    ),
                    Divider(),
                    InkWell(
                      onTap: _openMap,
                      child: Text(
                        "Endereço: " + widget.endereco,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      child: Text(
                        "Contato: " + widget.link,
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: _openCall,
                    ),
                    Divider(),
                    Linkify(
                      onOpen: (link) async {
                        if (await canLaunch(link.url)) {
                          await launch(link.url);
                        }
                      },
                      linkStyle: TextStyle(color: Colors.red),
                      text: "Site: " + widget.site,
                      humanize: true,
                    ),
                    Divider(),
                    Linkify(
                      onOpen: (link) async {
                        if (await canLaunch(link.url)) {
                          await launch(link.url);
                        }
                      },
                      linkStyle: TextStyle(color: Colors.red),
                      text: "Rede Social: " + widget.rede,
                      humanize: true,
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

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.event, text: 'Events', onTap: () => EventPage()),
          _createDrawerItem(
              icon: Icons.note, text: 'Notes', onTap: () => Creation()),
          Divider(),
          ListTile(
            title: Text('0.0.1'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage('assets/fundo3.jpeg'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Bem Vindo Victor",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
