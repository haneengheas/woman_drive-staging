import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:woman_drive/features/trainer/trainer_profile/widget/edit_profile.dart';
import 'package:woman_drive/shared/styles/colors.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/images.dart';
import '../../../shared/styles/styles.dart';

class TrainerInfoScreen extends StatefulWidget {
  const TrainerInfoScreen({Key? key}) : super(key: key);

  @override
  State<TrainerInfoScreen> createState() => _TrainerInfoScreenState();
}

class _TrainerInfoScreenState extends State<TrainerInfoScreen> {
  List<String> hours = [
    '9:00 Am',
    '10:00 Am',
    '11:00 Am',
    '12:00 Pm',
    '1:00 Pm',
    '2:00 Pm',
    '3:00 Pm',
    '4:00 Pm',
    '5:00 Pm',
    '6:00 Pm',
    '7:00 Pm',
    '8:00 Pm',
    '9:00 Pm',
    '10:00 Pm',
  ];
  List<String> selectedHours = [];
  bool _predicate(DateTime day) {
    if ((day.isAfter(DateTime(2023, 3, 1)) &&
        day.isBefore(DateTime(2023, 4, 15)))) {
      return true;
    }

    if ((day.isAfter(DateTime(2023, 2, 10)) &&
        day.isBefore(DateTime(2023, 3, 15)))) {
      return true;
    }
    // if ((day.isAfter(DateTime(2023, 4, 5)) &&
    //     day.isBefore(DateTime(2023, 4, 17)))) {
    //   return true;
    // }

    return false;
  }

  List<DateTime?> _multiDatePickerValueWithDefaultValue = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'حسابي',
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
            )),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // صورة الروفايل + الاسم
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        ' ريناد محمد ',
                        style: AppTextStyles.name,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'مدربة قيادة',
                        style: AppTextStyles.name,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Stack(alignment: Alignment.bottomLeft, children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage(female),
                      radius: 40,
                    ),
                    CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColors.pink,
                        child: Center(
                          child: IconButton(
                            color: Colors.yellow,
                            onPressed: () {
                              editTrainerProfile(context);
                            },
                            icon: const Icon(Icons.edit,
                                color: AppColors.black, size: 15),
                          ),
                        )),
                  ]),
                ],
              ),
            ),
            Box(
              height: 40,
              style: AppTextStyles.name,
              text: 'مواصفات السيارة ',
              color: AppColors.pink,
              dirction: Alignment.center,
            ),
            TextFieldTemplate(
              hintText: 'نوع السيارة ',
              icon: Icons.car_rental,
            ),
            TextFieldTemplate(
              hintText: 'رقم اللوحة ',
              icon: Icons.credit_card_outlined,
            ),
            Box(
              height: 40,
              style: AppTextStyles.name,
              text: ' شروط التدريب',
              color: AppColors.pink,
              dirction: Alignment.center,
            ),
            TextFieldTemplate(
              hintText: 'العمر ',
              icon: Icons.today,
            ),
            TextFieldTemplate(
              hintText: 'السعر ',
              icon: Icons.monetization_on,
            ),
            Box(
              height: 40,
              style: AppTextStyles.name,
              text: 'الأيام المتاحة',
              color: AppColors.pink,
              dirction: Alignment.center,
            ),
            // التقويم
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                    calendarType: CalendarDatePicker2Type.multi,
                    selectedDayHighlightColor: AppColors.yellow,
                    selectableDayPredicate: _predicate),
                value: _multiDatePickerValueWithDefaultValue,
                onValueChanged: (dates) => setState(
                        () => _multiDatePickerValueWithDefaultValue = dates),
              ),
            ),




            // الساعة
            // SizedBox(
            //   // height: 130,
            //   width: width(context, 1.2),
            //   child: GridView.builder(
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 3,
            //         childAspectRatio: 3,
            //         crossAxisSpacing: 10,
            //         mainAxisSpacing: 10),
            //     itemCount: clock.length,
            //     scrollDirection: Axis.vertical,
            //     physics: const NeverScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     itemBuilder: (context, index) {
            //       return InkWell(
            //         onTap: () {
            //           for (int i = 0; i < clock.length; i++) {
            //             if (clock[i]['isSelected'] == true) {
            //               setState(() {
            //                 clock[i]['isSelected'] = false;
            //               });
            //             }
            //             setState(() {
            //               clock[index]['isSelected'] = true;
            //             });
            //           }
            //         },
            //         child: Container(
            //           //height: 20,
            //           //width: width(context, 3.5),
            //           alignment: Alignment.center,
            //           // margin: const EdgeInsets.symmetric(
            //           //     horizontal: 10, vertical: 10),
            //           decoration: BoxDecoration(
            //               color: clock[index]['isSelected']
            //                   ? AppColors.pink
            //                   : Colors.white,
            //               border: Border.all(color: AppColors.black),
            //               borderRadius: BorderRadius.circular(20)),
            //           child: Text(clock[index]['clock'],
            //               style: AppTextStyles.smTitles),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Box(
              height: 40,
              style: AppTextStyles.name,
              text: 'الساعات المتاحة',
              color: AppColors.pink,
              dirction: Alignment.center,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: DropDownMultiSelect(
                options: hours,
                selectedValues: selectedHours,
                hint: const Text('اختر الساعات المتاحة بالنسبة لك'),
                decoration: const InputDecoration(
                    enabled: true,
                    fillColor: AppColors.pink,
                    filled: true,
                    hintTextDirection: TextDirection.ltr,

                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.pink, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.pink, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.pink, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ))),
                onChanged: (value) {
                  if (kDebugMode) {
                    print('selected hour $value');
                  }
                  setState(() {
                    selectedHours = value;
                  });
                  if (kDebugMode) {
                    print('you have selected $selectedHours this hour.');
                  }
                },
                whenEmpty: '',
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButtonTemplate(
                  width: width(context, 3),
                  color: AppColors.pink,
                  height: 40,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'إلغاء',
                  textStyle: AppTextStyles.brButton,
                ),
                CustomButtonTemplate(
                  width: width(context, 3),
                  color: AppColors.yellow,
                  height: 40,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'تأكيد',
                  textStyle: AppTextStyles.brButton,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> clock = [
  {
    'clock': '9:00 Am',
    'isSelected': false,
  },
  {
    'clock': '12:00 Pm',
    'isSelected': false,
  },
  {
    'clock': '3:00 Pm',
    'isSelected': false,
  },
  {
    'clock': '6:00 Pm ',
    'isSelected': false,
  },
  {
    'clock': '8:00 Pm',
    'isSelected': false,
  },
  {
    'clock': '8:30 Pm',
    'isSelected': false,
  },
];
