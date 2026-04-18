import 'package:accu_trips/data/models/country_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryController extends GetxController {
  final countryCodeController = TextEditingController();
  final countryNameController = TextEditingController();

  final countryList = <CountryModel>[].obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final totalCount = 0.obs;
  final int rowsPerPage = 15;

  List<CountryModel> get filteredCountries {
    final q = searchQuery.value.toLowerCase();
    if (q.isEmpty) return countryList;
    return countryList.where((a) => a.name.toLowerCase().contains(q) || a.name.toLowerCase().contains(q)).toList();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
