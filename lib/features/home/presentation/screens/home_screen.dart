import 'package:bjp_app/config/app_colors.dart';
import 'package:bjp_app/core/ui/custom_loader.dart';
import 'package:bjp_app/core/utils/utils.dart';
import 'package:bjp_app/features/announcement/presentation/screens/announcement_screen.dart';
import 'package:bjp_app/features/auth/domain/auth_state.dart';
import 'package:bjp_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:bjp_app/features/chat/presentation/screens/chat_screen.dart';
import 'package:bjp_app/features/events/presentation/screens/event_scedule_screen.dart';
import 'package:bjp_app/features/events/presentation/widgets/event_time_card.dart';
import 'package:bjp_app/features/home/domain/recent_announcement.dart';
import 'package:bjp_app/features/home/presentation/controllers/home_controller.dart';
import 'package:bjp_app/features/home/presentation/screens/our_constitution.dart';
import 'package:bjp_app/features/home/presentation/screens/our_introduction.dart';
import 'package:bjp_app/features/home/presentation/widgets/discussion_card_widget.dart';
import 'package:bjp_app/features/leadership_training/presentation/screens/leadership_training_screen.dart';
import 'package:bjp_app/features/media/presentation/screens/photo_album_screen.dart';
import 'package:bjp_app/features/media/presentation/screens/video_album_screen.dart';
import 'package:bjp_app/features/member/presentation/screens/member_screen.dart';
import 'package:bjp_app/features/our_discussion/presentation/controllers/discussion_controller.dart';
import 'package:bjp_app/features/profile/presentation/screens/profile_editing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/ui/app_icon_widget.dart';
import '../../../announcement/presentation/screens/create_announcement_screen.dart';
import '../../../events/domain/event_model.dart';
import '../../../events/presentation/controllers/event_controller.dart';
import '../../../our_discussion/domain/discussion_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _appBarTitle = 'হোম স্ক্রীন';
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(eventControllerProvider.notifier).fetchEvents(context);
      ref
          .read(discussionControllerProvider.notifier)
          .fetchAllDiscussions(context);

      // Check user role.
      final isAdmin = ref.read(authControllerProvider).isAdmin;
      if (!isAdmin) {
        ref
            .read(homeControllerProvider.notifier)
            .fetchRecentMemberAnnouncement();
      }
    });
  }

  List<Widget> _drawerOptions(
    bool isAdmin,
    AuthState authState, {
    required AsyncValue<List<EventModel>?> events,
    required AsyncValue<List<DiscussionModel>?> discussions,
  }) {
    return isAdmin
        ? [
          _buildDashboard(
            authState,
            eventListState: events,
            discussionListState: discussions,
          ),
          AnnouncementScreen(),
          CreateAnnouncementScreen(),
          MemberScreen(),
          EventSceduleScreen(),
        ]
        : [
          _buildDashboard(
            authState,
            eventListState: events,
            discussionListState: discussions,
          ),
          AnnouncementScreen(),
          OurConstitution(),
          PhotoAlbumScreen(),
          VideoAlbumScreen(),
          ProfileEditingScreen(),
          ChatPage(userInfo: '1', name: "Admin"),
        ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (ref.read(authControllerProvider).user?.user?.isAdmin == 1) {
        switch (index) {
          case 0:
            _appBarTitle = 'হোম স্ক্রীন';
            break;
          // announcements
          case 1:
            _appBarTitle = 'ঘোষণা';
            break;
          case 2:
            _appBarTitle = 'ঘোষণা তৈরি করুন';
            break;
          // create announcements
          case 3:
            _appBarTitle = 'সদস্য';
            break;
          case 4:
            _appBarTitle = 'অনুষ্ঠানের সময়';
            break;
        }
      } else {
        switch (index) {
          case 0:
            _appBarTitle = 'হোম স্ক্রীন';
            break;
          // announcements
          case 1:
            _appBarTitle = 'ঘোষণা';
            break;
          case 2:
            _appBarTitle = 'আমাদের সংবিধান';
            break;
          case 3:
            _appBarTitle = 'ছবি';
            break;
          case 4:
            _appBarTitle = 'ভিডিও';
            break;
          case 5:
            _appBarTitle = 'প্রোফাইল পরিবর্তন';
            break;
          case 6:
            _appBarTitle = 'চ্যাট';
            break;
        }
      }
    });
  }

  void _logoutUser() {
    ref.read(authControllerProvider.notifier).logout();
    Navigator.pop(context);
  }

  void _showAnnouncementDialog(RecentAnnouncement announcement) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          elevation: 10,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // << Changed from gradient to solid color
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.announcement, size: 48, color: AppColors.themeColor),
                SizedBox(height: 10),
                Text(
                  'Announcement',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Divider(color: Colors.white70, thickness: 1, height: 20),
                Text(
                  announcement.content ?? 'No content available',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 10),
                Text(
                  announcement.createdAt ?? 'No date available',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.themeColor,
                    backgroundColor: AppColors.themeColor, // Button text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  child: Text(
                    'Got it!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isAdmin = authState.isAdmin;
    final eventListState = ref.watch(eventControllerProvider);
    final discussionListState = ref.watch(discussionControllerProvider);

    if (!isAdmin) {
      // Listen for changes in the home controller state.
      ref.listen<AsyncValue<dynamic>>(homeControllerProvider, (previous, next) {
        next.whenData((announcement) {
          Future.delayed(Duration(milliseconds: 300), () {
            // Check if the announcement is not null and show the dialog.

            if (announcement != null) {
              _showAnnouncementDialog(announcement);
            }
          });
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          _appBarTitle,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed:
                () => showLogoutDialog(
                  context: context,
                  onPressed: () => _logoutUser(),
                ),
            child: Text(
              'Logout',
              style: TextStyle(color: AppColors.themeColor, fontSize: 14),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child:
            _drawerOptions(
              isAdmin,
              authState,
              events: eventListState,
              discussions: discussionListState,
            )[_selectedIndex],
      ),
      drawer: Drawer(
        width: 250,
        child: ListView(
          children: [
            DrawerHeader(child: AppLogoWidget(height: 10, width: 10)),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('হোম স্ক্রীন'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            // announcements
            if (isAdmin) ...[
              ExpansionTile(
                leading: Icon(Icons.announcement),
                title: Text('ঘোষণা'),
                children: [
                  ListTile(
                    leading: Icon(Icons.list),
                    title: Text('ঘোষণা তালিকা'),
                    selected: _selectedIndex == 1,
                    onTap: () {
                      _onItemTapped(1);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.add),
                    title: Text('ঘোষণা তৈরি করুন'),
                    selected: _selectedIndex == 2,
                    onTap: () {
                      _onItemTapped(2);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              ListTile(
                leading: Icon(Icons.person_4),
                title: Text('সদস্য'),
                selected: _selectedIndex == 3,
                onTap: () {
                  _onItemTapped(3);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.schedule_sharp),
                title: Text('অনুষ্ঠানের সময়'),
                selected: _selectedIndex == 4,
                onTap: () {
                  _onItemTapped(4);
                  Navigator.pop(context);
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.edit),
              //   title: Text('প্রোফাইল পরিবর্তন'),
              //   selected: _selectedIndex == 5,
              //   onTap: () {
              //     _onItemTapped(5);
              //     Navigator.pop(context);
              //   },
              // ),
            ] else ...[
              ListTile(
                leading: Icon(Icons.announcement),
                title: Text('ঘোষণা'),
                selected: _selectedIndex == 1,
                onTap: () {
                  _onItemTapped(1);
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: Icon(Icons.picture_as_pdf),
                title: Text('আমাদের সংবিধান'),
                selected: _selectedIndex == 2,
                onTap: () {
                  _onItemTapped(2);
                  Navigator.pop(context);
                },
              ),
              ExpansionTile(
                leading: Icon(Icons.perm_media),
                title: Text('মিডিয়া'),
                children: [
                  ListTile(
                    leading: Icon(Icons.picture_in_picture_sharp),
                    title: Text('ছবি'),
                    selected: _selectedIndex == 3,
                    onTap: () {
                      _onItemTapped(3);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.video_collection),
                    title: Text('ভিডিও'),
                    selected: _selectedIndex == 4,
                    onTap: () {
                      _onItemTapped(4);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('প্রোফাইল পরিবর্তন'),
                selected: _selectedIndex == 5,
                onTap: () {
                  _onItemTapped(5);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.chat),
                title: Text('চ্যাট'),
                selected: _selectedIndex == 6,
                onTap: () {
                  _onItemTapped(6);
                  Navigator.pop(context);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDashboard(
    AuthState authState, {
    required AsyncValue<List<EventModel>?> eventListState,
    required AsyncValue<List<DiscussionModel>?> discussionListState,
  }) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                color: Colors.cyan,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'পরিবর্তনে যোগ দিন',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ), // Adds space between the two text widgets
                      Text(
                        'আমাদের লক্ষ্য একটি এমন সমাজ গঠন করা যেখানে '
                        'প্রতিটি মানুষ সমান সুযোগ এবং মর্যাদা পাবে। আমরা বিশ্বাস করি যে '
                        'সুশাসন ও জনগণের সক্রিয় অংশগ্রহণ ছাড়া প্রকৃত উন্নয়ন সম্ভব নয়।',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 8,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'ন্যায়বিচার ও সমানাধিকারের ওপর ভিত্তি করে আমরা একটি ন্যায়সংগত '
                        'সমাজ বিনির্মাণে প্রতিশ্রুতিবদ্ধ, যেখানে প্রত্যেকে স্বাধীনভাবে নিজের মত প্রকাশ '
                        'করতে পারবে এবং সঠিক অধিকার ভোগ করতে সক্ষম হবে।',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //SizedBox(width:2),
              Image.asset(
                AssetsPath.imagetwo,

                height: 200,
                width: 160,
                fit: BoxFit.cover,
              ),

              // Add some space between the image and text
              // The text with background color
            ],
          ),

          SizedBox(height: 3),

          Stack(
            children: [
              Image.asset(
                AssetsPath.our_journey,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Positioned(
                left: 20,
                top: 10,
                //bottom: 20, // Adjust the position as needed
                child: Text(
                  'আমাদের পরিচিতি',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 40,
                //bottom: 20, // Adjust the position as needed
                child: Text(
                  '২০০১ সাল থেকে আজ পর্যন্ত, আমরা উন্নয়ন,\n'
                  ' জনকল্যাণ ও সাম্যের জন্য '
                  'নিবেদিতভাবে কাজ করে \n'
                  'চলেছি।'
                  'গণতন্ত্র, স্বাধীনতা, ন্যায়বিচার এবং সামাজিক ন্যায় \n'
                  'নিশ্চিত করার'
                  ' লক্ষ্যে আমাদের '
                  'এই অগ্রযাত্রা অবিচল \n'
                  'এবং অপ্রতিরোধ্য। '
                  'আমরা প্রতিটি নাগরিকের কল্যাণ \n'
                  ' ও সমানাধিকারের'
                  'জন্য কাজ করে যাচ্ছি, '
                  'যাতে সবার জন্য \n'
                  'একটি সমৃদ্ধ ও সুরক্ষিত ভবিষ্যৎ নিশ্চিত করা যায়।',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 8,
                  ),
                ),
              ),
              // SizedBox(
              //   height: 200,
              // ), // Adds space between TextField and ElevatedButton
              // ElevatedButton widget
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 118, 250, 0),
                child: ElevatedButton(
                  onPressed: () {
                    // Action when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OurIntroduction(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Button color
                    padding: EdgeInsets.zero, // Padding inside button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6), // Rounded corners
                    ),
                    minimumSize: Size(180, 20), // Minimum size of the button
                  ),
                  child: Text(
                    'আরো পড়ুন', // Text inside the button
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ), // Font size inside button
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Image.asset(
                AssetsPath.join_to_change,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Positioned(
                left: 170,
                top: 10,
                //bottom: 20, // Adjust the position as needed
                child: Text(
                  'উন্নয়ন ও সমৃদ্ধির পথে',
                  style: TextStyle(
                    color: Colors.cyan,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              Positioned(
                left: 170,
                top: 40,
                //bottom: 20, // Adjust the position as needed
                child: Text(
                  'গণতন্ত্র ও ন্যায়বিচার দ্বারা পরিচালিত \n '
                  'আমরা একটি সমৃদ্ধ নিরাপদ এবং সবার জন্য \n'
                  'সমান সুযোগসমৃদ্ধ বাংলাদেশের জন্য \n'
                  'নিরলস কাজ করে যাচ্ছি। আমাদের লক্ষ্য একটি এমন \n'
                  'বাংলাদেশ গঠন করা যেখানে প্রতিটি মানুষ তার \n'
                  ' অধিকার,মর্যাদাও সম্ভাবনা অর্জনের সুযোগ পাবে।\n'
                  ' সমৃদ্ধি, সাম্য এবং শান্তির ভিত্তিতে আমরা এমন \n'
                  'একটি সমাজ গড়ে তুলতে প্রতিশ্রুতিবদ্ধ, যা আগামী\n'
                  ' প্রজন্মের জন্য এক আদর্শ দৃষ্টান্ত হবে।',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 6,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(170, 118, 110, 0),
                child: ElevatedButton(
                  onPressed: () {
                    // Action when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeadershipTrainingScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themeColor, // Button color
                    padding: EdgeInsets.zero, // Padding inside button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6), // Rounded corners
                    ),
                    minimumSize: Size(180, 20), // Minimum size of the button
                  ),
                  child: Text(
                    'লিডারশিপ ট্রেনিং', // Text inside the button
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ), // Font size inside button
                  ),
                ),
              ),
            ],
          ),

          if (!authState.isAdmin) ...[
            eventListState.when(
              data: (events) {
                if (events == null || events.isEmpty) {
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
            SizedBox(height: 20),
            Text(
              'আপনাদের মতামত',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
            ),
            discussionListState.when(
              data: (discussions) {
                if (discussions == null || discussions.isEmpty) {
                  return Text('কোন আলোচনা পাওয়া যায়নি');
                }

                return SizedBox(
                  height: 350, // Adjust the height as needed
                  child: ListView.builder(
                    itemCount: discussions.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      final discussion = discussions[i];
                      return DiscussionCardWidget(discussion: discussion);
                    },
                  ),
                );
              },
              error: (err, st) {
                return Text('আলোচনা লোড করতে ব্যর্থ হয়েছে: $err');
              },
              loading: () => CustomLoader(),
            ),
          ],
          SizedBox(height: 5),
          Container(
            color: Colors.black,
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  'যোগাযোগের তথ্য',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'ঢাকা, বাংলাদেশ।',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.phone, color: Colors.blue),
                              SizedBox(width: 14),
                              Text(
                                '০২-XXX-XXX',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.email_outlined, color: Colors.blue),
                              SizedBox(width: 14),
                              Text(
                                'info@bjp.org',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: 85),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.video_collection_rounded,
                                color: Colors.blue,
                              ),
                              TextButton(
                                onPressed: () async {
                                  final url = Uri.parse(
                                    'https://www.youtube.com/@ArpPartho',
                                  );
                                  if (!await launchUrl(url)) {
                                    throw Exception('Could not launch $url');
                                  }
                                },
                                child: const Text(
                                  'ইউটিউব',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.facebook_outlined,
                                color: Colors.blue,
                              ), // Add spacing between icon and button
                              TextButton(
                                onPressed: () async {
                                  final url = Uri.parse(
                                    'https://www.facebook.com/Andaleeve.Rahman',
                                  );
                                  if (!await launchUrl(url)) {
                                    throw Exception('Could not launch $url');
                                  }
                                },
                                child: const Text(
                                  'ফেসবুক',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.account_box, color: Colors.blue),

                              TextButton(
                                onPressed: () async {
                                  final url = Uri.parse(
                                    'https://www.instagram.com/andaleeve_rahman_partho',
                                  );
                                  if (!await launchUrl(url)) {
                                    throw Exception('Could not launch $url');
                                  }
                                },
                                child: const Text(
                                  'ইনস্টাগ্রাম',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
