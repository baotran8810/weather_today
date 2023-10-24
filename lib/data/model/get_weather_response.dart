class GetWeatherResponse {
  final Location location;
  final Current current;

  GetWeatherResponse({required this.location, required this.current});

  GetWeatherResponse.fromJson(Map<String, dynamic> json)
      : location = Location.fromJson(json['location']),
        current = Current.fromJson(json['current']);
}

class Location {
  String name;
  String region;
  String country;
  double lat;
  double lon;
  String tzId;
  int localtimeEpoch;
  String localtime;

  Location(
      {required this.name,
      required this.region,
      required this.country,
      required this.lat,
      required this.lon,
      required this.tzId,
      required this.localtimeEpoch,
      required this.localtime});

  Location.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        region = json['region'],
        country = json['country'],
        lat = json['lat'],
        lon = json['lon'],
        tzId = json['tz_id'],
        localtimeEpoch = json['localtime_epoch'],
        localtime = json['localtime'];
}

class Current {
  int lastUpdatedEpoch;
  String lastUpdated;
  double tempC;
  double tempF;
  int isDay;
  Condition condition;
  double windMph;
  double windKph;
  int windDegree;
  String windDir;
  double pressureMb;
  double pressureIn;
  double precipMm;
  double precipIn;
  int humidity;
  int cloud;
  double feelslikeC;
  double feelslikeF;
  double visKm;
  double visMiles;
  double uv;
  double gustMph;
  double gustKph;

  Current(
      {required this.lastUpdatedEpoch,
      required this.lastUpdated,
      required this.tempC,
      required this.tempF,
      required this.isDay,
      required this.condition,
      required this.windMph,
      required this.windKph,
      required this.windDegree,
      required this.windDir,
      required this.pressureMb,
      required this.pressureIn,
      required this.precipMm,
      required this.precipIn,
      required this.humidity,
      required this.cloud,
      required this.feelslikeC,
      required this.feelslikeF,
      required this.visKm,
      required this.visMiles,
      required this.uv,
      required this.gustMph,
      required this.gustKph});

  Current.fromJson(Map<String, dynamic> json)
      : lastUpdatedEpoch = json['last_updated_epoch'],
        lastUpdated = json['last_updated'],
        tempC = json['temp_c'],
        tempF = json['temp_f'],
        isDay = json['is_day'],
        condition = Condition.fromJson(json['condition']),
        windMph = json['wind_mph'],
        windKph = json['wind_kph'],
        windDegree = json['wind_degree'],
        windDir = json['wind_dir'],
        pressureMb = json['pressure_mb'],
        pressureIn = json['pressure_in'],
        precipMm = json['precip_mm'],
        precipIn = json['precip_in'],
        humidity = json['humidity'],
        cloud = json['cloud'],
        feelslikeC = json['feelslike_c'],
        feelslikeF = json['feelslike_f'],
        visKm = json['vis_km'],
        visMiles = json['vis_miles'],
        uv = json['uv'],
        gustMph = json['gust_mph'],
        gustKph = json['gust_kph'];
}

class Condition {
  String text;
  String icon;
  int code;

  Condition({required this.text, required this.icon, required this.code});

  Condition.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        icon = json['icon'],
        code = json['code'];
}
