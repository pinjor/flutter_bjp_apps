import 'package:bjp_app/core/database/division_district_map_data.dart';
import 'package:bjp_app/features/announcement/domain/announcement.dart';
import 'package:bjp_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/ui/customlisttile.dart';
import '../controllers/announcement_controller.dart';

class AnnouncementScreen extends ConsumerStatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnnouncementScreenState();
}

class _AnnouncementScreenState extends ConsumerState<AnnouncementScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(announcementControllerProvider.notifier)
          .fetchAllAnnouncements(context);
    });
  }

  void _deleteAnnouncement(String id) {
    ref
        .read(announcementControllerProvider.notifier)
        .deleteAnnouncement(context, id);
  }

  String? _getDivisionFromId(String? id) {
    return divisionMap.keys.firstWhere(
      (key) => (divisionMap[key] == id),
      orElse: () => 'সমস্ত বিভাগ',
    );
  }

  String _getDate(String? date) {
    if (date != null) {
      final parsedDate = DateTime.parse(date);
      final formattedDate = DateFormat('dd MMMM yyyy').format(parsedDate);
      return formattedDate;
    }
    return 'অজানা';
  }

  void _showAnnouncementDetails(Announcement announcement) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('বিস্তারিত'),
          content: Text(announcement.content!, style: TextStyle(fontSize: 16)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('বন্ধ করুন'),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmDeleteDialog(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('মুছে ফেলা'),
          content: Text('আপনি কি নিশ্চিত যে আপনি এই ঘোষণা মুছে ফেলতে চান?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('না'),
            ),
            TextButton(
              onPressed: () {
                _deleteAnnouncement(id);
                Navigator.pop(context);
              },
              child: Text('হ্যাঁ'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final announcementState = ref.watch(announcementControllerProvider);

    return Scaffold(
      body: announcementState.when(
        data: (announcements) {
          return announcements.isEmpty
              ? Center(child: Text('কোন ঘোষণা নেই'))
              : ListView.builder(
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  // final announcement = announcements[index];
                  final announcement = announcements.toList()[index];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: CustomListTile(
                      height: 130, // Set custom height for the list tile
                      title: Text(
                        announcement.content!,
                        style: TextStyle(fontSize: 16),
                      ),
                      subTitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "বিভাগ: ${_getDivisionFromId(announcement.divisionId)}",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: 4,
                          ), // Add spacing between subtitle and created_at
                          Text(
                            announcement.createdAt != null
                                ? _getDate(announcement.createdAt)
                                : 'তারিখ: অজানা',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                      trailing: SizedBox(
                        width:
                            120, // Constrain the width of the trailing widget
                        child: Column(
                          mainAxisSize: MainAxisSize.min, // Use minimum space
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _showAnnouncementDetails(announcement);
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF00B1B0),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ), // Reduce padding
                              ),
                              child: Text(
                                "বিস্তারিত",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            if (authState.isAdmin)
                              ElevatedButton(
                                onPressed: () {
                                  _showConfirmDeleteDialog(
                                    announcement.id!.toString(),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF00B1B0),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ), // Reduce padding
                                ),
                                child: Text(
                                  "মুছে দিন",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
        },
        error:
            (error, stackTrace) =>
                Center(child: Text('ঘোষণা গুলি লোড করতে সমস্যা হয়েছে')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
