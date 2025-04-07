import 'package:flutter/material.dart';

class OurIntroduction extends StatelessWidget {
  const OurIntroduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          'আমাদের পরিচিতি',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'ভিশন',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Reduced spacing for better proportion
            Container(
              color: Colors.white24,
              width: double.infinity,
              //margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'আন্দালিব রহমান পার্থ',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'আন্দালিব রহমান পার্থ, চেয়ারম্যান, বাংলাদেশ জাতীয় পার্টি (বিজেপি)। তিনি একজন রাজনীতিবিদ, শিক্ষাবিদ, আইনজীবী ও সাবেক সংসদ সদস্য।',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'শিক্ষা জীবন',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'তিনি সেন্ট জোসেফ উচ্চ বিদ্যালয়ের এবং পরবর্তীতে গভর্নমেন্ট ল্যাবরেটরি হাই স্কুলের ছাত্র ছিলেন। ছাত্র জীবনে তিনি ছিলেন একজন প্রখর মেধাবী ছাত্র৷ তিনি ১৯৯৭ সালে লিংকনস ইন থেকে "বার অ্যাট ল" পরীক্ষায় পাস করেন। বর্তমানে তার প্রতিষ্ঠিত ব্রিটিশ স্কুল অব ল এর অধ্যক্ষের দায়িত্ব পালন করছেন।',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'রাজনৈতিক জীবন',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '২০০০ সাল থেকে আন্দালিব রহমান পার্থ তার বাবা মরহুম নাজিউর রহমান মঞ্জুর সাথে রাজনীতিতে সক্রিয়ভাবে জড়িয়ে পড়েন। ২০০৮ সালের এপ্রিল মাসে তার বাবার মৃত্যু হলে আন্দালিব বাংলাদেশ জাতীয় পার্টির (বিজেপি) চেয়ারম্যান নির্বাচিত হন। ২০০৮ সালের নবম জাতীয় সংসদ নির্বাচনে ভোলা-১ আসনে চারদলীয় জোটের প্রার্থী হয়ে নির্বাচনে অংশগ্রহণ করেন এবং বিপুল ভোটে জয় লাভ করেন। তিনি একাদশ জাতীয় সংসদ নির্বাচনে ঢাকা ১৭ আসনে নির্বাচন করেন।',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.9),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 60, 0, 90),
                    child: Text(
                      'স্থানীয় প্রতিনিধি',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 60, 0, 10),
                    child: Text(
                      'আচরণ বিধি',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
