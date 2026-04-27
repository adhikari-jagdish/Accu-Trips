import 'package:accu_trips/common/widgets/crud_table.dart';
import 'package:accu_trips/common/widgets/crud_table_row.dart';
import 'package:accu_trips/common/widgets/custom_alert_dialog.dart';
import 'package:accu_trips/data/models/city_model.dart';
import 'package:accu_trips/modules/city_and_country/controller/city_controller.dart';
import 'package:accu_trips/modules/city_and_country/view/add_edit_city.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CityView extends StatelessWidget {
  const CityView({super.key});

  @override
  Widget build(BuildContext context) {
    final cityController = Get.put(CityController());
    return Obx(
      () => CrudTable<CityModel>(
        title: 'Cities',
        columns: const [('SN', 1), ('NAME', 3), ('CODE', 2), ('ACTIONS', 2)],
        items: cityController.filteredCities,
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
        isLoading: cityController.isLoading.value,
        onSearch: (q) => cityController.searchQuery.value = q,
        onAdd: () => showDialog(context: context, builder: (dialogContext) => const AddEditCity()),
        addLabel: 'Add City',
        currentPage: cityController.currentPage.value,
        totalPages: cityController.totalPages.value,
        totalCount: cityController.totalCount.value,
        //onPageChanged: countryController.goToPage,
        onRefresh: cityController.refresh,
      ),
    );
  }
}
