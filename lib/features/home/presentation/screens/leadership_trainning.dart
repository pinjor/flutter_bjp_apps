import 'package:bjp_app/config/app_colors.dart';
import 'package:bjp_app/core/constants/assets_path.dart';
import 'package:bjp_app/features/leadership_training/presentation/screens/leadership_training_screen.dart';
import 'package:flutter/material.dart';

class LeadershipTrainingSection extends StatelessWidget {
  const LeadershipTrainingSection({super.key});

  @override
  Widget build(BuildContext context) {
    // <-- Access context here
    return Stack(
      children: [
        Image.asset(
          AssetsPath.join_to_change,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Positioned(
          left: 170,
          top: 10,
          child: Text(
            'উন্নয়ন ও সমৃদ্ধির পথে',
            style: TextStyle(
              color: Colors.cyan,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        Positioned(
          left: 170,
          top: 40,
          child: Text(
            'গণতন্ত্র ও ন্যায়বিচার দ্বারা পরিচালিত \n '
            'আমরা একটি সমৃদ্ধ নিরাপদ এবং সবার জন্য \n'
            'সমান সুযোগসমৃদ্ধ বাংলাদেশের জন্য \n'
            'নিরলস কাজ করে যাচ্ছি। আমাদের লক্ষ্য একটি এমন \n'
            'বাংলাদেশ গঠন করা যেখানে প্রতিটি মানুষ তার \n'
            ' অধিকার,মর্যাদাও সম্ভাবনা অর্জনের সুযোগ পাবে।\n'
            ' সমৃদ্ধি, সাম্য এবং শান্তির ভিত্তিতে আমরা এমন \n'
            'একটি সমাজ গড়ে তুলতে প্রতিশ্রুতিবদ্ধ, যা আগামী\n'
            ' প্রজন্মের জন্য এক আদর্শ দৃষ্টান্ত হবে।',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 6,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(170, 118, 110, 0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context, // <-- Now valid because we're inside a widget
                MaterialPageRoute(
                  builder: (context) => LeadershipTrainingScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.themeColor,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              minimumSize: Size(180, 20),
            ),
            child: Text(
              'লিডারশিপ ট্রেনিং',
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
