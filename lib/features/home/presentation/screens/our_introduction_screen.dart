import 'package:bjp_app/core/constants/assets_path.dart';
import 'package:bjp_app/features/home/presentation/screens/our_introduction.dart';
import 'package:flutter/material.dart';

class our_introduction_screen extends StatelessWidget {
  const our_introduction_screen({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AssetsPath.our_journey,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Positioned(
          left: 20,
          top: 10,
          //bottom: 20, // Adjust the position as needed
          child: Text(
            'আমাদের পরিচিতি',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 40,
          //bottom: 20, // Adjust the position as needed
          child: Text(
            '২০০১ সাল থেকে আজ পর্যন্ত, আমরা উন্নয়ন,\n'
            ' জনকল্যাণ ও সাম্যের জন্য '
            'নিবেদিতভাবে কাজ করে \n'
            'চলেছি।'
            'গণতন্ত্র, স্বাধীনতা, ন্যায়বিচার এবং সামাজিক ন্যায় \n'
            'নিশ্চিত করার'
            ' লক্ষ্যে আমাদের '
            'এই অগ্রযাত্রা অবিচল \n'
            'এবং অপ্রতিরোধ্য। '
            'আমরা প্রতিটি নাগরিকের কল্যাণ \n'
            ' ও সমানাধিকারের'
            'জন্য কাজ করে যাচ্ছি, '
            'যাতে সবার জন্য \n'
            'একটি সমৃদ্ধ ও সুরক্ষিত ভবিষ্যৎ নিশ্চিত করা যায়।',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 8,
            ),
          ),
        ),
        // SizedBox(
        //   height: 200,
        // ), // Adds space between TextField and ElevatedButton
        // ElevatedButton widget
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 118, 250, 0),
          child: ElevatedButton(
            onPressed: () {
              // Action when button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OurIntroduction()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Button color
              padding: EdgeInsets.zero, // Padding inside button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6), // Rounded corners
              ),
              minimumSize: Size(180, 20), // Minimum size of the button
            ),
            child: Text(
              'আরো পড়ুন', // Text inside the button
              style: TextStyle(
                fontSize: 10,
                color: Colors.black,
              ), // Font size inside button
            ),
          ),
        ),
      ],
    );
  }
}
