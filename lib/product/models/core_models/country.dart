import 'package:json_annotation/json_annotation.dart';
part 'country.g.dart';

@JsonSerializable()
class Country {
  String? id;
  String? name;

  Country({this.id, this.name});

  Country copyWith({
    String? id,
    String? name,
  }) {
    return Country(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
