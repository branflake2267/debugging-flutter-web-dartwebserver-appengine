import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'MyApp.dart';

void main() {
  FlavorConfig(environment: FlavorEnvironment.PROD, variables: {
    "baseUrl": "http://dartserver-staging-v1.eba-rhptv8q6.us-west-2.elasticbeanstalk.com",
  });

  runApp(MyApp());
}
