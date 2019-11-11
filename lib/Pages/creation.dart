import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wup_dev_2/Pages/home.dart';

class Creation extends StatefulWidget {
  @override
  _CreationState createState() => _CreationState();
}

class _CreationState extends State<Creation> {
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
            backgroundColor: Colors.transparent,
            title: new Center(
              child: Text("Pagina de Criação WUP"),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
              )
            ],
          ),
          backgroundColor: Colors.transparent,
          body: Stack(children: <Widget>[
            new Column(
              children: <Widget>[
                SizedBox(
                  width: 60,
                  height: 100,
                ),
                Divider(),
                new Card(
                  child: new Container(
                    padding: EdgeInsets.fromLTRB(60, 20, 60, 20),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: new Border.all(color: Colors.black, width: 0.5),
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                    child: new InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateEvent1()));
                      },
                      child: new Text("Evento 1"),
                    ),
                  ),
                ),
                Divider(),
                new Card(
                  child: new Container(
                    padding: EdgeInsets.fromLTRB(60, 20, 60, 20),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: new Border.all(color: Colors.black, width: 0.5),
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                    child: new InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateEvent2()));
                      },
                      child: new Text("Evento 2"),
                    ),
                  ),
                ),
                Divider(),
                new Card(
                  child: new Container(
                    padding: EdgeInsets.fromLTRB(60, 20, 60, 20),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: new Border.all(color: Colors.black, width: 0.5),
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                    child: new InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateEvent3()));
                      },
                      child: new Text("Evento 3"),
                    ),
                  ),
                ),
              ],
            )
          ]),
        )
      ],
    );
  }
}

class CreateEvent1 extends StatefulWidget {
  @override
  _CreateEvent1State createState() => _CreateEvent1State();
}

class _CreateEvent1State extends State<CreateEvent1> {
  final _formKey = GlobalKey<FormState>();
  Future<File> fileImage;
  File imagem;

  Widget pic() {
    return FutureBuilder(
        future: fileImage,
        builder: (BuildContext conntext, AsyncSnapshot<File> s) {
          if (s.connectionState == ConnectionState.done && s.data != null) {
            imagem = s.data;
            return Image.file(
              s.data,
              height: 300.0,
              width: 300.0,
            );
          } else if (s.error != null) {
            return Text("Repita o processo");
          } else {
            return Text("Nenhuma imagem selecionada");
          }
        });
  }

