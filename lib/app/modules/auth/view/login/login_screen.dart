import 'package:base_project/app/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/widgets/buttons/app_elevated_button.dart';
import '../../../packages/intl_phone_field/intl_phone_field.dart';

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
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IntlPhoneField(
                controller: mobileNumber,
                focusNode: phoneFocusNode,
                dropdownIcon: Icon(Icons.arrow_drop_down_rounded, size: 15),
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
                initialCountryCode: 'GB',
                onSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                },
                onChanged: (phone) {
                  debugPrint('Phone number: ${phone.completeNumber}');
                  if (phone.completeNumber.toString().length == 13) {
                    FocusScope.of(context).unfocus();
                  }
                },
              ),
              const Gap(20),
              AppElevatedButton(Text("Get OTP"), onPressed: () {}),
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
    );
  }
}
