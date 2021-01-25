import 'package:flutter/material.dart';
import 'coin_view.dart';
import 'locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello World Travel Title",
      home: Scaffold(
        appBar: AppBar(
          title: Text("PortFolio"),
          backgroundColor: Colors.deepPurple,
          ),
        body: Builder(
          builder: (context) => Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(children: [
                Row(
                  children: <Widget>[
                  Text(
                    'XRP/USDT',
                    style: TextStyle(fontSize: 14, color:
                      Colors.deepPurpleAccent),
                    ),
                  Padding(
                    padding: EdgeInsets.only(left:80),
                    child:
                    Text(
                      roundForLabel(.1212313),
                      style: TextStyle(fontSize: 16, color:
                        Colors.red),
                      )
                    ),
                  Padding(
                    padding: EdgeInsets.only(left:50),
                    child:
                    Text(
                      '.1212313',
                      style: TextStyle(fontSize: 16, color:
                        Colors.red),
                      )
                    )
                  ],
                ),
                CoinView(),
                RaisedButton(
                  child: Text('Contact Us'),
                  onPressed: () => contactUs(context),
                  ),
                ])
              )
            )
          )
        )
      );
  }

  String roundForLabel(double val){
    return val.toString();
  }

  void contactUs(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Contact Us'),
          content: Text('Mail us at hello@world.com'),
          actions: <Widget>[
          FlatButton(
            child: Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
            )
          ],
          );
        },
        );
  }
}