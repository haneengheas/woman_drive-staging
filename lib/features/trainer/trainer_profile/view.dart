import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woman_drive/features/trainer/home/view.dart';
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
  List<String> selectedHours = [];
  TextEditingController ageDriverController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController carController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  late List<DateTime?> datesList = [];
  late List<String>? hoursList;
  final formKey = GlobalKey<FormState>();

  getDateFormat() {
    datesList.clear();
    for (var element in widget.model.days!) {
      DateTime formattedData = element.toDate();
      datesList.add(formattedData);
      if (kDebugMode) {
        print(datesList);
      }
    }
    return datesList;
  }

  @override
  void initState() {
    // TODO: implement initState
    ageDriverController = TextEditingController(text: widget.model.ageDriver);
    priceController = TextEditingController(text: widget.model.price.toString());
    carController = TextEditingController(text: widget.model.carType);
    licenseController = TextEditingController(text: widget.model.licenseNumber);
    hoursList = List<String>.from(widget.model.hours as List);
    datesList = getDateFormat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var model = TrainerCubit.get(context).model;

    return BlocConsumer<TrainerCubit, TrainerState>(listener: (context, state) {
      if (state is TrainerSetDataSuccessState) {
        showToast(
            text: ' تمت اضافة البيانات بنجاح', state: ToastStates.success);
        Navigator.pop(context);
      }
      if (state is TrainerUpdateProfileSuccessState) {
        if (kDebugMode) {
          showToast(
              text: ' تمت تعديل الحساب بنجاح', state: ToastStates.success);
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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // صورة الروفايل + الاسم
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        // textDirection: TextDirection.rtl,
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
                      Stack(alignment: Alignment.bottomLeft, children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage(female),
                          radius: 40,
                        ),
                        InkWell(
                          onTap: () {
                            editTrainerProfile(context: context, model: model);
                          },
                          child: const CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.pink,
                              child: Icon(
                                Icons.edit,
                                color: AppColors.black,
                                size: 20,
                              )),
                        ),
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
                  controller: carController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'برجاء ادخال نوع السيارة';
                    }
                  },
                ),
                TextFieldTemplate(
                  hintText: 'رقم اللوحة ',
                  icon: Icons.credit_card_outlined,
                  controller: licenseController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'برجاء ادخال رقم اللوحة';
                    }
                  },
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
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'برجاء ادخال العمر ';
                    }
                  },
                ),
                TextFieldTemplate(
                  hintText: 'السعر ',
                  icon: Icons.monetization_on,
                  controller: priceController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'برجاء ادخال السعر';
                    }
                  },
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
                    ),
                    value: datesList,
                    onValueChanged: (dates) => setState(() {
                      datesList = dates;
                      print(datesList);
                    }),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: DropDownMultiSelect(
                    options: hours,
                    selectedValues: hoursList!,
                    decoration: const InputDecoration(
                        enabled: true,
                        fillColor: AppColors.pink,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.pink, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.pink, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.pink, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
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
                        navigateTo(context, const TrainerHomeScreen());
                      },
                      text: 'إالغاء',
                      textStyle: AppTextStyles.brButton,
                    ),
                    CustomButtonTemplate(
                      width: width(context, 3),
                      color: AppColors.yellow,
                      height: 40,
                      onPressed: () {
                        if (datesList.isEmpty) {
                          showToast(
                              text: 'يجب اختيار الأيام المتاحة',
                              state: ToastStates.error);
                        } else if (selectedHours.isEmpty) {
                          showToast(
                              text: 'يجب اختيار الساعات المتاحة',
                              state: ToastStates.error);
                        } else if (formKey.currentState!.validate()) {
                          TrainerCubit.get(context).addTrainerData(
                            ageDriver: ageDriverController.text,
                            price: int.parse(priceController.text),
                            hours: selectedHours,
                            carType: carController.text,
                            days: datesList,
                            licenceNumber: licenseController.text,
                          );
                          TrainerCubit.get(context).getTrainerData();
                        }
                      },
                      text: 'تأكيد',
                      textStyle: AppTextStyles.brButton,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
