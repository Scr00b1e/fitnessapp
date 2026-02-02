class WeatherNow {
  final double temperatureC;
  final int weatherCode;

  const WeatherNow({
    required this.temperatureC,
    required this.weatherCode,
  });

  factory WeatherNow.fromOpenMeteo(Map<String, dynamic> json) {
    final current = json['current'] as Map<String, dynamic>;
    return WeatherNow(
      temperatureC: (current['temperature_2m'] as num).toDouble(),
      weatherCode: (current['weather_code'] as num).toInt(),
    );
  }
}
