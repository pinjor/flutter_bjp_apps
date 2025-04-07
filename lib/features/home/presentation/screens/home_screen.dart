import 'package:bjp_app/core/ui/custom_loader.dart';
import 'package:bjp_app/core/utils/utils.dart';
import 'package:bjp_app/features/announcement/presentation/screens/announcement_screen.dart';
import 'package:bjp_app/features/auth/domain/auth_state.dart';
import 'package:bjp_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:bjp_app/features/chat/presentation/screens/chat_screen.dart';
import 'package:bjp_app/features/member/presentation/screens/member_screen.dart';
import 'package:bjp_app/features/profile/presentation/screens/profile_editing_screen.dart';
import 'package:bjp_app/features/events/presentation/screens/event_scedule_screen.dart';
import 'package:bjp_app/features/events/presentation/widgets/event_time_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          ProfileEditingScreen(),

        ]
        : [
          _buildDashboard(authState, eventListState: events),
          AnnouncementScreen(),
          ProfileEditingScreen(),
          ChatPage(userInfo: '1', name: "Admin")
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
          case 5:
            _appBarTitle = 'প্রোফাইল পরিবর্তন';
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
          case 2:
            _appBarTitle = 'প্রোফাইল পরিবর্তন';
            break;
          case 3:
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

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isAdmin = authState.isAdmin;
    final eventListState = ref.watch(eventControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: Text(
          _appBarTitle,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed:
                () => showLogoutDialog(
                  context: context,
                  onPressed: () => _logoutUser(),
                ),
            icon: Icon(Icons.logout),
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
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('প্রোফাইল পরিবর্তন'),
                selected: _selectedIndex == 2,
                onTap: () {
                  _onItemTapped(2);
                  Navigator.pop(context);
                },
              ), ListTile(
                leading: Icon(Icons.chat),
                title: Text('চ্যাট'),
                selected: _selectedIndex == 3,
                onTap: () {
                  _onItemTapped(3);
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
          Image.asset(
            AssetsPath.manWithMoto,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                // _launchUrl(_url); // Uncomment if needed
              },
              child: Text('Website', style: TextStyle(fontSize: 20)),
            ),
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
