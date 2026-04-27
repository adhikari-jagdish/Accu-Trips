import 'package:accu_trips/common/widgets/custom_dialog.dart';
import 'package:accu_trips/common/widgets/custom_drop_down.dart';
import 'package:accu_trips/common/widgets/custom_text_field.dart';
import 'package:accu_trips/core/text_utils/app_text_extension.dart';
import 'package:accu_trips/core/theme/app_colors.dart';
import 'package:accu_trips/modules/hotel/controller/hotel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditHotel extends StatelessWidget {
  const AddEditHotel({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelController = Get.find<HotelController>();
    return CustomDialog(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(color: AppColors.colorPrimary, borderRadius: BorderRadius.circular(10)),
              child: Text('New Hotel', style: context.typographyBold18().copyWith(color: Colors.white)),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomDropDown(
                    title: 'Hotel Code',
                    value: '5 Star',
                    items: ['5 Star', '4 Star', '3 Star', '2 Star', 'Budget'],
                    labelBuilder: (value) => value,
                    onChanged: (value) => hotelController.selectedHotelCategory.value = value!,
                  ),
                ),

                Expanded(
                  child: CustomTextField(
                    title: 'Hotel Name',
                    hintText: 'Enter Hotel Name',
                    controller: hotelController.hotelNameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter hotel name";
                      }
                      if (value.trim().length < 4) {
                        return "Hotel name is too short";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
