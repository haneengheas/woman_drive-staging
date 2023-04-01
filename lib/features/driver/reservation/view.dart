// ignore_for_file: unused_element

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:woman_drive/features/driver/reservation_payment/view.dart';
import 'package:woman_drive/shared/components/constants.dart';
import 'package:woman_drive/shared/components/navigator.dart';

import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/styles.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  List<String> days = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
  ];
  List<String> hoursNum = [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];
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

  String? daysSelected;
  String? hoursSelected;
  String? numHoursSelected;

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

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }
    return valueText;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'حجز موعد ',
          ),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              // كم عدد الساعات
              // Box(
              //   height: 40,
              //   style: AppTextStyles.name,
              //   text: 'كم عدد الأيام على مدار الاسبوع؟  ',
              //   color: AppColors.pink,
              //   dirction: Alignment.center,
              // ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              //   child: Directionality(
              //     textDirection: TextDirection.rtl,
              //     child: DropdownButtonHideUnderline(
              //       child: DropdownButton2(
              //         isExpanded: true,
              //         hint: const Text('عدد الأيام على مدار الأسبوع'),
              //         items: days
              //             .map((days) => DropdownMenuItem<String>(
              //                   value: days,
              //                   child: Container(
              //                     alignment: Alignment.centerRight,
              //                     child: Text(
              //                       days,
              //                       style: AppTextStyles.name,
              //                     ),
              //                   ),
              //                 ))
              //             .toList(),
              //         value: daysSelected,
              //         onChanged: (value) {
              //           setState(() {
              //             daysSelected = value as String;
              //           });
              //         },
              //         buttonStyleData: ButtonStyleData(
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 10, vertical: 5),
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(14),
              //             border: Border.all(
              //               color: AppColors.black,
              //             ),
              //             color: AppColors.white,
              //           ),
              //         ),
              //         dropdownStyleData: const DropdownStyleData(
              //             maxHeight: 200,
              //             padding: EdgeInsets.symmetric(horizontal: 10),
              //             scrollbarTheme: ScrollbarThemeData(
              //               radius: Radius.circular(40),
              //             )),
              //       ),
              //     ),
              //   ),
              // ),
              // عدد الساعات
              // const SizedBox(
              //   height: 10,
              // ),
              // ما اليوم و الساعة
              Box(
                height: 40,
                style: AppTextStyles.name,
                text: 'اختر الايام التى تحتاجها على مدار الاسبوع؟  ',
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
              // ToDo :
              // Wrap(
              //   children: [
              //     const Text('Selection(s):  '),
              //     const SizedBox(width: 10),
              //     Text(
              //       _getValueText(
              //         CalendarDatePicker2Type.multi,
              //         _multiDatePickerValueWithDefaultValue,
              //       ),
              //       overflow: TextOverflow.ellipsis,
              //       maxLines: 1,
              //       softWrap: false,
              //     ),
              //   ],
              // ),

              // الساعة
              Box(
                height: 40,
                style: AppTextStyles.sName,
                text: 'كم عدد الساعات التى تحتاجها في كل يوم تدريب  ؟  ',
                color: AppColors.pink,
                dirction: Alignment.center,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: const Text('عدد الساعات '),
                      items: hoursNum
                          .map((hoursNum) => DropdownMenuItem<String>(
                                value: hoursNum,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    hoursNum,
                                    style: AppTextStyles.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: numHoursSelected,
                      onChanged: (value) {
                        setState(() {
                          numHoursSelected = value as String;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColors.black,
                          ),
                          color: AppColors.white,
                        ),
                      ),
                      dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: Radius.circular(40),
                          )),
                    ),
                  ),
                ),
              ),
              Box(
                height: 40,
                style: AppTextStyles.name,
                text: 'اختر وقت التدريب ',
                color: AppColors.pink,
                dirction: Alignment.center,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: const Text('اختر الساعة المتاحة'),
                      items: hours
                          .map((hours) => DropdownMenuItem<String>(
                                value: hours,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    hours,
                                    style: AppTextStyles.name,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: hoursSelected,
                      onChanged: (value) {
                        setState(() {
                          hoursSelected = value as String;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColors.black,
                          ),
                          color: AppColors.white,
                        ),
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        maxHeight: 300,
                        padding: EdgeInsets.symmetric(horizontal: 10 ,vertical: 10),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: Radius.circular(40),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              CustomButtonTemplate(
                color: AppColors.yellow,
                height: 35,
                width: width(context, 3),
                onPressed: () =>
                    navigateTo(context, const ReservationPaymentScreen()),
                text: 'التالي',
                textStyle: AppTextStyles.brButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
