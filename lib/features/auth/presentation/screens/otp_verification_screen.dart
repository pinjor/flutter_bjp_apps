import 'package:flutter/material.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../config/app_colors.dart';
import '../../../../core/constants/route_path.dart';

class OtpVeificationScreen extends StatefulWidget {
  const OtpVeificationScreen({super.key});

  @override
  State<OtpVeificationScreen> createState() => _OtpVeificationScreenState();
}

class _OtpVeificationScreenState extends State<OtpVeificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final OtpTimerButtonController controller = OtpTimerButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 80),
                //AppLogoWidget(),
                SizedBox(height: 20),
                Text(
                  'আপনার ইমেইল যাচাই করুন',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                // Text(
                //   'A 6 Digit OTP Code has been Sent',
                //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                //         color: Colors.grey,
                // ),
                // ),
                SizedBox(height: 24.0),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    //fieldHeight: 50,
                    // fieldWidth: 40,
                    activeFillColor: AppColors.themeColor,
                    selectedFillColor: AppColors.themeColor,
                    inactiveColor: AppColors.themeColor,
                    selectedColor: AppColors.themeColor,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  keyboardType: TextInputType.number,
                  //enableActiveFill: true,
                  appContext: context,
                  controller: _otpTEController,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    //if (_formKey.currentState!.validate()) {}
                    Navigator.pushNamed(context, RoutePath.newPasswordScreenPath);
                  },
                  child: Text('পরবর্তী', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 24.0),
                RichText(
                  text: TextSpan(
                    text: 'এই কোডটির মেয়াদ শেষ হবে ',
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: '৩০ সে.',
                        style: TextStyle(color: AppColors.themeColor),
                      ),
                    ],
                  ),
                ),
                // TextButton(
                //   onPressed: () {},
                //   child: Text('Resend Code'),
                // ),
                OtpTimerButton(
                  controller: controller,
                  onPressed: () {},
                  text: Text('পুনরায় পাঠান'),
                  duration: 30,
                  buttonType: ButtonType.text_button,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
