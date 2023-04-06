import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiselect/multiselect.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woman_drive/features/trainer/trainer_profile/widget/edit_profile.dart';
import 'package:woman_drive/shared/styles/colors.dart';

import '../../../models/trainer_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/components/navigator.dart';
import '../../../shared/network/local/constant.dart';
import '../../../shared/styles/images.dart';
import '../../../shared/styles/styles.dart';
import '../../regitration/login/view.dart';
import '../cubit/trainer_cubit.dart';

class TrainerInfoScreen extends StatefulWidget {
  TrainerModel model;

  TrainerInfoScreen({required this.model, Key? key}) : super(key: key);

  @override
  State<TrainerInfoScreen> createState() => _TrainerInfoScreenState();
}

class _TrainerInfoScreenState extends State<TrainerInfoScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
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
  TextEditingController ageDriverController = TextEditingController();
  TextEditingController priceController = TextEditingController();
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
  void initState() {
    // TODO: implement initState
   ageDriverController = TextEditingController(text: widget.model.ageDriver);
   priceController = TextEditingController(text: widget.model.price.toString() );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var model = TrainerCubit.get(context).model;

    return BlocConsumer<TrainerCubit, TrainerState>(listener: (context, state) {
      if (state is TrainerSetDataSuccessState) {
        showToast(text: ' تمت اضافة البيانات بنجاح', state: ToastStates.success);
        Navigator.pop(context);
      }
      if (state is TrainerUpdateProfileSuccessState) {
        if (kDebugMode) {
          print('edit success');
        }
      }
    }, builder: (context, state) {
      var model = TrainerCubit.get(context).model;

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
                          ' ${model!.name}',
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
                    Stack(alignment: Alignment.bottomLeft, children: const [
                      CircleAvatar(
                        backgroundImage: AssetImage(female),
                        radius: 40,
                      ),
                      CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.pink,
                          child: Icon(
                            Icons.edit,
                            color: AppColors.black,
                            size: 20,
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
                hintText: 'نوع السيارة',
                icon: Icons.car_rental,
                controller: TextEditingController(text: model.carType),
                readOnly: true,
              ),
              TextFieldTemplate(
                hintText: 'رقم اللوحة ',
                icon: Icons.credit_card_outlined,
                controller: TextEditingController(text: model.licenseNumber),
                readOnly: true,
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
                controller: ageDriverController,
              ),
              TextFieldTemplate(
                hintText: 'السعر ',
                icon: Icons.monetization_on,
                controller: priceController,
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
              const SizedBox(
                height: 10,
              ),
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

                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'برجاء ادخال الساعات المتاحة بالنسبة لك';
                    }
                    return '';
                  },
                  decoration: const InputDecoration(
                      enabled: true,
                      fillColor: AppColors.pink,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.pink, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.pink, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.pink, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ))),
                  onChanged: (value) {
                    print('selected hour $value');
                    setState(() {
                      selectedHours = value;
                    });
                    print('you have selected $selectedHours this hour.');
                  },
                  hint: Text('اختر الساعات المتاحة بالنسبة لك '),
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
                      // editTrainerProfile(context, model);
                    },
                    text: 'تعديل',
                    textStyle: AppTextStyles.brButton,
                  ),
                  CustomButtonTemplate(
                    width: width(context, 3),
                    color: AppColors.yellow,
                    height: 40,
                    onPressed: () {
                      TrainerCubit.get(context).addTrainerData(
                        ageDriver: ageDriverController.text,
                        price: int.parse(priceController.text),
                        hours: selectedHours,
                      );
                      TrainerCubit.get(context).getTrainerData();
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
    });
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
