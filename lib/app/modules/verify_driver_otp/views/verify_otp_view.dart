import 'package:driver/app/models/driver_user_model.dart';
import 'package:driver/app/modules/create_own_driver/views/create_driver_view.dart';
import 'package:driver/app/modules/home/views/home_view.dart';
import 'package:driver/app/modules/permission/views/permission_view.dart';
import 'package:driver/app/modules/signup/views/signup_view.dart';
import 'package:driver/app/services/api_service.dart';
import 'package:driver/constant/constant.dart';
import 'package:driver/constant_widgets/round_shape_button.dart';
import 'package:driver/constant_widgets/show_toast_dialog.dart';
import 'package:driver/theme/app_them_data.dart';
import 'package:driver/utils/dark_theme_provider.dart';
import 'package:driver/utils/preferences.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import '../controllers/verify_otp_controller.dart';

class DriverVerifyOtpView extends StatelessWidget {
  String otp, email;

  DriverVerifyOtpView({super.key, required this.otp, required this.email});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetBuilder<DriverVerifyOtpontroller>(
        init: DriverVerifyOtpontroller(),
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              bool isFocus = FocusScope.of(context).hasFocus;
              if (isFocus) {
                FocusScope.of(context).unfocus();
              }
            },
            child: Scaffold(
              backgroundColor: themeChange.isDarkTheme()
                  ? AppThemData.black
                  : AppThemData.white,
              appBar: AppBar(
                forceMaterialTransparency: true,
                backgroundColor: themeChange.isDarkTheme()
                    ? AppThemData.black
                    : AppThemData.white,
                centerTitle: true,
                automaticallyImplyLeading: false,
                leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back_rounded)),
                iconTheme: IconThemeData(
                    color: themeChange.isDarkTheme()
                        ? AppThemData.white
                        : AppThemData.black),
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 31),
                child: Column(
                  children: [
                    Text(
                      "Verify Your Phone Number".tr,
                      style: GoogleFonts.inter(
                          fontSize: 24,
                          color: themeChange.isDarkTheme()
                              ? AppThemData.white
                              : AppThemData.black,
                          fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 33),
                      child: Text(
                        "Enter  6-digit code sent to your mobile number to complete verification."
                            .tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: themeChange.isDarkTheme()
                                ? AppThemData.white
                                : AppThemData.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    OTPTextField(
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 40,
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          color: themeChange.isDarkTheme()
                              ? AppThemData.white
                              : AppThemData.grey950,
                          fontWeight: FontWeight.w500),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      otpFieldStyle: OtpFieldStyle(
                        focusBorderColor: AppThemData.primary500,
                        borderColor: AppThemData.grey100,
                        enabledBorderColor: AppThemData.grey100,
                      ),
                      fieldStyle: FieldStyle.underline,
                    ),
                    const SizedBox(height: 90),
                    RoundShapeButton(
                        size: const Size(200, 45),
                        title: "verify_OTP".tr,
                        buttonColor: AppThemData.primary500,
                        buttonTextColor: AppThemData.black,
                        onTap: () async {
                          ShowToastDialog.showLoader("verify_OTP".tr);

                          try {
                            ShowToastDialog.showLoader("please_wait".tr);

                            final responseData = await verifyDriverOtp(
                              otp,
                              email,
                            );

                            if (responseData["status"] == true) {
                              ShowToastDialog.showToast(
                                  '${responseData["msg"]}');
                              Get.to(() => const CreateOwnDriver());
                            } else {
                              ShowToastDialog.showToast(
                                  'Failed to verify OTP: ${responseData["msg"]}');
                            }

                            ShowToastDialog.closeLoader();
                          } catch (e) {
                            // log(e.toString());
                            ShowToastDialog.closeLoader();
                            ShowToastDialog.showToast(
                                "something went wrong!".tr);
                          }
                        }),
                    const SizedBox(height: 24),
                    // Text.rich(
                    //   TextSpan(
                    //     // recognizer: TapGestureRecognizer()
                    //     //   ..onTap = () {
                    //     //     controller.sendOTP();
                    //     //   },
                    //     children: [
                    //       TextSpan(
                    //         text: 'Did’t Receive a code ?'.tr,
                    //         style: GoogleFonts.inter(
                    //             fontSize: 14,
                    //             color: AppThemData.grey400,
                    //             fontWeight: FontWeight.w400),
                    //       ),
                    //       TextSpan(
                    //           text: ' ${'Resend Code'.tr}',
                    //           style: GoogleFonts.inter(
                    //               fontSize: 14,
                    //               color: themeChange.isDarkTheme()
                    //                   ? AppThemData.white
                    //                   : AppThemData.grey950,
                    //               fontWeight: FontWeight.w600),
                    //           recognizer: TapGestureRecognizer()
                    //             ..onTap = () {
                    //               controller.sendOTP();
                    //             }),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
