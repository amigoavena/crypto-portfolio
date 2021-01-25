import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Price> fetchAlbum() async {
  final response =
  await http.get('https://api.binance.com/api/v3/avgPrice?symbol=XRPUSDT');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Price.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Price {
  final int min;
  final double price;

  Price({this.min, this.price});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      min: json['min'],
      price: json['price']
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Price> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PortFolio - Litium',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('PortFolio - Litium'),
        ),
        body: Center(
          child: FutureBuilder<Price>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String val = snapshot.data.price.toString();
                return Text(val);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}