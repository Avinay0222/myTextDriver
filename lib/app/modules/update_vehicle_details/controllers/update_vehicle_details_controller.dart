import 'package:driver/app/models/driver_user_model.dart';
import 'package:driver/app/models/vehicle_brand_model.dart';
import 'package:driver/app/models/vehicle_model_model.dart';
import 'package:driver/app/models/vehicle_type_model.dart';
import 'package:driver/app/modules/verify_documents/controllers/verify_documents_controller.dart';
import 'package:driver/app/services/api_service.dart';
import 'package:driver/constant/constant.dart';
import 'package:driver/constant_widgets/show_toast_dialog.dart';
import 'package:driver/utils/fire_store_utils.dart';
import 'package:driver/utils/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdateVehicleDetailsController extends GetxController {
  Rx<VehicleTypeModel> vehicleTypeModel = VehicleTypeModel(
      id: "",
      image: "",
      isActive: false,
      title: "",
      persons: "0",
      charges: Charges(
        fareMinimumChargesWithinKm: "0",
        farMinimumCharges: "0",
        farePerKm: "0",
      )).obs;
  Rx<VehicleBrandModel> vehicleBrandModel = VehicleBrandModel.empty().obs;
  Rx<VehicleModel> vehicleModel = VehicleModel.empty().obs;
  List<VehicleTypeModel> vehicleTypeList = Constant.vehicleTypeList ?? [];
  RxList<VehicleBrandModel> vehicleBrandList = <VehicleBrandModel>[].obs;
  RxList<VehicleModel> vehicleModelList = <VehicleModel>[].obs;
  TextEditingController vehicleModelController = TextEditingController();
  TextEditingController vehicleBrandController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();

  @override
  Future<void> onReady() async {
    vehicleTypeModel.value = vehicleTypeList[0];
    final response = await getVehicleDetial();
    List<dynamic> list = (response)["data"] as List;
    vehicleBrandList.value =
        list.map((item) => VehicleBrandModel.fromJson(item)).toList();
    updateData();
    super.onReady();
  }

  updateData() {
    VerifyDocumentsController uploadDocumentsController =
        Get.find<VerifyDocumentsController>();
    if (uploadDocumentsController.userModel.value.driverVehicleDetails !=
        null) {
      int typeIndex = vehicleTypeList.indexWhere((element) =>
          element.id ==
          uploadDocumentsController
              .userModel.value.driverVehicleDetails!.vehicleTypeId);
      print("Type Index : $typeIndex");
      if (typeIndex != -1) vehicleTypeModel.value = vehicleTypeList[typeIndex];
      vehicleBrandController.text = uploadDocumentsController
              .userModel.value.driverVehicleDetails!.brandName ??
          '';
      vehicleModelController.text = uploadDocumentsController
              .userModel.value.driverVehicleDetails!.modelName ??
          '';
      vehicleNumberController.text = uploadDocumentsController
              .userModel.value.driverVehicleDetails!.vehicleNumber ??
          '';
    }
  }

  getVehicleModel(String id) async {
    // Match the ID from vehicleBrandList and filter the models
    vehicleModelList.value = vehicleBrandList
        .where((brand) => brand.id == id)
        .map((brand) => brand
            .models) // Assuming 'models' is a property of VehicleBrandModel
        .expand((modelList) => modelList) // Flatten the list of lists
        .toList();
  }

  saveVehicleDetails() async {
    ShowToastDialog.showLoader("please_wait".tr);
    VerifyDocumentsController verifyDocumentsController =
        Get.find<VerifyDocumentsController>();
    DriverUserModel? userModel = await Preferences.getDriverUserModel();
    if (userModel == null) return;
    DriverVehicleDetails driverVehicleDetails = DriverVehicleDetails(
      // brandName: vehicleBrandModel.value.title,
      // brandId: vehicleBrandModel.value.id,
      modelName: vehicleModel.value.name,
      modelId: vehicleModel.value.id,
      vehicleNumber: vehicleNumberController.text,
      isVerified: false,
      vehicleTypeName: vehicleTypeModel.value.title,
      vehicleTypeId: vehicleTypeModel.value.id,
    );
    userModel.driverVehicleDetails = driverVehicleDetails;
    print("==> ${userModel.driverVehicleDetails!.toJson()}");

    bool isUpdated = await FireStoreUtils.updateDriverUser(userModel);
    ShowToastDialog.closeLoader();
    if (isUpdated) {
      ShowToastDialog.showToast(
          "Vehicle details updated, Please wait for verification.");
      verifyDocumentsController.getData();
      Get.back();
    } else {
      ShowToastDialog.showToast(
          "Something went wrong, Please try again later.");
      Get.back();
    }
  }
}