  _selectImage() {
    setState(() {
      fileImage = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _dataController = TextEditingController();
  TextEditingController _enderecoController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _contatoController = TextEditingController();
  TextEditingController _siteController = TextEditingController();
  TextEditingController _redeController = TextEditingController();

  void limpaCampo() {
    _nomeController.text = "";
    _dataController.text = "";
    _enderecoController.text = "";
    _descricaoController.text = "";
    _contatoController.text = "";
    _siteController.text = "";
    _redeController.text = "";
  }

  @override
  void initState() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      FirebaseAuth.instance.currentUser().then((user) async {
        CollectionReference reference = Firestore.instance.collection('Evento');
        DocumentReference docReference = reference.document(user.uid + "1");

        docReference.get().then((doc) async {
          _nomeController.text = doc.data['Nome'];
          _dataController.text = doc.data['Data'];
          _enderecoController.text = doc.data['Endereco'];
          _descricaoController.text = doc.data['Descricao'];
          _contatoController.text = doc.data['Link'];
          _siteController.text = doc.data['Site'];
          _redeController.text = doc.data['RedeSocial'];
        });
      });
    });

    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(
          child: Text("Pagina do Evento 1"),
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
              }
            },
          )
        ],
      ),
      body: new Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "Nome"),
              controller: _nomeController,
              maxLength: 50,
              validator: (text) {
                if (text.isEmpty) return "Nome não Preenchido";
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Data"),
              controller: _dataController,
              maxLength: 10,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
                _birthDate,
              ],
              keyboardType: TextInputType.datetime,
              validator: (text) {
                if (text.isEmpty) return "Data não Preenchida";
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Fale sobre o Evento"),
              controller: _descricaoController,
              keyboardType: TextInputType.text,
              maxLength: 200,
              validator: (text) {
                if (text.isEmpty) return "Descrição não Preenchida";
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Endereço"),
              controller: _enderecoController,
              maxLength: 50,
              keyboardType: TextInputType.text,
              validator: (text) {
                if (text.isEmpty) return "Endereço não Preenchido";
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Numero de Contato"),
              controller: _contatoController,
              maxLength: 30,
              keyboardType: TextInputType.phone,
              validator: (text) {
                if (text.isEmpty) return "Contato não Preenchido";
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Site"),
              controller: _siteController,
              keyboardType: TextInputType.text,
              validator: (text) {
                if (text.isEmpty) return "Site não Preenchido";
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Rede Social"),
              controller: _redeController,
              keyboardType: TextInputType.text,
              validator: (text) {
                if (text.isEmpty) return "Rede Social não Preenchido";
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Text("Selecione uma Imagem"),
                SizedBox(
                  width: 30,
                ),
                IconButton(
                  onPressed: _selectImage,
                  color: Colors.blue,
                  icon: Icon(
                    Icons.add_a_photo,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            pic(),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: () {
                String url;
                if (_formKey.currentState.validate() && imagem != null) {
                  Firestore.instance
                      .runTransaction((Transaction transaction) async {
                    FirebaseAuth.instance.currentUser().then((user) async {
                      CollectionReference reference =
                          Firestore.instance.collection('Evento');
                      DocumentReference docReference =
                          reference.document(user.uid + "1");
                      StorageReference firebaseStorage =
                          FirebaseStorage.instance.ref().child(user.uid + "1");

                      StorageUploadTask task = firebaseStorage.putFile(imagem);

                      var dowurl =
                          await (await task.onComplete).ref.getDownloadURL();
                      url = dowurl.toString();
                      docReference.setData({
                        "Imagem": url,
                        "Nome": _nomeController.text,
                        "Data": _dataController.text,
                        "Descricao": _descricaoController.text,
                        "Endereco": _enderecoController.text,
                        "Link": _siteController.text,
                        "RedeSocial": _redeController.text,
                        "Site": _siteController.text,
                      }).whenComplete(() {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: new Text("Evento Salvo"),
                                content: new Text(""),
                                actions: <Widget>[
                                  new FlatButton(
                                      child: new Text("Fechar"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })
                                ],
                              );
                            });
                      });
                    });
                  });
                }
              },
              child: Text("Salvar Evento"),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Firestore.instance
                      .runTransaction((Transaction transaction) async {
                    FirebaseAuth.instance.currentUser().then((user) async {
                      CollectionReference reference =
                          Firestore.instance.collection('Evento');
                      DocumentReference docReference =
                          reference.document(user.uid + "1");

                      docReference.delete().whenComplete(() {
                        limpaCampo();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: new Text("Retirado com Sucesso"),
                                content: new Text(""),
                                actions: <Widget>[
                                  new FlatButton(
                                      child: new Text("Fechar"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })
                                ],
                              );
                            });
                      });
                    });
                  });
                }
              },
              child: Text("Excluir Evento"),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateEvent2 extends StatefulWidget {
  @override
  _CreateEvent2State createState() => _CreateEvent2State();
}

class _CreateEvent2State extends State<CreateEvent2> {
  final _formKey = GlobalKey<FormState>();
  Future<File> fileImage;
  File imagem;

  Widget pic() {
    return FutureBuilder(
        future: fileImage,
        builder: (BuildContext conntext, AsyncSnapshot<File> s) {
          if (s.connectionState == ConnectionState.done && s.data != null) {
            imagem = s.data;
            return Image.file(
              s.data,
              height: 200.0,
              width: 200.0,
            );
          } else if (s.error != null) {
            return Text("Repita o processo");
          } else {
            return Text("Nenhuma imagem selecionada");
          }
        });
  }

