import 'dart:io';

import 'package:driver/app/models/driver_user_model.dart';
import 'package:driver/app/services/api_service.dart';
import 'package:driver/constant/constant.dart';
import 'package:driver/constant_widgets/show_toast_dialog.dart';
import 'package:driver/extension/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  //TODO: Implement EditProfileController

  RxString profileImage = Constant.profileConstant.obs;
  TextEditingController countryCodeController =
      TextEditingController(text: '+91');
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  RxInt selectedGender = 1.obs;
  RxString name = ''.obs;
  RxString phoneNumber = ''.obs;
  final ImagePicker imagePicker = ImagePicker();

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }



  getUserData() async {
    Map<String, dynamic> userModel = await getProfile();
    if (userModel.isNotEmpty) {
      profileImage.value = "";
      name.value = userModel["name"] ?? '';
      nameController.text = userModel["name"] ?? '';
      phoneNumber.value =
          (userModel["country_code"] ?? '') + (userModel["phone"] ?? '');
      phoneNumberController.text = (userModel["phone"] ?? '');
      emailController.text = (userModel["email"] ?? '');
      selectedGender.value = (userModel["gender"] ?? '') == "male" ? 1 : 2;
    }

  saveUserData() async {
    DriverUserModel? userModel = await getOnlineUserModel();
    userModel.gender = selectedGender.value == 1 ? "male" : "female";
    userModel.fullName = nameController.text;
    userModel.slug = nameController.text.toSlug(delimiter: "-");
    ShowToastDialog.showLoader("Please wait");
    // if (profileImage.value.isNotEmpty &&
    //     Constant.hasValidUrl(profileImage.value) == false) {
    // profileImage.value = await Constant.uploadUserImageToFireStorage(
    //   File(profileImage.value),
    //   "profileImage/${FireStoreUtils.getCurrentUid()}",
    //   File(profileImage.value).path.split('/').last,
    // );
    //}
    // userModel.profilePic = profileImage.value;
    Map<String, dynamic> params = {
      "name": nameController.text,
      "date_of_birth": userModel.dateOfBirth,
      "email": emailController.text,
      "gender": selectedGender.value == 1 ? "Male" : "Female"
    };
    await updateOnlineUserModel(params);
    ShowToastDialog.closeLoader();
    Get.back(result: true);
  }

  Future<void> pickFile({required ImageSource source}) async {
    try {
      XFile? image =
          await imagePicker.pickImage(source: source, imageQuality: 100);
      if (image == null) return;

      Get.back();

      // Compress the image using flutter_image_compress
      Uint8List? compressedBytes = await FlutterImageCompress.compressWithFile(
        image.path,
        quality: 50,
      );

      // Save the compressed image to a new file
      File compressedFile = File(image.path);
      await compressedFile.writeAsBytes(compressedBytes!);

      profileImage.value = compressedFile.path;
    } on PlatformException catch (e) {
      ShowToastDialog.showToast("${"failed_to_pick".tr} : \n $e");
    }
  }
}
