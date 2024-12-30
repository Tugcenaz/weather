class WeatherModel {
  final String icon;
  final String day;
  final String description;
  final String degree;
  final String min;
  final String max;
  final String night;
  final String humidity;

  WeatherModel(this.icon, this.day, this.description, this.degree, this.min,
      this.max, this.night, this.humidity);

  WeatherModel.fromJson(Map<String, dynamic> json)
      : icon = json["icon"],
        day = json["day"],
        description = json["description"],
        degree = json["degree"],
        min = json["min"],
        max = json["max"],
        night = json["night"],
        humidity = json["humidity"];
}
