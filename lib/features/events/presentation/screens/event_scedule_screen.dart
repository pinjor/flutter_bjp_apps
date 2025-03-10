import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/ui/custom_loader.dart';
import '../controllers/event_controller.dart';
import '../widgets/event_time_card.dart';

class EventSceduleScreen extends ConsumerStatefulWidget {
  const EventSceduleScreen({super.key});

  @override
  ConsumerState<EventSceduleScreen> createState() => _EventSceduleScreenState();
}

class _EventSceduleScreenState extends ConsumerState<EventSceduleScreen> {
  @override
  Widget build(BuildContext context) {
    final eventListState = ref.watch(eventControllerProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 140,
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
            // Multiple EventTimeCards
            eventListState.when(
              data: (events) {
                if (events.isEmpty) {
                  return Text('কোন ইভেন্ট পাওয়া যায়নি');
                }
                return ListView.builder(
                  itemCount: events.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return EventTimeCard(eventModel: events[index]);
                  },
                );
              },
              error: (err, st) => Text('ইভেন্ট লোড করতে ব্যর্থ হয়েছে: $err'),
              loading: () => CustomLoader(),
            ),
          ],
        ),
      ),
    );
  }
}
