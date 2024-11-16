import 'package:driver/app/modules/create_drive_screen/controllers/create_driver_controller.dart';
import 'package:driver/app/modules/create_own_driver/controllers/create_driver_controller.dart';
import 'package:get/get.dart';

class CreateOwnDrvierBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      CreateOwnDriverController(),
    );
  }
}
