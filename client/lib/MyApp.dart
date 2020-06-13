import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:http/http.dart' as http;    
import 'dart:convert';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter App'),
    );
  }
}

class ServerMessage {
  final String message;

  ServerMessage({this.message});

  factory ServerMessage.fromJson(Map<String, dynamic> json) {
    return ServerMessage(message: json['message']);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _serverMessage = '';

  void _callWebServer() {
    _fetchServerMessage();
  }

  _fetchServerMessage() async {
    final baseUrl = FlavorConfig.instance.variables["baseUrl"];
    final url = '$baseUrl/api/getMessage';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final serverMessage = ServerMessage.fromJson(json);
      _updateServerMessage(serverMessage);
    } else {
      throw Exception('Failed to load album');
    }
  }

  void _updateServerMessage(ServerMessage serverMessage) {
    setState(() {
      _serverMessage = serverMessage.message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Try local api request'),
                onPressed: _callWebServer,
              ),
              Text(
                '$_serverMessage',
                style: Theme.of(context).textTheme.headline4,
              ),
            ]),
      ),
    );
  }
}
