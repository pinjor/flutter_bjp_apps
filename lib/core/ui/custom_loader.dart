import 'package:bjp_app/config/app_colors.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.themeColor),
        strokeWidth: 6.0,
        backgroundColor: Colors.white,
      ),
    );
  }
}