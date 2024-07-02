import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  static const GEU_URL = 'http://api.openweathermap.org/geo/1.0/direct';
  final String apikey;
  WeatherService(this.apikey);
  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apikey&units=metric'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } 
    throw Exception('Failed to load weather data');
  }
  Future<List<String>> getCitySuggestions(String query)  async {
    final response = await http.get(Uri.parse('$GEU_URL?q=$query&appid=$apikey'));
    if (response.statusCode == 200) {
      final data = await jsonDecode(response.body);
      return data.map<String>((json) => ['name'] as String).toList();
    }
    throw Exception('Failed to fetch city suggestions');
  }
}
