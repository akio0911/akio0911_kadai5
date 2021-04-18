import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _result = 0;

  TextEditingController _number1Controller = TextEditingController();
  TextEditingController _number2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          _buildItems(),
        ],
      ),
    );
  }

  Widget _buildItems() {
    return Column(
      children: <Widget>[
        SizedBox(height: 8),
        _buildTextFieldsRow(),
        SizedBox(height: 8),
        _buildCalculationButton(context: context),
        SizedBox(height: 8),
        _buildResultText(),
      ],
    );
  }

  Widget _buildNumber1TextField() {
    return TextField(
      controller: _number1Controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: '数値1',
      ),
    );
  }

  Widget _buildNumber2TextField() {
    return TextField(
      controller: _number2Controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: '数値2',
      ),
    );
  }

  Widget _buildOperatorText() {
    return Text('÷');
  }

  Widget _buildTextFieldsRow() {
    return Row(
      children: [
        SizedBox(width: 8),
        Container(
          width: 100,
          child: _buildNumber1TextField(),
        ),
        SizedBox(width: 8),
        _buildOperatorText(),
        SizedBox(width: 8),
        Container(
          width: 100,
          child: _buildNumber2TextField(),
        ),
      ],
    );
  }

  Widget _buildCalculationButton({BuildContext context}) {
    return RaisedButton(
      child: Text('計算'),
      color: Colors.blue,
      textColor: Colors.white,
      onPressed: () {
        setState(() {
          if (_number1Controller.text.isEmpty) {
            _showDialog(context: context, message: '割られる数を入力してください');
            return;
          }

          if (_number2Controller.text.isEmpty) {
            _showDialog(context: context, message: '割る数を入力してください');
            return;
          }

          final number1 = double.tryParse(_number1Controller.text);
          final number2 = double.tryParse(_number2Controller.text);

          if (number1 == null || number2 == null) {
            _showDialog(context: context, message: '有効な数値を入力してください');
            return;
          }

          if (number2 == 0) {
            _showDialog(context: context, message: '割る数には0を入力しないでください');
            return;
          }

          setState(() {
            _result = number1 / number2;
          });
        });
      },
    );
  }

  Widget _buildResultText() {
    return Text('$_result');
  }

  void _showDialog({BuildContext context, String message}) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Text(message),
          actions: [
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
