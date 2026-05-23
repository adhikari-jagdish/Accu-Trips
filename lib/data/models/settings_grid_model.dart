import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings_grid_model.g.dart';

@JsonSerializable()
class SettingsGridModel {
  final String title;
  final String icon;

  SettingsGridModel({required this.title, required this.icon});

  factory SettingsGridModel.fromJson(Map<String, dynamic> json) => _$SettingsGridModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsGridModelToJson(this);
}
