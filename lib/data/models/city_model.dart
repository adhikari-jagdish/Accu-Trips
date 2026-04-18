import 'package:json_annotation/json_annotation.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityModel {
  final int? id;
  final String name;

  @JsonKey(name: 'country_id')
  final int countryId;

  CityModel({this.id, required this.name, required this.countryId});

  factory CityModel.fromJson(Map<String, dynamic> json) => _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}
