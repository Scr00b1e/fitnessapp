import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_now.dart';

class WeatherService {
  // Bishkek (WGS84)
  static const double _lat = 42.882004;
  static const double _lon = 74.582748;

  Future<WeatherNow> fetchBishkekNow() async {
    final uri = Uri.parse(
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=$_lat'
      '&longitude=$_lon'
      '&current=temperature_2m,weather_code'
      '&timezone=auto',
    );

    final res = await http.get(uri);
    if (res.statusCode != 200) {
      throw Exception('Weather request failed: ${res.statusCode}');
    }

    final jsonMap = json.decode(res.body) as Map<String, dynamic>;
    return WeatherNow.fromOpenMeteo(jsonMap);
  }

  

}
