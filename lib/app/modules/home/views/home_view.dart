import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:driver/app/models/booking_model.dart';
import 'package:driver/app/models/user_model.dart';
import 'package:driver/app/modules/home/views/widgets/active_ride_view.dart';
import 'package:driver/app/modules/home/views/widgets/chart_view.dart';
import 'package:driver/app/modules/home/views/widgets/drawer_view.dart';
import 'package:driver/app/modules/home/views/widgets/new_ride_view.dart';
import 'package:driver/app/modules/html_view_screen/views/html_view_screen_view.dart';
import 'package:driver/app/modules/language/views/language_view.dart';
import 'package:driver/app/modules/my_bank/views/my_bank_view.dart';
import 'package:driver/app/modules/my_rides/views/my_rides_view.dart';
import 'package:driver/app/modules/my_wallet/views/my_wallet_view.dart';
import 'package:driver/app/modules/notifications/views/notifications_view.dart';
import 'package:driver/app/modules/support_screen/views/support_screen_view.dart';
import 'package:driver/app/modules/verify_documents/views/verify_documents_view.dart';
import 'package:driver/app/routes/app_pages.dart';
import 'package:driver/app/services/api_service.dart';
import 'package:driver/constant/api_constant.dart';
import 'package:driver/constant/constant.dart';
import 'package:driver/constant_widgets/star_rating.dart';
import 'package:driver/theme/app_them_data.dart';
import 'package:driver/theme/responsive.dart';
import 'package:driver/utils/dark_theme_provider.dart';
import 'package:driver/utils/fire_store_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetBuilder<HomeController>(
      init: HomeController(),
      dispose: (state) {
        FireStoreUtils().closeStream();
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor:
              themeChange.isDarkTheme() ? AppThemData.black : AppThemData.white,
          appBar: buildAppBar(themeChange),
          drawer: const DrawerView(),
          body: Obx(() => buildBody(controller, themeChange)),
        );
      },
    );
  }

  AppBar buildAppBar(DarkThemeProvider themeChange) {
    return AppBar(
      shape: Border(
        bottom: BorderSide(
          color: themeChange.isDarkTheme()
              ? AppThemData.grey800
              : AppThemData.grey100,
          width: 1,
        ),
      ),
      title: buildAppBarTitle(themeChange),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Get.to(() => const NotificationsView());
          },
          icon: const Icon(Icons.notifications_none_rounded),
        ),
      ],
    );
  }

  Row buildAppBarTitle(DarkThemeProvider themeChange) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            await getRequest();
          },
          child: SvgPicture.asset("assets/icon/logo_only.svg"),
        ),
        const SizedBox(width: 10),
        Text(
          'MyTaxi'.tr,
          style: GoogleFonts.inter(
            color: themeChange.isDarkTheme()
                ? AppThemData.white
                : AppThemData.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget buildBody(HomeController controller, DarkThemeProvider themeChange) {
    final drawerIndex = controller.drawerIndex.value;

    if (drawerIndex == 1) return MyRidesView();
    if (drawerIndex == 3) return const MyBankView();
    if (drawerIndex == 4) return const VerifyDocumentsView(isFromDrawer: true);
    if (drawerIndex == 5) return const SupportScreenView();
    if (drawerIndex == 6)
      return HtmlViewScreenView(
          title: "Privacy & Policy", htmlData: Constant.privacyPolicy);
    if (drawerIndex == 7)
      return HtmlViewScreenView(
          title: "Terms & Condition", htmlData: Constant.termsAndConditions);
    if (drawerIndex == 8) return const LanguageView();
    if (controller.isLoading.value) return Constant.loader();

    return buildMainContent(controller, themeChange);
  }

  Widget buildMainContent(
      HomeController controller, DarkThemeProvider themeChange) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildEarningsContainer(controller, themeChange),
            const SizedBox(height: 16),
            buildLiveBookingStream(controller),
            buildActiveBookingStream(controller),
            buildBookingStream(controller),
            // ... other widgets ...
          ],
        ),
      ),
    );
  }

  Container buildEarningsContainer(
      HomeController controller, DarkThemeProvider themeChange) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/images/top_banner_background.png"),
          fit: BoxFit.cover,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildEarningsText(controller),
          SvgPicture.asset("assets/icon/ic_hand_currency.svg",
              width: 52, height: 52),
        ],
      ),
    );
  }

  Column buildEarningsText(HomeController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Earnings'.tr,
          style: GoogleFonts.inter(
            color: AppThemData.white,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          width: 200,
          margin: const EdgeInsets.only(top: 6),
          child: Text(
            Constant.amountShow(
                amount: (controller.userModel.value.totalEarning ?? '0.0')
                    .toString()),
            style: GoogleFonts.inter(
              color: AppThemData.grey50,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLiveBookingStream(HomeController controller) {
    return Column(children: [
      const Text("inProgress Rides"),
      Visibility(
        visible: controller.isOnline.value,
        child: StreamBuilder<List<RideData>>(
          stream: getLiveRidesRequest(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              List<RideData> bookings = snapshot.data!;
              if (bookings.isNotEmpty) {
                return Row(
                  children: bookings.map((booking) {
                    RideData bookingModel = snapshot.data!.first;
                    return ActiveRideView(
                      bookingModel: bookingModel,
                    );

                    // return ListTile(
                    //   title: Text(booking.rideId!),
                    //   subtitle: Text(booking.status!),
                    // );
                  }).toList(),
                );
              } else {
                return Center(child: Text('No bookings available'));
              }
            }
            return Container();
          },
        ),
      )
    ]);
  }

  Widget buildActiveBookingStream(HomeController controller) {
    return Column(children: [
      const Text("Active Rides"),
      Visibility(
        visible: controller.isOnline.value,
        child: StreamBuilder<List<RideData>>(
          stream: getActiveRidesRequest(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              List<RideData> bookings = snapshot.data!;
              if (bookings.isNotEmpty) {
                return Row(
                  children: bookings.map((booking) {
                    RideData bookingModel = snapshot.data!.first;
                    return ActiveRideView(
                      bookingModel: bookingModel,
                    );

                    // return ListTile(
                    //   title: Text(booking.rideId!),
                    //   subtitle: Text(booking.status!),
                    // );
                  }).toList(),
                );
              } else {
                return Center(child: Text('No bookings available'));
              }
            }
            return Container();
          },
        ),
      )
    ]);
  }

  Widget buildBookingStream(HomeController controller) {
    return Column(children: [
      const SizedBox(height: 20),
      Text(
        'New Ride'.tr,
        style: GoogleFonts.inter(
          // color: themeChange.isDarkTheme() ? AppThemData.grey25 : AppThemData.grey950,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 0.08,
        ),
      ),
      const SizedBox(height: 20),
      Visibility(
        visible: controller.isOnline.value,
        child: StreamBuilder<List<BookingModel>>(
          stream: getRequest(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              List<BookingModel> bookings = snapshot.data!;
              if (bookings.isNotEmpty) {
                return SingleChildScrollView(
                  child: Column(
                    children: bookings.map((booking) {
                      BookingModel bookingModel = snapshot.data!.first;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          NewRideView(
                            bookingModel: bookingModel,
                          ),
                          const SizedBox(height: 4),
                        ],
                      );
                    }).toList(),
                  ),
                );
              } else {
                return Center(child: Text('No bookings available'));
              }
            }
            return Container();
          },
        ),
      )
    ]);
  }
}

goOnlineDialog({
  required BuildContext context,
  required String title,
  required descriptions,
  required string,
  required Widget img,
  required Function() onClick,
  required DarkThemeProvider themeChange,
  Color? buttonColor,
  Color? buttonTextColor,
}) {
  return Container(
    padding: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: themeChange.isDarkTheme() ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(20)),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        img,
        const SizedBox(
          height: 20,
        ),
        Visibility(
          visible: title.isNotEmpty,
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: themeChange.isDarkTheme()
                  ? AppThemData.grey25
                  : AppThemData.grey950,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Visibility(
          visible: descriptions.isNotEmpty,
          child: Text(
            descriptions,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: themeChange.isDarkTheme()
                  ? AppThemData.grey25
                  : AppThemData.grey950,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  onClick();
                },
                child: Container(
                  width: Responsive.width(100, context),
                  height: 45,
                  decoration: ShapeDecoration(
                    color: buttonColor ?? AppThemData.primary500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        string.toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: buttonTextColor ?? AppThemData.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
