import 'package:flutter/material.dart';
import 'package:weather_app/model/weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, required this.latitude, required this.longitude});
  final double latitude;
  final double longitude;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map? map;
  String weather = '';
  String cityName = '';
  String countryName = '';
  double windspeed = 0;

  final cityContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff161616),
      appBar: AppBar(
        backgroundColor: const Color(0xff161616),
        title: const Text(
          'Weather App',
          style: TextStyle(color: Colors.amber),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () async {
              final currentWeather = await WeatherModel.getCurrentWeather(
                  latitude: widget.latitude, longitude: widget.longitude);

              setState(() {
                weather = currentWeather.weather.toString();
                cityName = currentWeather.name!;
              });
            },
            icon: const Icon(
              Icons.location_on_outlined,
              color: Colors.amber,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              style: const TextStyle(color: Colors.amber),
              textCapitalization: TextCapitalization.sentences,
              controller: cityContoller,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 2, color: Colors.amber), //<-- SEE HERE
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintText: 'search location to check weather',
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.all(17),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber, width: 2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow, width: 1.5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.amber)),
              onPressed: () async {
                final currentWeather = await WeatherModel.getCityWeather(
                  cityName: cityContoller.text,
                );

                setState(() {
                  weather = currentWeather.weather.toString();
                  countryName = currentWeather.countryName!;
                  cityName = currentWeather.name!;
                  windspeed = currentWeather.windspeed!;
                });
              },
              child: const Text(
                'Get Weather',
                style: TextStyle(
                  color: Color(0xff161616),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Current Weather : $weather',
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.amber),
                    ),
                    const Divider(
                      color: Colors.amber,
                      thickness: 1,
                      endIndent: 10,
                      indent: 10,
                    ),
                    Text(
                      'Wind Speed : $windspeed',
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.amber),
                    ),
                    const Divider(
                      color: Colors.amber,
                      thickness: 1,
                      endIndent: 10,
                      indent: 10,
                    ),
                    Text(
                      'country Name : $countryName',
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.amber),
                    ),
                    const Divider(
                      color: Colors.amber,
                      endIndent: 10,
                      indent: 10,
                      thickness: 1,
                    ),
                    Text(
                      'City Name : $cityName',
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.amber),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
