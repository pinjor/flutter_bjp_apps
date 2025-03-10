import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/ui/customlisttile.dart';

class AnnouncementScreen extends ConsumerStatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends ConsumerState<AnnouncementScreen> {
List<Map<String, String>> data = [
    {
      "announcement": "dkfjkflfjlsdfjldkfjldkfjljgkj",
      "division": "ঢাকা",
      "created_at": "2025-03-04 06:35",
    },
    {
      "announcement": " djhfdjfjfjdfhjdfhj ...",
      "division": "ঢাকা",
      "created_at": "2025-03-04 06:35",
    },
    {
      "announcement": " rrryryryry",
      "division": "ঢাকা",
      "created_at": "2025-03-04 06:35",
    },
    {
      "announcement": "iouhohuojk",
      "division": "ঢাকা",
      "created_at": "2025-03-04 06:35",
    },
    {
      "announcement": "ljjjjjjjjjjjjjjjjjjjj...",
      "division": "ঢাকা",
      "created_at": "2025-03-04 06:35",
    },
  ];

  void _deleteItem(int index) {
    setState(() {
      data.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: CustomListTile(
              height: 130, // Set custom height for the list tile
              title: Text(
                data[index]['announcement'] ?? "No Announcement",
                style: TextStyle(fontSize: 16),
              ),

              subTitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "বিভাগ: ${data[index]['division']}",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 4,
                  ), // Add spacing between subtitle and created_at
                  Text(
                    "তারিখ: ${data[index]['created_at']}",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),

              trailing: SizedBox(
                width: 120, // Constrain the width of the trailing widget
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Use minimum space
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _deleteItem(index);
                      }, //_copyToClipboard(
                      //filteredData[index]['mobile']!,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF00B1B0),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ), // Reduce padding
                      ),
                      child: Text("মুছে দিন", style: TextStyle(fontSize: 12)),
                    ),
                    SizedBox(height: 4), // Reduce spacing between buttons
                    ElevatedButton(
                      onPressed: () {
                        //_showDetailsDialog(filteredData[index]);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF00B1B0),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ), // Reduce padding
                      ),
                      child: Text("বিস্তারিত", style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}