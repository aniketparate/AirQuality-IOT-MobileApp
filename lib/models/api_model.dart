class WeatherData {
  double co;
  double temp;
  double humidity;
  double heatIndex;

  WeatherData(
      {required this.co,
      required this.temp,
      required this.humidity,
      required this.heatIndex});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      co: (json['co'] as num).toDouble() / 10,
      temp: (json['temp'] as num).roundToDouble(),
      humidity: (json['humidity'] as num).roundToDouble(),
      heatIndex: (json['heatindex'] as num).roundToDouble(),
    );
  }
}
