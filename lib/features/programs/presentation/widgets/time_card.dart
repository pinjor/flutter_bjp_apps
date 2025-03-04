import 'dart:async';

import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/constants/assets.dart';

class TimeCard extends StatefulWidget {
  const TimeCard({super.key});

  @override
  State<TimeCard> createState() => _TimeCardState();
}

class _TimeCardState extends State<TimeCard> {
  late DateTime _targetDate;
  Duration _remainingTime = Duration.zero;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Setting target date to 7 days from now
    _targetDate = DateTime.now().add(const Duration(days: 7));
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      setState(() {
        _remainingTime = _targetDate.difference(now);
        if (_remainingTime.isNegative) {
          _timer?.cancel();
          _remainingTime = Duration.zero;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      // height: 110,
      child: Column(
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    Assets.imagesPictureOfMan,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // // Overlay for darkening effect
              // Positioned.fill(
              //   child: Container(color: Colors.black.withOpacity(0.1)),
              // ),
              // Time holders
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildTimeHolder(context, time: '০৭', timeType: 'দিন'),
                      _buildTimeHolder(context, time: '০৫', timeType: 'ঘণ্টা'),
                      _buildTimeHolder(context, time: '১৫', timeType: 'মিনিট'),
                      _buildTimeHolder(context, time: '১০', timeType: 'সেকেন্ড'),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('২১ ফেব্রুয়ারী, ২০২৫', style: TextStyle(fontSize: 12)),
                  Text('২১ ফেব্রুয়ারী, ২০২৫', style: TextStyle(fontSize: 12)),
                  Text('বনানী, ঢাকা', style: TextStyle(fontSize: 12)),
                ],
              ),
              GestureDetector(
                onTap: (){},
                child: Container(
                  // height: 40,
                  // width: 120,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.themeColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'পরিবর্তন করুন',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Container(
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.themeColor,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(horizontal: 125),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeHolder(
    BuildContext context, {
    required String time,
    required String timeType,
  }) {
    return Container(
      height: 85,
      width: MediaQuery.of(context).size.width * 0.15,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Text(
                time,
                style: const TextStyle(
                  fontSize: 27,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(2),
                bottomRight: Radius.circular(2),
              ),
            ),
            child: Center(
              child: Text(
                timeType,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
