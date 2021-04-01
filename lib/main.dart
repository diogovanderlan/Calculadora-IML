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
  TextEditingController weightController = TextEditingController();
  TextEditingController heigtcontroller = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";


  void _resetFields(){
    weightController.text = "";
    heigtcontroller.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });

  }


  void _calculate(){
  setState(() {

    double weight = double.parse(weightController.text);
    double heigt = double.parse(heigtcontroller.text) / 100;
    double imc = weight / (heigt * heigt);

    if(imc < 18.6){
      _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
    } else if(imc >= 18.6 && imc < 24.9){
      _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
    } else if( imc >= 24.9 && imc < 29.9){
      _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
    } else if ( imc >= 29.9 && imc < 34.9){
      _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
    } else if ( imc >= 34.9 && imc < 39.9){
      _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
    } else if ( imc >= 40){
      _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
    }

  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white, //cor do fundo
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          // bordas do telefone
          child: Form(
            key: _formKey, // formulario
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .stretch, //tenta centralizaer e ocupar toda a coluna
              children: <Widget>[
                Icon(Icons.person_outline, size: 120.0, color: Colors.grey[900]),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.grey[900])),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[900], fontSize: 25.0),
                  controller:
                  weightController,
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira seu Peso!";
                    }
                  },// passando o controler para a funcao
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (Cm)",
                      labelStyle: TextStyle(color: Colors.grey[900])),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[900], fontSize: 25.0),
                  controller: heigtcontroller,
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira sua Altura!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  //espacando o botao
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.grey[900],
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[900], fontSize: 25.0),
                )
              ],
            ),
          ),
        ));
  }
}
