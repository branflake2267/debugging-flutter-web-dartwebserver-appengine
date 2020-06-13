# Debugging and Deploying a Flutter Web App To Elastic Beanstalk
Debugging and deploying a Flutter web app with Dart HTTP web server to Elastic Beanstalk.

[![Build Status](https://travis-ci.org/branflake2267/debugging-flutter-android-ios-web-dartwebserver.svg?branch=master)](https://travis-ci.org/branflake2267/debugging-flutter-android-ios-web-dartwebserver)

[![Debugging Video Tutorial](https://img.youtube.com/vi/yoAdPgw7YLM/0.jpg)](https://www.youtube.com/watch?v=yoAdPgw7YLM)
 

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
| Tutorial | [Youtube Tutorial](https://youtu.be/I3EC96lTJB4) |


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
Make sure things work locally in the `eb local run` runner!

* Run `eb local run`
* Open http://localhost:8080

| Docker cmd | Details |
| --- | --- |
| docker ps | list the docker containers and [container id]s |
| docker exec -it [container id] bash| /bin/bash into the container. (The container name could be used as well.) |
| eb local run | This will run the Dockerrun.aws.json multi-container configuration  |  



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

### Configure AWS & EB CLI
Configure the AWS CLI and EB CLI utilities.

* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
* [Configure AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
* [EB CLI](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3.html)

Run `aws configure` to configure the AWS credentials locally.




#### Create Elastic Beanstalk Application
Set up the Elastic Beanstalk application.

Run `eb init` to configure the Elastic Beanstalk hosting config.

* Choose the datacenter that makes sense to you. (I'll choose the default.)
* Choose `Create New Application` and I use the default application name in this example.
* Choose `Multi-container Docker` and the latest version.
* Do not choose CodeCommit in this config.
* Choose the SSH key to setup SSH, if you want to use SSH.

This will create a project file [./.elasticbeanstalk/config.yml](./.elasticbeanstalk/config.yml).

#### Create Elastic Beanstalk Environment.
Set up an Elastic environment for your application. 

Run `eb create dartserver-staging-v1` where `dartserver-staging-v1` is the enviornment name you choose. 

#### Docker Config
The `Dockerrun.aws.json` will configure the docker container when deployed. 
In this configuration I won't show how to build and deploy a Docker image to ECR.


