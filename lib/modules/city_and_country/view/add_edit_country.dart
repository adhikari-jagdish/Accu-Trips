import 'package:accu_trips/common/widgets/crud_action_buttons.dart';
import 'package:accu_trips/common/widgets/custom_dialog.dart';
import 'package:accu_trips/common/widgets/custom_text_field.dart';
import 'package:accu_trips/common/widgets/dialog_action_buttons.dart';
import 'package:accu_trips/core/text_utils/app_text_extension.dart';
import 'package:accu_trips/core/theme/app_colors.dart';
import 'package:accu_trips/modules/city_and_country/controller/country_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditCountry extends StatelessWidget {
  const AddEditCountry({super.key});

  @override
  Widget build(BuildContext context) {
    final countryController = Get.find<CountryController>();
    return CustomDialog(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(color: AppColors.colorPrimary, borderRadius: BorderRadius.circular(10)),
              child: Text('New Country', style: context.typographyBold18().copyWith(color: Colors.white)),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    title: 'Country Code',
                    hintText: 'Enter Country Code',
                    controller: countryController.countryCodeController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter country code";
                      }
                      if (value.trim().length < 2) {
                        return "Country code is too short";
                      }
                      return null;
                    },
                  ),
                ),

                Expanded(
                  child: CustomTextField(
                    title: 'Country Name',
                    hintText: 'Enter Country Name',
                    controller: countryController.countryNameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter country name";
                      }
                      if (value.trim().length < 4) {
                        return "Country name is too short";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DialogActionButtons(),
          ],
        ),
      ),
    );
  }
}
