import 'package:bjp_app/core/constants/assets_path.dart';
import 'package:flutter/material.dart';

class OurDiscussion extends StatefulWidget {
  const OurDiscussion({super.key});

  @override
  State<OurDiscussion> createState() => _OurDiscussionState();
}

class _OurDiscussionState extends State<OurDiscussion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('আলোচনা')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 120, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(child: Image.asset(AssetsPath.discussion)),
            SizedBox(height: 20),
            Text(
              'আলোচনা ১',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              'By admin, Published: 23 Feb, 2025',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'There are many variations of passages of Lorem Ipsum available, ',
              style: TextStyle(fontSize: 12,),
            ),
          ],
        ),
      ),
    );
  }
}
