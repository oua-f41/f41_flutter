import 'package:connectopia/product/models/core_models/country.dart';
import 'package:json_annotation/json_annotation.dart';
part 'city.g.dart';

@JsonSerializable()
class City {
  String? id;
  String? name;
  String? countryId;
  Country? country;

  City({this.id, this.name, this.countryId, this.country});

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}
