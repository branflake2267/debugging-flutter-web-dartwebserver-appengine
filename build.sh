# Build 
# This will copy the built resources to the build director ./dist. 
# Run `sh ./build.sh`

# Clean previous build
echo "Clean ./dist"
rm -rf ./dist
mkdir ./dist

# Build server
echo "Build Server"
cd ./server
pwd
# Fetch the Dependencies
pub get
cd ..

# Build app
echo "Build Client"
cd ./client
pwd
# Fetch the flutter/dart dependencies
flutter pub get
# Used with Travis flutter
flutter build web
cd ..


# Build server in the ./dist directory
# Copy the server resources (dart web server)
echo "Copy Resources to ./dist"
pwd
ls
cp -R ./server/* ./dist
# Copy the client resources (flutter app)
cp -R ./client/build/web/* ./dist/html


echo "Finished building...";
