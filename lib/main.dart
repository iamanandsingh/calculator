import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyCal());
}

class MyCal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String equation = "0";
  String result = "0";
  String expression = "0";
  double equationsize = 40;
  double resultsize = 50;

  buttonpressed(name) {
    setState(() {
      if (name == "C") {
        equation = "0";
        result = "0";
        equationsize = 40;
        resultsize = 50;
      } else if (name == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        equationsize = 50;
        resultsize = 40;

        if (equation == "") {
          equation = "0";
        }
      } else if (name == "=") {
        equationsize = 40;
        resultsize = 50;

         expression=equation;
      expression=expression.replaceAll("x", "*");
            expression=expression.replaceAll("÷", "/");


      try {
          Parser p = Parser();
  Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
      result= "${exp.evaluate(EvaluationType.REAL, cm)}";

    
      } catch (e) {
        result="Error";
      }
      } 
      
      else {
        equationsize = 50;
        resultsize = 40;
        if (equation == "0") 
        {
          equation = name;
        } 
        else {
          equation += name;
        }
      }
     
    });
  }

  Widget button(String name, Color color, double buttonheight) {
    return Container(
      height: MediaQuery.of(context).size.height * .09 * buttonheight,
      color: color,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            side: BorderSide(
          color: Colors.white,
          width: 1,
        )),
        onPressed: () => buttonpressed(name),
        child: Text(
          name,
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Calculator"),
        backgroundColor: Colors.purple[900],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 0, 10),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationsize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 0, 10),
            child: Text(
              result,
              style: TextStyle(fontSize: resultsize),
            ),
          ),
          Expanded(child: Divider(color: Colors.white)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Table(
                children: [
                  TableRow(children: [
                    button("C", Colors.purple[900], 1),
                    button("⌫", Colors.purple[900], 1),
                    button("÷", Colors.deepPurple[800], 1),
                  ]),
                  TableRow(children: [
                    button("7", Colors.purple[200], 1),
                    button("8", Colors.purple[200], 1),
                    button("9", Colors.purple[200], 1),
                  ]),
                  TableRow(children: [
                    button("4", Colors.purple[200], 1),
                    button("5", Colors.purple[200], 1),
                    button("6", Colors.purple[200], 1),
                  ]),
                  TableRow(children: [
                    button("1", Colors.purple[200], 1),
                    button("2", Colors.purple[200], 1),
                    button("3", Colors.purple[200], 1),
                  ]),
                  TableRow(children: [
                    button("0", Colors.purple[200], 1),
                    button("00", Colors.purple[200], 1),
                    button(".", Colors.purple[200], 1),
                  ]),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                    TableRow(children: [
                      button("+", Colors.deepPurple[800], 1),
                    ]),
                    TableRow(children: [
                      button("x", Colors.deepPurple[800], 1),
                    ]),
                    TableRow(children: [
                      button("-", Colors.deepPurple[800], 1),
                    ]),
                    TableRow(children: [
                      button("=", Colors.purple[900], 2),
                    ]),
                  ],
                )),
          ])
        ],
      ),
    );
  }
}
