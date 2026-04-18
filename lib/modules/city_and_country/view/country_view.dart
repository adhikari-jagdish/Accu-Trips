import 'package:accu_trips/common/widgets/crud_table.dart';
import 'package:accu_trips/common/widgets/crud_table_row.dart';
import 'package:accu_trips/common/widgets/custom_alert_dialog.dart';
import 'package:accu_trips/data/models/country_model.dart';
import 'package:accu_trips/modules/city_and_country/controller/country_controller.dart';
import 'package:accu_trips/modules/city_and_country/view/add_edit_country.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryView extends StatelessWidget {
  const CountryView({super.key});

  @override
  Widget build(BuildContext context) {
    final countryController = Get.put(CountryController());
    return Obx(
      () => CrudTable<CountryModel>(
        title: 'Countries',
        columns: const [('SN', 1), ('NAME', 3), ('CODE', 2), ('ACTIONS', 2)],
        items: countryController.filteredCountries,
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
        isLoading: countryController.isLoading.value,
        onSearch: (q) => countryController.searchQuery.value = q,
        onAdd: () => showDialog(context: context, builder: (dialogContext) => const AddEditCountry()),
        addLabel: 'Add Country',
        currentPage: countryController.currentPage.value,
        totalPages: countryController.totalPages.value,
        totalCount: countryController.totalCount.value,
        //onPageChanged: countryController.goToPage,
        onRefresh: countryController.refresh,
      ),
    );
  }
}
