import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'MyApp.dart';

void main() {
  FlavorConfig(environment: FlavorEnvironment.PROD, variables: {
    "baseUrl": "https://donnelson-sandbox-flex.appspot.com",
  });

  runApp(MyApp());
}
