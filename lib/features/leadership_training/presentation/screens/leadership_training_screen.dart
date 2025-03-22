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
    return Scaffold(appBar: AppBar(title: Text('লিডারশিপ ট্রেনিং')));
  }
}
