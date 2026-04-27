import 'package:accu_trips/common/widgets/app_toast.dart';
import 'package:accu_trips/data/models/country_model.dart';
import 'package:accu_trips/data/service/api_utils.dart';
import 'package:accu_trips/data/service/country_service.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryController extends GetxController {
  final countryCodeController = TextEditingController();
  final countryNameController = TextEditingController();
  final CountryService _countryService = CountryService();
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
    fetchItems();
  }

  Future<void> fetchItems() async {
    isLoading.value = true;
    try {
      final response = await _countryService.getCountries(page: currentPage.value, limit: rowsPerPage);
      final result = ApiUtils.getMessageAndMultiDataFromResponse(response);
      if (result.success) {
        countryList.assignAll(result.data.map((json) => CountryModel.fromJson(json)).toList());
      }
    } on dio.DioException catch (e) {
      final msg = e.response != null ? ApiUtils.parseResponse(e.response!).message : (e.message ?? 'Network error');
      AppToast.error(msg);
    } catch (e) {
      AppToast.error('Failed to load countries');
    } finally {
      isLoading.value = false;
    }
  }
}
