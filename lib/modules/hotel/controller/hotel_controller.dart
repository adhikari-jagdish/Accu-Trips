import 'package:accu_trips/data/models/hotel_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HotelController extends GetxController {
  final hotelList = <HotelModel>[].obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final totalCount = 0.obs;
  final int rowsPerPage = 15;
  var selectedHotelCategory = '5 Star'.obs;

  final hotelNameController = TextEditingController();

  List<HotelModel> get filteredHotels {
    final q = searchQuery.value.toLowerCase();
    if (q.isEmpty) return hotelList;
    return hotelList.where((a) => a.name.toLowerCase().contains(q) || a.name.toLowerCase().contains(q)).toList();
  }
}
