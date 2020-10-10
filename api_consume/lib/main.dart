//***********************************************************
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<FormState> cForm = GlobalKey<FormState>();
  String city = "Cidade: ";
  String date = "Data: ";
  String description = "Descrição: ";
  String temp = "Temperatura:";

  clicouBotao() async {
    if (!cForm.currentState.validate()) return;
    String url = "https://api.hgbrasil.com/weather?woeid=455827/json";
    Response resposta = await get(url);
    Map clima = json.decode(resposta.body);
    setState(() {
      city = "Cidade: " + clima["results"]["city"];
      date = "Data: " + clima["results"]["date"];
      description = "Descrição: " + clima["results"]["description"];
      temp = "Temperatura : " + clima["results"]["temp"].toString() + "º";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: cForm,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                ),
              Container(
                alignment: Alignment.center,
                height: 100,
                child: IconButton(
                  onPressed: clicouBotao,
                  icon: FaIcon(
                    FontAwesomeIcons.thermometerEmpty,
                    size: 64,
                    color: Colors.blue,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Componentes.rotulo(city),
                    Componentes.rotulo(date),
                    Componentes.rotulo(description),
                    Componentes.rotulo(temp),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//************************************************************
class Componentes {
  static rotulo(String rotulo) {
    return Text(
      rotulo,
      style: TextStyle(
          color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  static botao(Function _f) {
    return Container(
      child: RaisedButton(
        onPressed: _f,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.black, width: 4)),
        color: Colors.black87.withOpacity(0.4),
        hoverColor: Colors.yellow.withOpacity(0.3),
      ),
    );
  }
}
