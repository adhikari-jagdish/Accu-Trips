import 'package:accu_trips/common/widgets/crud_table_row.dart';
import 'package:accu_trips/common/widgets/custom_alert_dialog.dart';
import 'package:accu_trips/data/models/hotel_model.dart';
import 'package:accu_trips/modules/hotel/controller/hotel_controller.dart';
import 'package:accu_trips/modules/hotel/view/add_edit_hotel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/crud_table.dart';

class HotelView extends StatelessWidget {
  const HotelView({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelController = Get.put(HotelController());
    return Obx(
      () => CrudTable<HotelModel>(
        title: 'Hotels',
        columns: const [('SN', 1), ('NAME', 3), ('CODE', 2), ('ACTIONS', 2)],
        items: hotelController.filteredHotels,
        rowBuilder: (item, index) => CrudTableRow(
          item: item,
          index: index,
          cells: (e, i) => [CrudRowCell(text: '${index + 1}', flex: 1), CrudRowCell(text: item.name, flex: 3)],
          onEdit: (e) {
            showDeleteAlertDialog(context);
          },
          onDelete: (e) async {
            showDeleteAlertDialog(context);
          },
        ),
        isLoading: hotelController.isLoading.value,
        onSearch: (q) => hotelController.searchQuery.value = q,
        onAdd: () => showDialog(context: context, builder: (dialogContext) => const AddEditHotel()),
        addLabel: 'Add Hotel',
        currentPage: hotelController.currentPage.value,
        totalPages: hotelController.totalPages.value,
        totalCount: hotelController.totalCount.value,
        //onPageChanged: countryController.goToPage,
        onRefresh: hotelController.refresh,
      ),
    );
  }
}
