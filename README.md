# Debugging and Deploying a Flutter Web App To Elastic Beanstalk
Debugging and deploying a Flutter web app with Dart HTTP web server to Elastic Beanstalk.

[![Build Status](https://travis-ci.org/branflake2267/debugging-flutter-web-dartwebserver-appengine.svg?branch=master)](https://travis-ci.org/branflake2267/debugging-flutter-web-dartwebserver-appengine)

[![Debugging Video Tutorial](https://img.youtube.com/vi/lrUrE8F2lNw/0.jpg)](https://www.youtube.com/watch?v=lrUrE8F2lNw)
 

## Project Configuration 
| Setting | Value |
| --- | --- |
| Purpose | Debugging futter web app with dart web server hosted on Elastic Beanstalk |
| Client | Flutter web app |
| Server | Dart http web server |
| Client Language | Dart |
| Server Language | Dart |
| Architecture | Flutter/Dart |
| IDE | Visual Studio Code |
| CI | Travis CI |
| Hosting | Elastic Beanstalk |
| License | GPL v3 |
| Tutorial | [Youtube Tutorial](https://youtu.be/lrUrE8F2lNw) |


## Debugging

### Debugging Client CLI

* Run `cd ./client` to change into the server directory.
* Run `pub get` to initialize the project.
* Run `flutter run -d chrome`

### Debugging Server CLI

* Run `cd ./server` to change into the server directory.
* Run `pub get` to initialize the project.
* Run `dart ./lib/server/server.dart`


### Debugging with VS Code

* Use the VS Code Launcher `1. Launch Server`
* Use the VS Code Launcher `2. Launch Flutter Web App`

#### VS Code Endpoints

* http://localhost:54432/#/ - client 
* http://localhost:8080 - server
* http://localhost:8080/api - server
* http://localhost:8080/api/getMessage - server


### Debugging Docker
Used for debugging deployment config. 

#### Debugging Docker Container

* Run `sh ./debug-docker-container-config.sh`
* Open http://localhost:8080

| Docker cmd | Details |
| --- | --- |
| docker ps | list the docker containers and [container id]s |
| docker exec -it [container id] bash| /bin/bash into the container. (The container name could be used as well.) |



## Init Reference

### Install Dart
The [dart tools](https://dart.dev/get-dart) are required to use this project. 

### Install VS Code Dart Plugin
Install the Dart VS Code plugin. 

Add the program launcher, to launch the web server.
```
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Launch Web Server",
      "program": "lib/server.dart",
      "request": "launch",
      "type": "dart"
    }
  ]
}
```

## Generate Flutter Web App

* [Generate a Flutter Web App Instructions](https://flutter.dev/docs/get-started/web)
* I ran `flutter create client` to create an app named client.


### Cloud Tools CLI Installation

1. Sign up for [Google Cloud Compute](https://console.cloud.google.com/).
2. Create a GCP project.
3. Create an App Engine Application https://console.cloud.google.com/appengine/start.
    - This app is Node.js & a Standard App Engine deployment.
    - Download Cloud SDK CLI tools
    - Run `gcloud init`
    - Run `gcloud app create` - create a flex project
4. Create a service account for App Engine Admin for deployments. 
    - And be sure you add the `Cloud Build API` permissions to the services account. 
    - And turn on the [Cloud API Dash](https://console.developers.google.com/apis/api/cloudbuild.googleapis.com/overview) for the project.
5. Create an App Engine project in the console https://console.cloud.google.com/appengine.
    - After you create an app engine project, follow the App Engine getting strted instructions on how to install Cloud CLI.

### app.yaml
[app.yaml](./server/app.yaml) configures the App Engine web hosting service options. [app.yaml reference](https://cloud.google.com/appengine/docs/standard/nodejs/config/appref)



