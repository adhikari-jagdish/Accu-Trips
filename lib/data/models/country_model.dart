import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@JsonSerializable()
class CountryModel {
  final int? id;
  final String name;
  final String code;

  CountryModel({
    this.id,
    required this.name,
    required this.code,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}