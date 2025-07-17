import 'package:timoraa/app/utils/constants/asset_constants.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';
import 'package:timoraa/app/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/utils/services/app_state.dart';
import '../../../../core/packages/intl_phone_field/intl_phone_field.dart';
import '../../../../core/widgets/buttons/app_elevated_button.dart';
import '../../../../utils/constants/route_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileNumber = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();

  @override
  void dispose() {
    mobileNumber.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.4),
              BlendMode.darken,
            ),
            child: Image.asset(
              AssetConstants.icBackgroundImage,
              fit: BoxFit.fitWidth,
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                children: [
                  const Gap(10),
                  Text(
                    "Man",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.primaryColor,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    "Grooming",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.primaryColor,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    endIndent: 150,
                    indent: 150,
                    color: ColorConstants.greyColor,
                  ),
                  const Gap(20),
                  Text(
                    "Sign with Mobile",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.primaryColor,
                    ),
                  ),
                  const Gap(5),
                  Text(
                    "We will send one time password for into login",
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorConstants.primaryColor,
                    ),
                  ),
                  const Gap(25),
                  IntlPhoneField(
                    controller: mobileNumber,
                    focusNode: phoneFocusNode,
                    dropdownIcon: Icon(Icons.arrow_drop_down, size: 15),
                    flagsButtonPadding: EdgeInsets.symmetric(horizontal: 10),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      counterText: '',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red[900]!),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red[900]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    initialCountryCode: appState.countryCode.value,
                    onSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                    },
                    onChanged: (phone) {
                      debugPrint('Phone number: ${phone.completeNumber}');
                      if (phone.completeNumber.toString().length == 13) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                    onCountryChanged: (country) {
                      debugPrint(
                        'Country changed to: ${country.name} (${country.code})',
                      );
                      appState.countryCode.value = country.code;
                    },
                  ),
                  const Gap(20),
                  AppElevatedButton(
                    Text("Get OTP"),
                    onPressed: () {
                      context.pushReplacementNamed(RouteName.dashboardScreen);
                    },
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 1,
                          color: ColorConstants.greyColor,
                        ),
                      ),
                      Text("OR"),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 1,
                          color: ColorConstants.greyColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
