import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/constants/assets.dart';
import '../widgets/time_card.dart';

class ProgramSceduleScreen extends StatefulWidget {
  const ProgramSceduleScreen({super.key});

  @override
  State<ProgramSceduleScreen> createState() => _ProgramSceduleScreenState();
}

class _ProgramSceduleScreenState extends State<ProgramSceduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    width: 120,
                    height: 220,
                    decoration: BoxDecoration(
                      color: AppColors.themeColor,
                      // borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'পরিবর্তনে \nযোগ দিন!',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '''
আন্দালিব রহমান পার্থ, চেয়ারম্যান, 
বাংলাদেশ জাতীয় পার্টি বিজেপি
তিনি একজন রাজনীতিবিদ, শিক্ষাবিদ,
আইনজীবী ও সাবেক সংসদ সদস্য।
                          ''',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                // Image container
                Expanded(
                  child: SizedBox(
                    // margin: const EdgeInsets.only(left: 8.0),
                    child: Image.asset(
                      Assets.scheduleScreenBannerImage,
                      width: 160,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Multiple TimeCards
          const TimeCard(),
          const TimeCard(),
        ],
      ),
    );
  }
}
