import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wup_dev_2/Pages/creation.dart';
import 'package:wup_dev_2/Pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ('WUP'),
      debugShowCheckedModeBanner: false,
      home: handleWindow(),
    );
  }
}

Widget handleWindow() {
  return StreamBuilder(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(
          child: Center(
            child: Column(
              children: <Widget>[BackLogo()],
            ),
          ),
        );
      } else {
        if (snapshot.hasData) {
          return Creation();
        } else {
          return HomePage();
        }
      }
    },
  );
}

class BackLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('assets/transition.jpeg');
    Image image = Image(
      image: assetImage,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: image,
      color: Colors.white,
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
    );
  }
}
