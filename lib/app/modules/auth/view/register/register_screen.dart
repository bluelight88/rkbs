import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/modules/auth/view_model/register/register_bloc.dart';

import 'package:timoraa/app/utils/constants/asset_constants.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';
import 'package:timoraa/app/utils/constants/route_name.dart';
import '../../../../core/widgets/buttons/app_elevated_button.dart';
import '../../../../utils/constants/custom_text_form_field.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  ValueNotifier<bool> isHidden = ValueNotifier(true);

  String selectedCountryCode = '+44';

  final List<Map<String, String>> countryCodes = [
    {'code': '+91', 'country': 'India'},
    {'code': '+1', 'country': 'USA'},
    {'code': '+44', 'country': 'UK'},
    {'code': '+61', 'country': 'Australia'},
    {'code': '+971', 'country': 'UAE'},
  ];

  static final RegExp _emailRegex =
      RegExp(r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

  String? _requiredValidator(String? val, String label) {
    if (val == null || val.trim().isEmpty) {
      return '$label is required';
    }
    return null;
  }

  String? _emailValidator(String? val) {
    if (val == null || val.trim().isEmpty) return 'Email is required';
    if (!_emailRegex.hasMatch(val.trim())) return 'Enter valid email';
    return null;
  }

  String? _passwordValidator(String? val) {
    if (val == null || val.trim().isEmpty) return 'Password is required';
    if (val.length < 6) return 'Minimum 6 characters';
    return null;
  }

  String? _confirmPasswordValidator(String? val) {
    if (val == null || val.isEmpty) return 'Confirm password is required';
    if (val != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
       if (state is RegisterSuccess) {
          Navigator.pushReplacementNamed(
            context,
            RouteName.otpVerify,
            arguments: {
              "customerId": state.model.customerId,
            },
          );
        }

        if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          body: Stack(
            children: [
              /// Background
              Image.asset(
                AssetConstants.icSplashScreen,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),

              /// Purple block
              Positioned(
                top: 200,
                left: 30,
                right: 30,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  color: ColorConstants.primaryColor,
                ),
              ),

              /// Form
              Positioned(
                top: MediaQuery.of(context).size.height * 0.20,
                left: 30,
                right: 30,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(20),

                        Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.whiteColor,
                          ),
                        ),

                        const Gap(10),

                        Text(
                          "Create your account",
                          style: TextStyle(
                            fontSize: 18,
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
                            controller: nameController,
                            labelText: 'Full Name',
                            onChanged: (value) {},
                            enable: true,
                            image: Icons.person_outline,
                            validator: (v) => _requiredValidator(v, 'Name'),
                          ),
                        ),
                        const Gap(15),
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
                            validator: _emailValidator,
                          ),
                        ),

                        const Gap(15),

                        /// Mobile
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: ColorConstants.whiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedCountryCode,
                                  items: countryCodes
                                      .map(
                                        (item) => DropdownMenuItem(
                                          value: item['code'],
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Text(item['code']!),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCountryCode = value!;
                                    });
                                  },
                                ),
                              ),
                              const VerticalDivider(width: 1),
                              Expanded(
                                child: SearchTextFormField(
                                  controller: mobileController,
                                  enable: true,
                                  labelText: 'Mobile Number',
                                  keyboardType: TextInputType.phone,
                                  image: Icons.phone_outlined,
                                  onChanged: (value) {},
                                  validator: (v) {
                                    if (v == null || v.trim().isEmpty) {
                                      return 'Mobile number is required';
                                    }
                                    if (v.length < 7) {
                                      return 'Enter valid mobile number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Gap(15),

                        /// Password
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
                                validator: _passwordValidator,
                                onTapSuffix: () {
                                  isHidden.value = !isHidden.value;
                                },
                              ),
                            );
                          },
                        ),

                        const Gap(15),

                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorConstants.whiteColor,
                          ),
                          child: SearchTextFormField(
                            controller: confirmPasswordController,
                            labelText: 'Confirm Password',
                            onChanged: (value) {},
                            enable: true,
                            image: Icons.lock_outline,
                            validator: _confirmPasswordValidator,
                          ),
                        ),

                        

                        const Gap(30),

                        /// Register Button with Loading
                        BlocBuilder<RegisterBloc, RegisterState>(
                          builder: (context, state) {
                            return AppElevatedButton(
                              state is RegisterLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      "Register",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            ColorConstants.whiteColor,
                                      ),
                                    ),
                              height: 50,
                              backgroundColor:
                                  ColorConstants.lightPrimaryColor,
                              onPressed: () {
                                if (state is RegisterLoading) return;

                                if (_formKey.currentState?.validate() ?? false) {
                                  context.read<RegisterBloc>().add(
                                    CustomerRegister(
                                      email: emailController.text.trim(),
                                      name: nameController.text.trim(),
                                      mobilenumber: mobileController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),

                        const Gap(20),
                      ],
                    ),
                  ),
                ),
              ),

              /// Back
              Positioned(
                top: 50,
                left: 20,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    color: ColorConstants.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
