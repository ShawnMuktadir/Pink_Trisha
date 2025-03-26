import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/controller/add_address/add_address_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/model/district_list.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class CityDropdown extends StatelessWidget {
  const CityDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final state = ref.watch(addAddressController);
        final controller = ref.read(addAddressController.notifier);

        return Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    GlobalText(
                      str: "City",
                      color: KColor.deep2.color,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    GlobalText(
                      str: "*",
                      color: KColor.deepPrimary.color,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                )),
            const SizedBox(
              height: 4,
            ),
            Center(
              child: DropdownButtonFormField<DistrictModel>(
                padding: EdgeInsets.zero,
                value: state.selectedCity,
                hint: GlobalText(
                  str: "Select",
                  color: KColor.grey.color.withOpacity(.8),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                // validator: (value) {
                //   return null;
                // },
                items: districts.map((type) {
                  return DropdownMenuItem<DistrictModel>(
                    value: type,
                    child: GlobalText(
                      str: type.value,
                      color: const Color(0xFF666465),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  newValue != null ? controller.onCityChanged(newValue) : null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: KColor.white.color,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: KColor.primary.color),
                      borderRadius: BorderRadius.circular(8)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: KColor.border2.color),
                      borderRadius: BorderRadius.circular(8)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: KColor.border2.color,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 0, horizontal: 10), // Adjust as needed
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// class GlobalPrimaryDropdown extends StatelessWidget {
//   final String title;
//   final String? hint;
//   final bool isRequired;
//   const GlobalPrimaryDropdown(
//       {super.key, required this.title, this.hint, this.isRequired = true});
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Align(
//             alignment: Alignment.centerLeft,
//             child: Row(
//               children: [
//                 GlobalText(
//                   str: title,
//                   color: KColor.deep2.color,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 isRequired
//                     ? GlobalText(
//                         str: "*",
//                         color: KColor.deepPrimary.color,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       )
//                     : const SizedBox.shrink(),
//               ],
//             )),
//         const SizedBox(
//           height: 4,
//         ),
//         GlobalDropdown(
//             validator: (validator) {},
//             hintText: hint ?? "Select",
//             onChanged: (value) {},
//             items: dropdownItems),
//       ],
//     );
//   }
// }

// List<DropdownMenuItem<String>>? dropdownItems = [
//   const DropdownMenuItem(
//     child: Text("Value 1"),
//     value: "Value 1",
//   ),
//   const DropdownMenuItem(
//     child: Text("Value 2"),
//     value: "Value 2",
//   ),
//   const DropdownMenuItem(
//     child: Text("Value 3"),
//     value: "Value 3",
//   ),
//   const DropdownMenuItem(
//     child: Text("Value 4"),
//     value: "Value 4",
//   ),
// ];
