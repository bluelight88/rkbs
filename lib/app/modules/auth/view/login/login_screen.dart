import 'package:flutter/services.dart';
import 'package:timoraa/app/utils/constants/asset_constants.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';
import 'package:timoraa/app/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/widgets/buttons/app_elevated_button.dart';
import '../../../../utils/constants/custom_text_form_field.dart';
import '../../../../utils/constants/route_name.dart';

class LoginScreen extends StatefulWidget {
  final bool fromBooking;
  const LoginScreen({this.fromBooking = false, super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValueNotifier<bool> isHidden = ValueNotifier<bool>(true);
  static final RegExp _emailRegex = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
  );

  String? _defaultEmailValidator(String? val) {
    final value = (val ?? '').trim();
    if (value.isEmpty) return 'Email is required';
    if (!_emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Brightness.light, // light icons for dark background
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              AssetConstants.icSplashScreen,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Positioned(
              top: 200,
              left: 30,
              right: 30,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.6,
                color: ColorConstants.primaryColor,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.25,
              left: 30,
              right: 30,
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.whiteColor,
                      ),
                    ),
                    const Gap(30),
                    Text(
                      "Welcome back!\nElegant to see you,Again!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: ColorConstants.whiteColor,
                      ),
                    ),
                    const Gap(25),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstants.whiteColor,
                      ),
                      child: SearchTextFormField(
                        controller: emailController,
                        labelText: 'Email Address',
                        onChanged: (value) {},
                        enable: true,
                        image: Icons.email_outlined,
                        validator: _defaultEmailValidator,
                      ),
                    ),
                    const Gap(20),
                    ValueListenableBuilder(
                      valueListenable: isHidden,
                      builder: (context, value, child) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorConstants.whiteColor,
                          ),
                          child: SearchTextFormField(
                            controller: passwordController,
                            labelText: 'Password',
                            onChanged: (value) {},
                            enable: true,
                            image:
                                isHidden.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                            isPassword: true,
                            isVisible: isHidden.value,
                            onTapSuffix: () {
                              isHidden.value = !isHidden.value;
                            },
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    AppElevatedButton(
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.whiteColor,
                        ),
                      ),
                      height: 50,
                      backgroundColor: ColorConstants.lightPrimaryColor,
                      onPressed: () {
                        if (widget.fromBooking) {
                          context.pushReplacementNamed(
                            RouteName.reviewBookingScreen,
                          );
                        } else {
                          context.pushReplacementNamed(
                            RouteName.dashboardScreen,
                          );
                        }
                      },
                    ),
                    const Gap(40),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            thickness: 1,
                            color: ColorConstants.whiteColor,
                            indent: 50,
                            endIndent: 10,
                          ),
                        ),
                        Text(
                          "OR",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.whiteColor,
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            thickness: 1,
                            color: ColorConstants.whiteColor,
                            indent: 10,
                            endIndent: 50,
                          ),
                        ),
                      ],
                    ),
                    const Gap(30),
                    Row(
                      children: [
                        Spacer(),
                        InkWell(
                          onTap: () {
                            // todo: key and setups once account is ready
                            // SocialAuthService.signInWithFacebook();
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.25,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: ColorConstants.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Image.asset(
                                AssetConstants.icFacebook,
                                height: 35,
                                width: 35,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            // todo: key and setups once account is ready
                            // SocialAuthService.signInWithGoogle();
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.25,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: ColorConstants.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Image.asset(
                                AssetConstants.icGoogle,
                                height: 35,
                                width: 35,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            // todo: key and setups once account is ready
                            // SocialAuthService.signInWithApple();
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.25,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: ColorConstants.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Image.asset(
                                AssetConstants.icApple,
                                height: 35,
                                width: 35,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: InkWell(
                onTap: () {
                  context.pop();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: ColorConstants.whiteColor,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
