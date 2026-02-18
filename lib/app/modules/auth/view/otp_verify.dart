import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/core/widgets/buttons/app_elevated_button.dart';
import 'package:timoraa/app/utils/constants/asset_constants.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';

class OtpScreen extends StatefulWidget {
  final int customerId;

  const OtpScreen({
    super.key,
    required this.customerId,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();

  Timer? _timer;
  int _remainingSeconds = 600; // 10 minutes
  bool _isExpired = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _remainingSeconds = 600;
    _isExpired = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
        setState(() {
          _isExpired = true;
        });
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  String get _formattedTime {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  String? _otpValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "OTP is required";
    }
    if (value.length != 6) {
      return "Enter valid 6-digit OTP";
    }
    if (_isExpired) {
      return "OTP has expired. Please resend.";
    }
    return null;
  }

  void _verifyOtp() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_isExpired) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OTP expired. Please resend.")),
        );
        return;
      }

      // Call OTP verify API / Bloc here

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP Verified Successfully")),
      );

      // Navigate to Login or Home
    }
  }

  void _resendOtp() {
    otpController.clear();
    _startTimer();

    // Call resend OTP API here

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("New OTP Sent")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
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

            /// Purple Block
            Positioned(
              top: 200,
              left: 30,
              right: 30,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.42,
                color: ColorConstants.primaryColor,
              ),
            ),

            /// OTP Form
            Positioned(
              top: MediaQuery.of(context).size.height * 0.25,
              left: 30,
              right: 30,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),

                    Text(
                      "OTP Verification",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.whiteColor,
                      ),
                    ),

                    const Gap(10),

                    Text(
                      _isExpired
                          ? "OTP Expired"
                          : "OTP valid for $_formattedTime",
                      style: TextStyle(
                        fontSize: 16,
                        color: _isExpired
                            ? Colors.red
                            : ColorConstants.whiteColor,
                      ),
                    ),

                    const Gap(25),

                    /// OTP Field
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: ColorConstants.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          hintText: "Enter 6-digit OTP",
                          counterText: "",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15),
                        ),
                        validator: _otpValidator,
                      ),
                    ),

                    const Gap(30),

                    /// Verify Button
                    AppElevatedButton(
                      const Text(
                        "Verify OTP",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      height: 50,
                      backgroundColor:
                          ColorConstants.lightPrimaryColor,
                      onPressed: _verifyOtp,
                    ),

                    const Gap(15),

                    /// Resend OTP
                    Center(
                      child: TextButton(
                        onPressed: _isExpired ? _resendOtp : null,
                        child: Text(
                          "Resend OTP",
                          style: TextStyle(
                            color: _isExpired
                                ? Colors.white
                                : Colors.white54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Back Button
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
    );
  }
}
