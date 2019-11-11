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
              child: Text("GeoPark WUP"),
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

              )),
        )
      ],
    );
  }
}
