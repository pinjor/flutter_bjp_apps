import 'dart:io';

import 'package:bjp_app/config/app_colors.dart';
import 'package:bjp_app/core/ui/custom_loader.dart';
import 'package:bjp_app/core/utils/utils.dart';
import 'package:bjp_app/features/announcement/presentation/screens/announcement_screen.dart';
import 'package:bjp_app/features/auth/domain/auth_state.dart';
import 'package:bjp_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:bjp_app/features/events/presentation/screens/event_scedule_screen.dart';
import 'package:bjp_app/features/events/presentation/widgets/event_time_card.dart';
import 'package:bjp_app/features/home/presentation/screens/our_introduction.dart';
import 'package:bjp_app/features/leadership_training/presentation/screens/leadership_training_screen.dart';
import 'package:bjp_app/features/member/presentation/screens/member_screen.dart';
import 'package:bjp_app/features/profile/presentation/screens/profile_editing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/ui/app_icon_widget.dart';
import '../../../announcement/presentation/screens/create_announcement_screen.dart';
import '../../../events/domain/event_model.dart';
import '../../../events/presentation/controllers/event_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _appBarTitle = 'ড্যাশবোর্ড';
  int _selectedIndex = 0;

  // This is the function to open the PDF
  // Future<void> openPDF(BuildContext context) async {
  //   try {
  //     final byteData = await rootBundle.load('assets/images/our_constitution.pdf');
  //     final tempDir = await getTemporaryDirectory();
  //     final file = File('${tempDir.path}/our_constitution.pdf');
  //     await file.writeAsBytes(byteData.buffer.asUint8List());
  //
  //     // Print path for verification
  //     print("PDF Path: ${file.path}");
  //
  //     if (!mounted) return;
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => PDFViewerPage(path: file.path),
  //       ),
  //     );
  //   } catch (e) {
  //     if (!mounted) return;
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to open PDF: $e')),
  //     );
  //   }
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(eventControllerProvider.notifier).fetchEvents(context);
    });
  }

  List<Widget> _drawerOptions(
    bool isAdmin,
    AuthState authState, {
    required AsyncValue<List<EventModel>?> events,
  }) {
    return isAdmin
        ? [
          _buildDashboard(authState, eventListState: events),
          AnnouncementScreen(),
          CreateAnnouncementScreen(),
          MemberScreen(),
          EventSceduleScreen(),
        ]
        : [
          _buildDashboard(authState, eventListState: events),
          AnnouncementScreen(),
      //PDFViewerPage(path: pdfPath),
          ProfileEditingScreen(),
        ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (ref.read(authControllerProvider).user?.user?.isAdmin == 1) {
        switch (index) {
          case 0:
            _appBarTitle = 'ড্যাশবোর্ড';
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
            _appBarTitle = 'ড্যাশবোর্ড';
            break;
          // announcements
          case 1:
            _appBarTitle = 'ঘোষণা';
            break;
          // case 3:
          //   _appBarTitle = 'আমাদের সংবিধান';
          //   break;
          case 2:
            _appBarTitle = 'প্রোফাইল পরিবর্তন';
            break;
        }
      }
    });
  }

  void _logoutUser() {
    ref.read(authControllerProvider.notifier).logout();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isAdmin = authState.isAdmin;
    final eventListState = ref.watch(eventControllerProvider);

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
            child: Text('Logout'),
          ),
        ],
      ),
      body: SafeArea(
        child:
            _drawerOptions(
              isAdmin,
              authState,
              events: eventListState,
            )[_selectedIndex],
      ),
      drawer: Drawer(
        width: 250,
        child: ListView(
          children: [
            DrawerHeader(child: AppLogoWidget(height: 10, width: 10)),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('ড্যাশবোর্ড'),
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
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('প্রোফাইল পরিবর্তন'),
                selected: _selectedIndex == 5,
                onTap: () {
                  _onItemTapped(5);
                  Navigator.pop(context);
                },
              ),
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
              // ListTile(
              //   leading: Icon(Icons.edit),
              //   title: Text('আমাদের সংবিধান'),
              //   selected: _selectedIndex == 3,
              //   onTap: () async {
              //     await openPDF(context);
              //     Navigator.pop(context); // Close drawer after opening PDF
              //   },
              // ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('প্রোফাইল পরিবর্তন'),
                selected: _selectedIndex == 2,
                onTap: () {
                  _onItemTapped(2);
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
  }) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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

          SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(),
          //     onPressed: () {
          //       // _launchUrl(_url); // Uncomment if needed
          //     },
          //     child: Text('Website', style: TextStyle(fontSize: 20)),
          //   ),
          // ),
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
                AssetsPath.Join_to_change,
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
              // SizedBox(
              //   height: 200,
              // ), // Adds space between TextField and ElevatedButton
              // ElevatedButton widget
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
                      color: Colors.black,
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
          ],
        ],
      ),
    );
  }
}

// class PDFViewerPage extends StatelessWidget {
//   final String path;
//
//   const PDFViewerPage({super.key, required this.path});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Our Constitution")),
//       body: PDFView(
//         filePath: path,
//         enableSwipe: true, // Allow swipe navigation
//         swipeHorizontal: false, // Vertical swipe only
//         autoSpacing: true, // Adjust spacing to fit the screen
//         pageFling: true, // Enable fast scrolling
//         onError: (error) {
//           print("PDF Error: $error");
//         },
//       ),
//     );
//   }
// }