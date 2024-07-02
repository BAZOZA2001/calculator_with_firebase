import 'package:flutter/material.dart';
import 'package:calculator_app/widgets/custom_drawer.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  List<dynamic> inputList = [];
  String output = '0';

  void _handleClear() {
    setState(() {
      inputList = [];
      output = '0';
    });
  }

  void _handlePress(String input) {
    setState(() {
      if (_isOperator(input)) {
        if (inputList.isNotEmpty && inputList.last is int) {
          inputList.add(input);
          output += ' $input ';
        } else if (inputList.isNotEmpty && inputList.last is String) {
          inputList.last = input;
          output = output.substring(0, output.length - 3) + ' $input ';
        }
      } else if (input == '=') {
        if (inputList.isNotEmpty && inputList.last is String) {
          inputList.removeLast();
        }
        while (inputList.length > 2) {
          int firstNumber = inputList.removeAt(0) as int;
          String operator = inputList.removeAt(0);
          int secondNumber = inputList.removeAt(0) as int;
          int partialResult = _calculate(firstNumber, secondNumber, operator);
          inputList.insert(0, partialResult);
        }
        output = inputList.isEmpty ? '0' : '${inputList[0]}';
      } else {
        int? inputNumber = int.tryParse(input);
        if (inputNumber != null) {
          if (inputList.isNotEmpty && inputList.last is int) {
            int lastNumber = (inputList.last as int) * 10 + inputNumber;
            inputList.last = lastNumber;
            output = output.substring(0, output.lastIndexOf(' ') + 1) +
                lastNumber.toString();
          } else {
            inputList.add(inputNumber);
            output = output == '0' ? input : output + input;
          }
        }
      }
    });
  }

  int _calculate(int a, int b, String operator) {
    switch (operator) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '*':
        return a * b;
      case '/':
        return b != 0 ? a ~/ b : a;
      default:
        return a;
    }
  }

  bool _isOperator(String input) {
    return ['+', '-', '*', '/'].contains(input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("IJ'S CALCULATOR")),
      drawer: CustomDrawer(onItemTap: (index) {
        // handle navigation based on the index
      }),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            children: <Widget>[
              ...[7, 8, 9, '/'].map((e) => _buildButton(e.toString())),
              ...[4, 5, 6, '*'].map((e) => _buildButton(e.toString())),
              ...[1, 2, 3, '-'].map((e) => _buildButton(e.toString())),
              _buildButton('C'),
              _buildButton('0'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return Container(
      margin: EdgeInsets.all(8),
      child: ElevatedButton(
        child: Text(text, style: TextStyle(fontSize: 24)),
        onPressed: () => text == 'C' ? _handleClear() : _handlePress(text),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
