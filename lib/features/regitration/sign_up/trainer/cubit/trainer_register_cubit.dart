import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woman_drive/models/trainer_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'trainer_register_state.dart';

class TrainerRegisterCubit extends Cubit<TrainerRegisterState> {
  TrainerRegisterCubit() : super(TrainerRegisterInitialState());
  static TrainerRegisterCubit get(context) => BlocProvider.of(context);
  String? licenseImage;
  String request = 'waiting';
  File? licenseImageFile;
  var picker = ImagePicker();

  trainerRegister({
    required String name,
    required String email,
    required String password,
    required String id,
    required String age,
    required String phone,
    required String address,
    required String carType,
    required String licenseNumber,
  }) {
    emit(TrainerRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      if (kDebugMode) {
        print(value.user!.email);
        print(value.user!.uid);
        print(request);
      }
      FirebaseFirestore.instance
          .collection('users')
          .doc(value.user!.uid)
          .set({'type': 'trainer', 'request': 'waiting' , 'name' : name});

      trainerCreateAccount(
        name: name,
        email: email,
        password: password,
        id: id,
        age: age,
        phone: phone,
        address: address,
        carType: carType,
        licenseNumber: licenseNumber,
        licenseImage: licenseImage!,
        uid: value.user!.uid,
        request: request,
      );
    }).catchError((error) {
      emit(TrainerRegisterErrorState(error.toString()));
    });
  }


  showBottomSheet(BuildContext context) {
    ImagePicker picker = ImagePicker();
    XFile? file;
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: 190,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Please Choose Image",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () async {
                    file = await picker.pickImage(source: ImageSource.gallery);
                    print(file!.path);
                    Navigator.pop(context);
                    getLicenseImage(file);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.photo_outlined,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "From Gallery",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    file = await picker.pickImage(source: ImageSource.camera);
                    print(file!.path);
                    Navigator.pop(context);
                    getLicenseImage(file);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.camera,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "From Camera",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> getLicenseImage(final file) async {
    if (file != null) {
      licenseImageFile = File(file.path);
      if (kDebugMode) {
        print(file.path);
      }
      emit(TrainerUploadImageLoadingState());
      uploadImageLicense();
    } else {
      if (kDebugMode) {
        emit(TrainerGetImageErrorState('No image selected'));
        print('No image selected');
      }
    }
  }

  void uploadImageLicense() {
    emit(TrainerUploadImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('/license${Uri.file(licenseImageFile!.path).pathSegments.last}')
        .putFile(licenseImageFile!)
        .then((value) {
      if (kDebugMode) {
        print(value);
      }
      value.ref.getDownloadURL().then((value) {
        licenseImage = value;
      }).catchError((error) {
        emit(TrainerUploadImageErrorState(error.toString()));
      });
      emit(TrainerUploadImageSuccessState());
    }).catchError((error) {
      emit(TrainerUploadImageErrorState(error.toString()));
    });
  }

  trainerCreateAccount({
    required String name,
    required String email,
    required String password,
    required String id,
    required String age,
    required String phone,
    required String address,
    required String carType,
    required String licenseNumber,
    required String uid,
    required String licenseImage,
    required String request,
  }) {
    FirebaseFirestore.instance.collection('trainer').doc(uid).set({
      'age': age,
      'address': address,
      'ageDriver': '',
      'carType': carType,
      'email': email,
      'id': id,
      'licenseNumber': licenseNumber,
      'licenseImage': licenseImage,
      'name': name,
      'phone': phone,
      'request': request,
      'uid': uid,
      'price': 0,
      'bills': 0,
      'hours': [],
      'days': [],
    }).then((value) {
      emit(TrainerRegisterSuccessState(uid));
    }).catchError((error) {
      emit(TrainerRegisterErrorState(error.toString()));
    });
  }
}
