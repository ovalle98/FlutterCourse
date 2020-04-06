import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class GetLocationPage extends StatefulWidget {
  @override
  _GetLocationPageState createState() => _GetLocationPageState();
}

class _GetLocationPageState extends State<GetLocationPage> {
  final Location location = Location();
  Geolocator geolocator = Geolocator();

  Position position;
  LocationData userLocation;
  List<Placemark> placemark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userLocation == null
                ? CircularProgressIndicator()
                : Text("Location:" +
                    userLocation.latitude.toString() +
                    " " +
                    userLocation.longitude.toString()
                    + " " +
                    placemark[0].locality),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: _getLocation,
                color: Colors.blue,
                child: Text("Get Location", style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getLocation() async {
    try {
      final LocationData _locationResult = await location.getLocation();
      position = await geolocator.getCurrentPosition();
      placemark = await Geolocator().placemarkFromCoordinates(_locationResult.latitude, _locationResult.longitude);
      setState(() {
        userLocation = _locationResult;
      });
    } catch (e) {
      setState(() {
        userLocation = null;
      });
    }
  }
}