  _selectImage() {
    setState(() {
      fileImage = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _dataController = TextEditingController();
  TextEditingController _enderecoController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _contatoController = TextEditingController();
  TextEditingController _siteController = TextEditingController();
  TextEditingController _redeController = TextEditingController();

  void limpaCampo() {
    _nomeController.text = "";
    _dataController.text = "";
    _enderecoController.text = "";
    _descricaoController.text = "";
    _contatoController.text = "";
    _siteController.text = "";
    _redeController.text = "";
  }

  @override
  void initState() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      FirebaseAuth.instance.currentUser().then((user) async {
        CollectionReference reference = Firestore.instance.collection('Evento');
        DocumentReference docReference = reference.document(user.uid + "1");

        docReference.get().then((doc) async {
          _nomeController.text = doc.data['Nome'];
          _dataController.text = doc.data['Data'];
          _enderecoController.text = doc.data['Endereco'];
          _descricaoController.text = doc.data['Descricao'];
          _contatoController.text = doc.data['Link'];
          _siteController.text = doc.data['Site'];
          _redeController.text = doc.data['RedeSocial'];
        });
      });
    });

    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(
          child: Text("Pagina do Evento 2"),
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
              }
            },
          )
        ],
      ),
      body: new Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "Nome"),
              controller: _nomeController,
              maxLength: 50,
              validator: (text) {
                if (text.isEmpty) return "Nome não Preenchido";
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Data"),
              controller: _dataController,
              maxLength: 10,
              keyboardType: TextInputType.datetime,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
                _birthDate,
              ],
              validator: (text) {
                if (text.isEmpty) return "Data não Preenchida";
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Fale sobre o Evento"),
              controller: _descricaoController,
              keyboardType: TextInputType.text,
              maxLength: 200,
              validator: (text) {
                if (text.isEmpty) return "Descrição não Preenchida";
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Endereço"),
              controller: _enderecoController,
              maxLength: 50,
              keyboardType: TextInputType.text,
              validator: (text) {
                if (text.isEmpty) return "Endereço não Preenchido";
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Numero de Contato"),
              controller: _contatoController,
              maxLength: 30,
              keyboardType: TextInputType.phone,
              validator: (text) {
                if (text.isEmpty) return "Contato não Preenchido";
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Site"),
              controller: _siteController,
              keyboardType: TextInputType.text,
              validator: (text) {
                if (text.isEmpty) return "Site não Preenchido";
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Rede Social"),
              controller: _redeController,
              keyboardType: TextInputType.text,
              validator: (text) {
                if (text.isEmpty) return "Rede Social não Preenchido";
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Text("Selecione uma Imagem"),
                SizedBox(
                  width: 30,
                ),
                IconButton(
                  onPressed: _selectImage,
                  color: Colors.blue,
                  icon: Icon(
                    Icons.add_a_photo,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            pic(),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: () {
                String url;
                if (_formKey.currentState.validate() && imagem != null) {
                  Firestore.instance
                      .runTransaction((Transaction transaction) async {
                    FirebaseAuth.instance.currentUser().then((user) async {
                      CollectionReference reference =
                          Firestore.instance.collection('Evento');
                      DocumentReference docReference =
                          reference.document(user.uid + "2");
                      StorageReference firebaseStorage =
                          FirebaseStorage.instance.ref().child(user.uid + "2");

                      StorageUploadTask task = firebaseStorage.putFile(imagem);

                      var dowurl =
                          await (await task.onComplete).ref.getDownloadURL();
                      url = dowurl.toString();
                      docReference.setData({
                        "Imagem": url,
                        "Nome": _nomeController.text,
                        "Data": _dataController.text,
                        "Descricao": _descricaoController.text,
                        "Endereco": _enderecoController.text,
                        "Link": _siteController.text,
                        "RedeSocial": _redeController.text,
                        "Site": _siteController.text,
                      }).whenComplete(() {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: new Text("Evento Salvo"),
                                content: new Text(""),
                                actions: <Widget>[
                                  new FlatButton(
                                      child: new Text("Fechar"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })
                                ],
                              );
                            });
                      });
                    });
                  });
                }
              },
              child: Text("Salvar Evento"),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Firestore.instance
                      .runTransaction((Transaction transaction) async {
                    FirebaseAuth.instance.currentUser().then((user) async {
                      CollectionReference reference =
                          Firestore.instance.collection('Evento');
                      DocumentReference docReference =
                          reference.document(user.uid + "2");

                      docReference.delete().whenComplete(() {
                        limpaCampo();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: new Text("Retirado com Sucesso"),
                                content: new Text(""),
                                actions: <Widget>[
                                  new FlatButton(
                                      child: new Text("Fechar"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })
                                ],
                              );
                            });
                      });
                    });
                  });
                }
              },
              child: Text("Excluir Evento"),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateEvent3 extends StatefulWidget {
  @override
  _CreateEvent3State createState() => _CreateEvent3State();
}

class _CreateEvent3State extends State<CreateEvent3> {
  final _formKey = GlobalKey<FormState>();
  Future<File> fileImage;
  File imagem;

  Widget pic() {
    return FutureBuilder(
        future: fileImage,
        builder: (BuildContext conntext, AsyncSnapshot<File> s) {
          if (s.connectionState == ConnectionState.done && s.data != null) {
            imagem = s.data;
            return Image.file(
              s.data,
              height: 300.0,
              width: 300.0,
            );
          } else if (s.error != null) {
            return Text("Repita o processo");
          } else {
            return Text("Nenhuma imagem selecionada");
          }
        });
  }

