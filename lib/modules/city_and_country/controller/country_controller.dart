import 'package:accu_trips/common/widgets/app_toast.dart';
import 'package:accu_trips/data/models/country_model.dart';
import 'package:accu_trips/data/service/api_error_handler.dart';
import 'package:accu_trips/data/service/api_utils.dart';
import 'package:accu_trips/data/service/country_service.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryController extends GetxController {
  final formKey = GlobalKey<FormState>();
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
    fetchCountries();
  }

  Future<void> fetchCountries() async {
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

  Future<ApiErrorResult?> createCountry(BuildContext context) async {
    isLoading.value = true;
    try {
      if (countryCodeController.text.isEmpty || countryNameController.text.isEmpty) {
        final error = ApiErrorResult(message: 'Country name and code are required');
        AppToast.error(error.message);
        return error;
      }
      final countryModel = CountryModel(name: countryNameController.text, code: countryCodeController.text);
      final response = await _countryService.createCountry(countryModel.toJson());
      final result = ApiUtils.parseResponse(response);
      if (result.success) {
        AppToast.success(result.message.isNotEmpty ? result.message : 'Country Created successfully');
        await fetchCountries();
        return null;
      } else {
        AppToast.error(result.message);
        return ApiErrorResult(message: result.message);
      }
    } on dio.DioException catch (e) {
      final apiError = parseApiError(e);
      AppToast.error(apiError?.message ?? 'Network error');
      return apiError;
    } catch (e) {
      AppToast.error('Oops! Something went wrong!');
      return const ApiErrorResult(message: 'Oops! Something went wrong!');
    } finally {
      isLoading.value = false;
    }
  }

  Future<ApiErrorResult?> updateCountry(String id, Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final response = await _countryService.updateCountry(id, data);
      final result = ApiUtils.parseResponse(response);
      if (result.success) {
        AppToast.success(result.message.isNotEmpty ? result.message : 'Updated successfully');
        await fetchCountries();
        return null;
      } else {
        AppToast.error(result.message);
        return ApiErrorResult(message: result.message);
      }
    } on dio.DioException catch (e) {
      final apiError = parseApiError(e);
      AppToast.error(apiError?.message ?? 'Network error');
      return apiError;
    } catch (e) {
      AppToast.error('Operation failed');
      return const ApiErrorResult(message: 'Operation failed');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteCountry(String id) async {
    isLoading.value = true;
    try {
      final response = await _countryService.deleteCountry(id);
      final result = ApiUtils.parseResponse(response);
      if (result.success) {
        AppToast.success(result.message.isNotEmpty ? result.message : 'Deleted successfully');
        await fetchCountries();
        return true;
      } else {
        AppToast.error(result.message);
        return false;
      }
    } on dio.DioException catch (e) {
      final msg = e.response != null ? ApiUtils.parseResponse(e.response!).message : (e.message ?? 'Network error');
      AppToast.error(msg);
      return false;
    } catch (e) {
      AppToast.error('Operation failed');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void goToPage(int page) {
    currentPage.value = page;
    fetchCountries();
  }

  @override
  void refresh() => fetchCountries();
}
