import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesotController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String _infoText = "Informe as Medidas";

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void _resetField() {
    pesotController.text = "";
    alturaController.text = "";
    setState(() {
      _infoText = "Informe as Medidas";
      _formkey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double peso = double.parse(pesotController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      print(imc);
      if (imc < 18.6) {
        _infoText = "Imc Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc <= 24.9) {
        _infoText = "Pso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc <= 29.9) {
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc <= 34.9) {
        _infoText = "Obesidade Grau 1 (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc <= 39.9) {
        _infoText = "Obesidade Grau 2 (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau 3 (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetField)
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.person_outline, size: 120, color: Colors.green),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Peso(KG)",
                        labelStyle: TextStyle(color: Colors.green),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 25),
                      controller: pesotController,
                      validator: (Value) {
                        if (Value.isEmpty) {
                          return "insira seu peso";
                        }
                      }),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Altura(Cm)",
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    controller: alturaController,
                    validator: (Value) {
                      if (Value.isEmpty) {
                        return "insira sua Altura";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                        height: 50,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              _calculate();
                            }
                          },
                          child: Text(
                            "Calcular",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          color: Colors.green,
                        )),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                  )
                ],
              ),
            )));
  }
}
