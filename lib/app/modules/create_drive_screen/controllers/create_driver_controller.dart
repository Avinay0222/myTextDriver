import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/app/models/driver_user_model.dart';
import 'package:driver/app/modules/create_own_driver/views/create_driver_view.dart';
import 'package:driver/app/modules/home/views/home_view.dart';
import 'package:driver/app/modules/permission/views/permission_view.dart';
import 'package:driver/app/modules/verify_documents/views/verify_documents_view.dart';
import 'package:driver/app/modules/verify_driver_otp/views/verify_otp_view.dart';
import 'package:driver/app/services/api_service.dart';
import 'package:driver/constant/constant.dart';
import 'package:driver/constant_widgets/show_toast_dialog.dart';
import 'package:driver/extension/string_extensions.dart';
import 'package:driver/utils/fire_store_utils.dart';
import 'package:driver/utils/notification_service.dart';
import 'package:driver/utils/preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateDriverController extends GetxController {
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;

  TextEditingController countryCodeController =
      TextEditingController(text: '+91');
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxInt selectedGender = 1.obs;
  RxString loginType = "".obs;

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  Rx<DriverUserModel> userModel = DriverUserModel().obs;

  getArgument() async {
    dynamic argumentData = Get.arguments;
    if (argumentData != null) {
      userModel.value = argumentData['userModel'];
      loginType.value = userModel.value.loginType.toString();
      if (loginType.value == Constant.phoneLoginType) {
        phoneNumberController.text = userModel.value.phoneNumber.toString();
        countryCodeController.text = userModel.value.countryCode.toString();
      } else {
        nameController.text = userModel.value.fullName.toString();
      }
    }
    update();
  }

  createDriverAccount() async {
    ShowToastDialog.showLoader("please_wait".tr);

    Map<String, dynamic> driverMap = {
      "name": nameController.value.text,
      "phone": phoneNumberController.value.text,
      "email": emailController.text,
      "password": passwordController.text,
      "gender": selectedGender.value == 1 ? "Male" : "Female"
    };

    try {
      ShowToastDialog.showLoader("please_wait".tr);

      final responseData = await createNewDriverAccount(driverMap);

      if (responseData["status"] == true) {
        List<String> otp = responseData["msg"].toString().split(" ");
        Get.to(() =>  DriverVerifyOtpView(otp: otp.last, email: emailController.text,));
      }

      ShowToastDialog.closeLoader();

      ShowToastDialog.showToast(responseData['msg'].toString().split(",")[0]);
    } catch (e) {
      // log(e.toString());
      bool permissionGiven = await Constant.isPermissionApplied();
      ShowToastDialog.closeLoader();
      ShowToastDialog.showToast("something went wrong!".tr);
    }
  }
}
