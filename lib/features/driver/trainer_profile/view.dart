import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woman_drive/shared/components/components.dart';
import 'package:woman_drive/shared/components/constants.dart';
import 'package:woman_drive/shared/components/navigator.dart';
import 'package:woman_drive/shared/styles/colors.dart';

import '../../../models/trainer_model.dart';
import '../../../models/trainer_reservation_model.dart';
import '../../../shared/styles/images.dart';
import '../../../shared/styles/styles.dart';
import '../cubit/driver_cubit.dart';
import '../reservation/view.dart';

class TrainerProfileScreen extends StatefulWidget {
  TrainerModel model;
  String image;

  TrainerProfileScreen({required this.model, required this.image, Key? key})
      : super(key: key);

  @override
  State<TrainerProfileScreen> createState() => _TrainerProfileScreenState();
}

class _TrainerProfileScreenState extends State<TrainerProfileScreen> {
  double? showRating;
  double? avgRating;
  List<TrainerReservationModel> ? trainerReservationList;

  @override
  void initState() {
    trainerReservationList = DriverCubit
        .get(context)
        .trainerReservationList;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var trainerModel = DriverCubit.get(context).trainerReservationList;
    return BlocConsumer<DriverCubit, DriverState>(
      listener: (context, state) {
        if (state is DriverGetTrainerReservationSuccessState) {
          print('get comment list');
          print(state.rate);
          avgRating = state.rate;
        }
        if (state is DriverGetTrainerReservationErrorState) {
          print(state.error);
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'الملف الشخصي',
              ),
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                  )),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // صورة البروفايل + الاسم
                    ProfileImage(
                      name: widget.model.name,
                      role: 'مدرب قيادة',
                      image: widget.image,
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // السعر+ نوع السيارة
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        children: [
                          Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              const Image(
                                image: AssetImage(money),
                                height: 25,
                                width: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${widget.model.price}' ' RS',
                                style: AppTextStyles.w400.apply(
                                  color: AppColors.greyDark,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Image(
                                image: AssetImage(car),
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${widget.model.carType}' ' : نوع السيارة ',
                                style: AppTextStyles.w400.apply(
                                  color: AppColors.greyDark,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // الشروط
                          Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              const Image(
                                image: AssetImage(list),
                                height: 20,
                                width: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'اقبل تدريب لمن تزيد اعمارهم عن  '
                                    '${widget.model.ageDriver}'
                                    ' سنة ',
                                style: AppTextStyles.w400.apply(
                                  color: AppColors.greyDark,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // الايميل
                          Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              const Image(
                                image: AssetImage(email),
                                height: 20,
                                width: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${widget.model.email}',
                                style: AppTextStyles.w400.apply(
                                  color: AppColors.greyDark,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // الرخصة + الحجز
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButtonTemplate(
                          color: AppColors.yellow,
                          height: 35,
                          width: width(context, 3),
                          onPressed: () {
                            launchUrl(Uri.parse(widget.model.licenseImage!));
                          },
                          text: 'عرض الرخصة',
                          textStyle: AppTextStyles.brButton,
                        ),
                        CustomButtonTemplate(
                          color: AppColors.pink,
                          height: 35,
                          width: width(context, 3),
                          onPressed: () =>
                              navigateTo(
                                  context,
                                  ReservationScreen(
                                    model: widget.model,
                                  )),
                          text: 'حجز',
                          textStyle: AppTextStyles.brButton,
                        ),
                      ],
                    ),
                    const Divider(
                      height: 5,
                      thickness: 1,
                      endIndent: 10,
                      indent: 10,
                      color: AppColors.black,
                    ),
                    // التقييم
                    Header(
                      text: 'التقييم ',
                      style: AppTextStyles.name,
                    ),
                    // التقييم
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: RatingBar.builder(
                            textDirection: TextDirection.rtl,
                            initialRating
                            : 3,
                            minRating: 1,
                            itemSize: 30,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,

                            itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2),
                            itemBuilder: (context, _) =>
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              if (kDebugMode) {
                                print(rating);
                              }
                              setState(() {
                                showRating = rating;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, right: 20),
                          child: Text(
                            ' $showRating',
                            style: AppTextStyles.name.apply(
                              color: AppColors.greyDark,
                            ),
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      height: 10,
                      thickness: 1,
                      endIndent: 10,
                      indent: 10,
                      color: AppColors.black,
                    ),
                    //التعليقات
                    Header(
                      text: 'التعليقات',
                      style: AppTextStyles.name,
                    ),
                    // التعليقات
                    trainerReservationList!.isEmpty
                        ? const SizedBox()
                        : SizedBox(
                      height: height(context, 3),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: trainerReservationList!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              // height: 100,
                              width: width(context, 1.2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: AppColors.red, width: 1.5),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                textDirection: TextDirection.rtl,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      Text(
                                        ' ${trainerReservationList![index]
                                            .driverName} '
                                            ' : اسم المستخدم',
                                        style: AppTextStyles.sName.copyWith(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        ' ${trainerReservationList![index]
                                            .dateOfDay}',
                                        style: AppTextStyles.w600,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${trainerReservationList![index].comment}',
                                    textDirection: TextDirection.rtl,
                                    style: AppTextStyles.w400,
                                  )
                                ],
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
