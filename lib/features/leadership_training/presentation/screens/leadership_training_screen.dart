import 'package:bjp_app/core/constants/assets_path.dart';
import 'package:flutter/material.dart';

class LeadershipTrainingScreen extends StatefulWidget {
  const LeadershipTrainingScreen({super.key});

  @override
  State<LeadershipTrainingScreen> createState() =>
      _LeadershipTrainingScreenState();
}

class _LeadershipTrainingScreenState extends State<LeadershipTrainingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('লিডারশিপ ট্রেনিং')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: SizedBox(
                  width: 180,
                  height: 250,
                  child: Stack(
                    children: [
                      // Local asset image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          AssetsPath.discussion,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned(
                        right: 50,
                        top:200,
                        bottom: 5,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Enroll Now'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: SizedBox(
                  width: 180,
                  height: 250,
                  child: Stack(
                    children: [
                      // Local asset image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          AssetsPath.discussion,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned(
                        right: 50,
                        top:200,
                        bottom: 5,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Enroll Now'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
