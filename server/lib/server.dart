import 'dart:io';
import 'package:mime_type/mime_type.dart';

var baseExecPath;

/// Use a VS Code launcher to launch this
/// OR use dart CLI Run `dart ./lib/server.dart`
main() async {
  // Note: Must listen on any IP address
  var server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);
  baseExecPath = Platform.script.path.replaceAll('/lib/server.dart', '');

  print('Serving at ${server.address}:${server.port}');
  print('Script execution base path is $baseExecPath');

  print('Try it out: http://localhost:${server.port}/');
  print('Try it out: http://localhost:${server.port}/api');
  print('Try it out: http://localhost:${server.port}/api/getMessage');

  // Listen for requests
  await for (var request in server) {
    handleRequest(request);
  }
}

/// http://localhost:8080
/// http://localhost:8080/index.html
/// http://localhost:8080/api
/// http://localhost:8080/api/getMessage - json
void handleRequest(HttpRequest request) {
  final uri = request.uri;
  if (uri.path.contains('/api')) {
    _handleApiRequest(request);
  } else {
    _handleStaticFilesRequest(request);
  }
}

void _handleApiRequest(HttpRequest request) {
  final uri = request.uri;

  print('Request: Handle api request: uri=${uri.path}');

  if (uri.path == '/api') {
    request.response
      ..headers.contentType = ContentType.html
      ..write('./api works. Try <a href="/api/getMessage">/api/getMessage</a>')
      ..close();
  } else if (uri.path == '/api/getMessage') {
    request.response
      ..headers.contentType = ContentType.json
      ..headers.add("Access-Control-Allow-Origin", "*") // CORS
      ..headers.add(
          "Access-Control-Allow-Methods", "POST,GET,DELETE,PUT,OPTIONS") // CORS
      ..write('{ "message": "The board is green." }')
      ..close();
  } else {
    _handle404(request);
  }
}

void _handleStaticFilesRequest(HttpRequest request) async {
  final uri = request.uri;
  var path = uri.path;

  // Normalize path ending
  if (path.endsWith('/')) {
    path = path.substring(0, path.length - 1);
  }
  // Provide default index.html
  if (!path.contains(".")) {
    path += "/index.html";
  }
  // Set the absolute file to serve
  final filePath = '$baseExecPath/html$path';

  //print("path=$path");
  print('Request: static server filePath=$filePath');

  // Stream file to client
  final File file = await new File(filePath);
  file.exists().then((found) {
    if (found) {
      String mimeType = mime(filePath);
      if (mimeType == null) mimeType = 'text/plain; charset=UTF-8';
      request.response.headers.set('Content-Type', mimeType);
      file.openRead().pipe(request.response).catchError((e) {
        print('openRead error $e');
      });
    } else {
      _handle404(request);
    }
  });
}

void _handle404(HttpRequest request) {
  request.response
    ..headers.contentType = ContentType.html
    ..write('404')
    ..close();
}
