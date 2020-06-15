
# Google Dart Container with Dart HTTP Server and Flutter Web App
# https://cloud.google.com/appengine/docs/flexible/custom-runtimes - App Engine Custom Runtime

# https://hub.docker.com/r/google/dart/
FROM google/dart

# Working directory with the source in the container
WORKDIR /app

## Copy the source and download the dependencies
ADD ./dist/pubspec.* /app/
RUN pub get
ADD ./dist /app
RUN pub get --offline

# Start the Dart web server
ENTRYPOINT ["/usr/bin/dart", "/app/lib/server.dart"]

# Expose the port that App Engine Flex will point to
EXPOSE 8080
