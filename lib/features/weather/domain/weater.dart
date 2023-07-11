class Weather {
  Location? location;
  Current? current;

  Weather({this.location, this.current});

  Weather.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    current =
        json['current'] != null ? Current.fromJson(json['current']) : null;
  }
}

class Location {
  String? region;

  Location({
    this.region,
  });

  Location.fromJson(Map<String, dynamic> json) {
    region = json['region'];
  }
}

class Current {
  double? tempC;
  Condition? condition;

  Current({
    this.tempC,
    this.condition,
  });

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];

    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
  }
}

class Condition {
  String? icon;

  Condition({this.icon});

  Condition.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
  }
}
