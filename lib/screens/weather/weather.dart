import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:v4/controllers/location_controller.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  String _currentWeather = '';
  String _currentTemp = '';
  List<dynamic> _forecast = [];

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    final locationController = Get.find<LocationController>();
    final currentCity = locationController.getCurrentCity();

    final currentWeatherUrl =
        'http://api.weatherapi.com/v1/current.json?key=4e66b71c66fb48bdb4275305241202&q=$currentCity';
    final forecastUrl =
        'http://api.weatherapi.com/v1/forecast.json?key=4e66b71c66fb48bdb4275305241202&q=$currentCity&days=7';

    try {
      final currentWeatherResponse =
          await http.get(Uri.parse(currentWeatherUrl));
      final forecastResponse = await http.get(Uri.parse(forecastUrl));

      if (currentWeatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        final currentWeatherData = jsonDecode(currentWeatherResponse.body);
        final forecastData = jsonDecode(forecastResponse.body);

        setState(() {
          _currentWeather = currentWeatherData['current']['condition']['text'];
          _currentTemp = currentWeatherData['current']['temp_c'].toString();
          _forecast = forecastData['forecast']['forecastday'];
        });
      } else {
        print('Failed to load weather data');
      }
    } catch (e) {
      print('Failed to load weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0E1219),
      appBar: AppBar(
        title: Text("Weather", style: Theme.of(context).textTheme.bodySmall),
        backgroundColor: const Color(0xff0E1219),
        iconTheme: const IconThemeData(color: Color(0xffffffff)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Current Weather',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Location: ${Get.find<LocationController>().getCurrentCity()}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Weather: $_currentWeather',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Temperature: $_currentTemp°C',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 32.0),
              const Text(
                'Forecast',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: _forecast.length,
                  itemBuilder: (context, index) {
                    final dayForecast = _forecast[index];
                    final dateTime = DateTime.parse(dayForecast['date']);
                    final formattedDate = '${dateTime.month}/${dateTime.day}';
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formattedDate,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            dayForecast['day']['condition']['text'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            '${dayForecast['day']['mintemp_c']}°C - ${dayForecast['day']['maxtemp_c']}°C',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
