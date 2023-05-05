import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/screens/home.dart';

class Splashscreeen extends StatelessWidget {
  const Splashscreeen({Key? key}) : super(key: key);

  Future<void> gotoHomeScreen(context) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    final position = await getCurrentLocation();
    final lat = position.latitude;
    final long = position.latitude;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(latitude: lat, longitude: long),
      ),
    );
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location service are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission are dined');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permission are permently denied, We cannot request');
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await gotoHomeScreen(context);
    });
    return Scaffold(
      backgroundColor: const Color(0xff161616),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Weather App',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                  color: Colors.amber),
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(strokeWidth: 2, color: Colors.amber)
          ],
        ),
      ),
    );
  }
}
