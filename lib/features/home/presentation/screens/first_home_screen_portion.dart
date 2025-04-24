import 'package:bjp_app/core/constants/assets_path.dart';
import 'package:flutter/material.dart';

class first_home_screen_portion extends StatelessWidget {
  const first_home_screen_portion({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          width: 200,
          color: Colors.cyan,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'পরিবর্তনে যোগ দিন',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10), // Adds space between the two text widgets
                Text(
                  'আমাদের লক্ষ্য একটি এমন সমাজ গঠন করা যেখানে '
                  'প্রতিটি মানুষ সমান সুযোগ এবং মর্যাদা পাবে। আমরা বিশ্বাস করি যে '
                  'সুশাসন ও জনগণের সক্রিয় অংশগ্রহণ ছাড়া প্রকৃত উন্নয়ন সম্ভব নয়।',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 8,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'ন্যায়বিচার ও সমানাধিকারের ওপর ভিত্তি করে আমরা একটি ন্যায়সংগত '
                  'সমাজ বিনির্মাণে প্রতিশ্রুতিবদ্ধ, যেখানে প্রত্যেকে স্বাধীনভাবে নিজের মত প্রকাশ '
                  'করতে পারবে এবং সঠিক অধিকার ভোগ করতে সক্ষম হবে।',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ),
        ),

        //SizedBox(width:2),
        Image.asset(
          AssetsPath.imagetwo,

          height: 200,
          width: 160,
          fit: BoxFit.cover,
        ),

        // Add some space between the image and text
        // The text with background color
      ],
    );
  }
}
