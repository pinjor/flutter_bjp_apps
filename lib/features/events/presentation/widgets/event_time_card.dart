import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/constants/assets.dart';
import '../../domain/event_model.dart';
import '../../../../core/constants/api_constants.dart';

class EventTimeCard extends StatefulWidget {
  const EventTimeCard({super.key, required this.eventModel});

  final EventModel eventModel;

  @override
  State<EventTimeCard> createState() => _EventTimeCardState();
}

class _EventTimeCardState extends State<EventTimeCard> {
  late DateTime _targetDate;
  Duration _remainingTime = Duration.zero;
  Timer? _timer;
  bool _isDateFormattingInitialized = false;

  @override
  void initState() {
    super.initState();
    // Initialize Bengali date formatting.
    initializeDateFormatting('bn', null).then((_) {
      setState(() {
        _isDateFormattingInitialized = true;
      });
    });
    // Parse the event date from the model.
    _targetDate = DateTime.parse(widget.eventModel.date!);
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

  // Helper: Convert English digits in a string to Bengali digits.
  String convertToBengaliDigits(String input) {
    final Map<String, String> bengaliDigits = {
      '0': '০',
      '1': '১',
      '2': '২',
      '3': '৩',
      '4': '৪',
      '5': '৫',
      '6': '৬',
      '7': '৭',
      '8': '৮',
      '9': '৯',
    };
    String output = '';
    for (int i = 0; i < input.length; i++) {
      String ch = input[i];
      output += bengaliDigits[ch] ?? ch;
    }
    return output;
  }

  // Formats the DateTime into a Bengali date string.
  String formatDateToBengali(DateTime date) {
    String formatted = DateFormat.yMMMMd('bn').format(date);
    return convertToBengaliDigits(formatted);
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
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
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

  @override
  Widget build(BuildContext context) {
    // Countdown components.
    int days = _remainingTime.inDays;
    int hours = _remainingTime.inHours % 24;
    int minutes = _remainingTime.inMinutes % 60;
    int seconds = _remainingTime.inSeconds % 60;

    String daysStr = convertToBengaliDigits(days.toString().padLeft(2, '0'));
    String hoursStr = convertToBengaliDigits(hours.toString().padLeft(2, '0'));
    String minutesStr = convertToBengaliDigits(
      minutes.toString().padLeft(2, '0'),
    );
    String secondsStr = convertToBengaliDigits(
      seconds.toString().padLeft(2, '0'),
    );

    final eventImageUri =
        Uri(
          scheme: 'http',
          host: ApiConstants.baseUrl,
          port: ApiConstants.port,
          path: '/storage/${widget.eventModel.image}',
        ).toString();

    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Background image with countdown overlay.
          Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl:
                        widget.eventModel.image!.isNotEmpty
                            ? eventImageUri
                            : Assets.imagesPictureOfMan,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTimeHolder(context, time: daysStr, timeType: 'দিন'),
                      _buildTimeHolder(
                        context,
                        time: hoursStr,
                        timeType: 'ঘণ্টা',
                      ),
                      _buildTimeHolder(
                        context,
                        time: minutesStr,
                        timeType: 'মিনিট',
                      ),
                      _buildTimeHolder(
                        context,
                        time: secondsStr,
                        timeType: 'সেকেন্ড',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.themeColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'ইভেন্ট',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
              // formatted date.
              Text(
                _isDateFormattingInitialized
                    ? formatDateToBengali(_targetDate)
                    : 'তারিখ লোড হচ্ছে...',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 5),
          // Event title.
          Text(
            widget.eventModel.title!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          // Optional description.
          if (widget.eventModel.description!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                widget.eventModel.description!,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          const SizedBox(height: 5),
          // Address.
          Text(widget.eventModel.address!),
          const SizedBox(height: 14),

          // Separator.
          Container(
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 125),
            decoration: BoxDecoration(
              color: AppColors.themeColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