  _selectImage() {
    setState(() {
      fileImage = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _dataController = TextEditingController();
  TextEditingController _enderecoController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _contatoController = TextEditingController();
  TextEditingController _siteController = TextEditingController();
  TextEditingController _redeController = TextEditingController();

  void limpaCampo() {
    _nomeController.text = "";
    _dataController.text = "";
    _enderecoController.text = "";
    _descricaoController.text = "";
    _contatoController.text = "";
    _siteController.text = "";
    _redeController.text = "";
  }

  @override
  void initState() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      FirebaseAuth.instance.currentUser().then((user) async {
        CollectionReference reference = Firestore.instance.collection('Evento');
        DocumentReference docReference = reference.document(user.uid + "1");

        docReference.get().then((doc) async {
          _nomeController.text = doc.data['Nome'];
          _dataController.text = doc.data['Data'];
          _enderecoController.text = doc.data['Endereco'];
          _descricaoController.text = doc.data['Descricao'];
          _contatoController.text = doc.data['Link'];
          _siteController.text = doc.data['Site'];
          _redeController.text = doc.data['RedeSocial'];
        });
      });
    });

    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(
          child: Text("Pagina do Evento 3"),
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
              }
            },
          )
        ],
      ),
      body: new Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "Nome"),
              controller: _nomeController,
              maxLength: 50,
              validator: (text) {
                if (text.isEmpty) return "Nome não Preenchido";
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Data"),
              controller: _dataController,
              maxLength: 10,
              keyboardType: TextInputType.datetime,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
                _birthDate,
              ],
              validator: (text) {
                if (text.isEmpty) return "Data não Preenchida";
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Fale sobre o Evento"),
              controller: _descricaoController,
              keyboardType: TextInputType.text,
              maxLength: 200,
              validator: (text) {
                if (text.isEmpty) return "Descrição não Preenchida";
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Endereço"),
              controller: _enderecoController,
              maxLength: 50,
              keyboardType: TextInputType.text,
              validator: (text) {
                if (text.isEmpty) return "Endereço não Preenchido";
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Numero de Contato"),
              controller: _contatoController,
              maxLength: 30,
              keyboardType: TextInputType.phone,
              validator: (text) {
                if (text.isEmpty) return "Contato não Preenchido";
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Site"),
              controller: _siteController,
              keyboardType: TextInputType.text,
              validator: (text) {
                if (text.isEmpty) return "Site não Preenchido";
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Rede Social"),
              controller: _redeController,
              keyboardType: TextInputType.text,
              validator: (text) {
                if (text.isEmpty) return "Rede Social não Preenchido";
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Text("Selecione uma Imagem"),
                SizedBox(
                  width: 30,
                ),
                IconButton(
                  onPressed: _selectImage,
                  color: Colors.blue,
                  icon: Icon(
                    Icons.add_a_photo,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            pic(),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: () {
                String url;
                if (_formKey.currentState.validate() && imagem != null) {
                  Firestore.instance
                      .runTransaction((Transaction transaction) async {
                    FirebaseAuth.instance.currentUser().then((user) async {
                      CollectionReference reference =
                          Firestore.instance.collection('Evento');
                      DocumentReference docReference =
                          reference.document(user.uid + "3");
                      StorageReference firebaseStorage =
                          FirebaseStorage.instance.ref().child(user.uid + "3");

                      StorageUploadTask task = firebaseStorage.putFile(imagem);

                      var dowurl =
                          await (await task.onComplete).ref.getDownloadURL();
                      url = dowurl.toString();
                      docReference.setData({
                        "Imagem": url,
                        "Nome": _nomeController.text,
                        "Data": _dataController.text,
                        "Descricao": _descricaoController.text,
                        "Endereco": _enderecoController.text,
                        "Link": _siteController.text,
                        "RedeSocial": _redeController.text,
                        "Site": _siteController.text,
                      }).whenComplete(() {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: new Text("Evento Salvo"),
                                content: new Text(""),
                                actions: <Widget>[
                                  new FlatButton(
                                      child: new Text("Fechar"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })
                                ],
                              );
                            });
                      });
                    });
                  });
                }
              },
              child: Text("Salvar Evento"),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Firestore.instance
                      .runTransaction((Transaction transaction) async {
                    FirebaseAuth.instance.currentUser().then((user) async {
                      CollectionReference reference =
                          Firestore.instance.collection('Evento');
                      DocumentReference docReference =
                          reference.document(user.uid + "3");

                      docReference.delete().whenComplete(() {
                        limpaCampo();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: new Text("Retirado com Sucesso"),
                                content: new Text(""),
                                actions: <Widget>[
                                  new FlatButton(
                                      child: new Text("Fechar"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })
                                ],
                              );
                            });
                      });
                    });
                  });
                }
              },
              child: Text("Excluir Evento"),
            ),
          ],
        ),
      ),
    );
  }
}

final _UsNumberTextInputFormatter _birthDate =
    new _UsNumberTextInputFormatter();

class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();
    if (newTextLength >= 3) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 2) + '/');
      if (newValue.selection.end >= 2) selectionIndex++;
    }
    if (newTextLength >= 5) {
      newText.write(newValue.text.substring(2, usedSubstringIndex = 4) + '/');
      if (newValue.selection.end >= 4) selectionIndex++;
    }
    if (newTextLength >= 9) {
      newText.write(newValue.text.substring(4, usedSubstringIndex = 8));
      if (newValue.selection.end >= 8) selectionIndex++;
    }
// Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
