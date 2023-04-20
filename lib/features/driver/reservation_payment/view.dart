import 'package:flutter/material.dart';
import 'package:woman_drive/models/driver_reservation_model.dart';
import 'package:woman_drive/shared/components/components.dart';
import 'package:woman_drive/shared/components/navigator.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/images.dart';
import '../../../shared/styles/styles.dart';
import '../reservation_list/view.dart';

class ReservationPaymentScreen extends StatefulWidget {
  DriverReservationModel? model;

  ReservationPaymentScreen({required this.model, Key? key}) : super(key: key);

  @override
  State<ReservationPaymentScreen> createState() =>
      _ReservationPaymentScreenState();
}

class _ReservationPaymentScreenState extends State<ReservationPaymentScreen> {
  bool fill = false;
  bool checked = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'تأكيد حجز الموعد ',
          ),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // صورة البروفايل + الاسم
                ProfileImage(
                  onTap: () {},
                  image: female,
                  role: 'مدربة قيادة',
                  name: '${widget.model!.trainerName}',
                ),
                const SizedBox(
                  height: 20,
                ),

                Text(
                  'تفاصيل الحجز ',
                  style: AppTextStyles.smTitles,
                ),
                const SizedBox(
                  height: 15,
                ),
                // المدة
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    const Image(
                      image: AssetImage(clock),
                      height: 20,
                      width: 25,
                    ),
                    Header(
                      text: 'المدة : ' '${widget.model!.numHours}' ' ساعة ',
                      style: AppTextStyles.w400.apply(
                        color: AppColors.greyDark,
                      ),
                    ),
                    Text(
                      '${widget.model!.hours}'
                      ' : الساعة  ',
                      style: AppTextStyles.w400.copyWith(
                        color: AppColors.greyDark,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // الوقت و التاريخ
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    const Image(
                      image: AssetImage(timeTable),
                      height: 20,
                      width: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: width(context, 1.3),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          'التاريخ : '
                          '${widget.model!.dayDate}',
                          style: AppTextStyles.w400.copyWith(
                            color: AppColors.greyDark,
                            //fontSize: 14
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  color: AppColors.black,
                ),
                const SizedBox(
                  height: 15,
                ),
                // تفاصيل الفاتورة
                Text(
                  'تفاصيل الفاتورة ',
                  style: AppTextStyles.smTitles,
                ),
                const SizedBox(
                  height: 15,
                ),
                // التكلفة
                Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'التكلفة ',
                      style: AppTextStyles.smTitles,
                    ),
                    Text(
                      '${(widget.model!.total! - 15)}' ' SR ',
                      style: AppTextStyles.smTitles,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // القيمة المضافة
                Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'القيمة المضافة ',
                      style: AppTextStyles.smTitles,
                    ),
                    Text(
                      'SR 15  ',
                      style: AppTextStyles.smTitles,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // الاجمالي
                Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الاجمالي ',
                      style: AppTextStyles.smTitles,
                    ),
                    Text(
                      '${(widget.model!.total!)} SR',
                      style: AppTextStyles.smTitles,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  color: AppColors.black,
                  height: 5,
                ),

                const SizedBox(
                  height: 35,
                ),

                widget.model!.accepted == 'قيد المراجعة' ||  widget.model!.accepted == 'منتهي'?
                Center(
                  child: fill == false
                      ? ButtonTemplate(
                          color: AppColors.yellow,
                          text1: 'اتمام عملية الدفع ',
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: AppColors.pinkPowder,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter mystate) {
                                    return Form(
                                      key: formKey,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 20),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Center(
                                                  child: Text(
                                                'اتمام عملية الدفع ',
                                                style: AppTextStyles.boldtitles,
                                              )),
                                              // رقم البطاقة الائتمانية
                                              TextFieldTemplate(
                                                hintText:
                                                    'رقم البطاقة الائتمانية',
                                                icon: Icons.credit_card_outlined,
                                                  validator: (String? value) {
                                                    if (value!.isEmpty) {
                                                      return 'برجاء ادخال رقم البطاقة الائتمانية ';
                                                    }
                                                  }
                                              ),
                                              // الباسورد + تاريخ الانتهاء
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: width(context, 2.2),
                                                    height: 100,
                                                    //margin: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: TextFieldTemplate(
                                                      hintText: 'تاريخ الانتهاء',
                                                      icon: Icons.date_range,
                                                        validator: (String? value) {
                                                          if (value!.isEmpty) {
                                                            return 'برجاء ادخال تاريخ الانتهاء';
                                                          }
                                                        }
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width(context, 2.2),
                                                    height: 100,
                                                    //margin: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: TextFieldTemplate(
                                                      hintText: 'الرقم السري',
                                                      icon: Icons.lock,
                                                        validator: (String? value) {
                                                          if (value!.isEmpty) {
                                                            return 'برجاء ادخال الرقم السري ';
                                                          }
                                                        }
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TextFieldTemplate(
                                                hintText: 'الاسم علي البطاقة',
                                                icon: Icons.person,
                                                  validator: (String? value) {
                                                    if (value!.isEmpty) {
                                                      return 'برجاء ادخال الاسم علي البطاقة ';
                                                    }
                                                  }
                                              ),
                                              Row(
                                                textDirection: TextDirection.rtl,
                                                children: [
                                                  Checkbox(
                                                      activeColor:
                                                          AppColors.yellow,
                                                      value: checked,
                                                      onChanged: (value) {
                                                        mystate(() {
                                                          checked = value!;
                                                        });
                                                      }),
                                                  Text(
                                                    'حفظ المعلومات',
                                                    style: AppTextStyles.sName,
                                                  ),
                                                ],
                                              ),

                                              CustomButtonTemplate(
                                                height: 40,
                                                width: width(context, 3),
                                                color: AppColors.yellow,
                                                text: 'اتمام العملية',
                                                onPressed: () => {
                                                  if(formKey.currentState!.validate()){
                                                    setState(() {
                                                      fill = true;
                                                    }),
                                                    Navigator.pop(context)

                                                  },

                                                },
                                                textStyle: AppTextStyles.brButton,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                });
                          })
                      : ButtonTemplate(
                          color: AppColors.yellow,
                          text1: 'عرض الحجز',
                          onPressed: () => navigateTo(
                              context, const ReservationListScreen())),
                ) : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
