import 'package:accu_trips/data/models/city_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CityController extends GetxController {
  final cityList = <CityModel>[].obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final totalCount = 0.obs;
  final int rowsPerPage = 15;

  final cityCodeController = TextEditingController();
  final cityNameController = TextEditingController();

  List<CityModel> get filteredCities {
    final q = searchQuery.value.toLowerCase();
    if (q.isEmpty) return cityList;
    return cityList.where((a) => a.name.toLowerCase().contains(q) || a.name.toLowerCase().contains(q)).toList();
  }
}
