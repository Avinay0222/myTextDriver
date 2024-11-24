import 'package:driver/app/models/owner_support_ticket_modal.dart';
import 'package:driver/app/models/support_ticket_model.dart';
import 'package:driver/app/services/api_service.dart';
import 'package:get/get.dart';

class SupportScreenController extends GetxController {
  RxList<SupportTicketDataModel> supportTicketList =
      <SupportTicketDataModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading(true);
    try {
      final tickets = await getDriverSupportTickList();
      supportTicketList.assignAll(tickets
          .map((ticket) => SupportTicketDataModel.fromJson(ticket.toJson()))
          .toList());
      print(supportTicketList);
    } catch (e) {
      // Handle error
    } finally {
      isLoading(false);
    }
  }
}
