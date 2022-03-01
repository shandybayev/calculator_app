import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key key}) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation = '0';
  String result = '0';
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;


  buttonPressed(String buttonText) {
    setState(() {

      if (buttonText == 'C') {
        equation = '0';
        result = '0';
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }

      else if (buttonText == '⌫') {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = '0';
        }
      }

      else if (buttonText == '=') {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch(e) {
          result = "Error";
        }
      }

      else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == '0') {
          equation = buttonText;
        } else {
          equation += buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * .1 * buttonHeight,
      padding: EdgeInsets.all(5),
      child: FlatButton(
        shape: CircleBorder(

        ),
        padding: EdgeInsets.all(16),
        color: buttonColor,
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator'),),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
              child: Text(equation, style: TextStyle(fontSize: equationFontSize),),
            ),

            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 30, 20, 0),
              child: Text(result, style: TextStyle(fontSize: resultFontSize),),
            ),

            Expanded(
              child: Divider(),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buildButton('C', 1, Colors.redAccent),
                          buildButton('⌫', 1, Colors.redAccent),
                          buildButton('%', 1, Colors.redAccent),
                        ]
                      ),

                      TableRow(
                          children: [
                            buildButton('7', 1, Colors.black54),
                            buildButton('8', 1, Colors.black54),
                            buildButton('9', 1, Colors.black54),
                          ]
                      ),

                      TableRow(
                          children: [
                            buildButton('4', 1, Colors.black54),
                            buildButton('5', 1, Colors.black54),
                            buildButton('6', 1, Colors.black54),
                          ]
                      ),

                      TableRow(
                          children: [
                            buildButton('1', 1, Colors.black54),
                            buildButton('2', 1, Colors.black54),
                            buildButton('3', 1, Colors.black54),
                          ]
                      ),

                      TableRow(
                          children: [
                            buildButton('.', 1, Colors.black54),
                            buildButton('0', 1, Colors.black54),
                            buildButton('00', 1, Colors.black54),
                          ]
                      ),
                    ],
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width * .25,
                  child: Table(
                    children: [

                      TableRow(
                          children: [
                            buildButton('÷', 1, Colors.blue),
                          ]
                      ),

                      TableRow(
                        children: [
                          buildButton('×', 1, Colors.blue),
                        ]
                      ),

                      TableRow(
                          children: [
                            buildButton('-', 1, Colors.blue),
                          ]
                      ),

                      TableRow(
                          children: [
                            buildButton('+', 1, Colors.blue),
                          ]
                      ),

                      TableRow(
                          children: [
                            buildButton('=', 1, Colors.blue),
                          ]
                      ),
                    ],
                  ),
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
}

