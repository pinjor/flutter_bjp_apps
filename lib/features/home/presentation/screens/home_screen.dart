import 'package:bjp_app/core/utils/utils.dart';
import 'package:bjp_app/features/auth/domain/auth_state.dart';
import 'package:bjp_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:bjp_app/features/member/presentation/screens/member_screen.dart';
import 'package:bjp_app/features/profile/presentation/screens/profile_editing_screen.dart';
import 'package:bjp_app/features/events/presentation/screens/event_scedule_screen.dart';
import 'package:bjp_app/features/events/presentation/widgets/time_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/ui/app_icon_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final String _url = "https://rnd.egeneration.co/bjp/public/index.php";

  String _appBarTitle = 'ড্যাশবোর্ড';

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  int _selectedIndex = 0;

  List<Widget> _drawerOptions(bool isAdmin, AuthState authState) {
    return isAdmin
        ? [
          _buildDashboard(authState),
          MemberScreen(),
          ProgramSceduleScreen(),
          ProfileEditingScreen(),
        ]
        : [_buildDashboard(authState), ProfileEditingScreen()];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (ref.read(authControllerProvider).user?.user?.isAdmin == 1) {
        // Admin mapping:
        switch (index) {
          case 0:
            _appBarTitle = 'ড্যাশবোর্ড';
            break;
          case 1:
            _appBarTitle = 'সদস্য';
            break;
          case 2:
            _appBarTitle = 'অনুষ্ঠানের সময়';
            break;
          case 3:
            _appBarTitle = 'প্রোফাইল পরিবর্তন';
            break;
        }
      } else {
        // Non-admin mapping:
        switch (index) {
          case 0:
            _appBarTitle = 'ড্যাশবোর্ড';
            break;
          case 1:
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
        child: _drawerOptions(isAdmin, authState)[_selectedIndex],
      ), // Call function properly
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
            if (isAdmin) ...[
              ListTile(
                leading: Icon(Icons.person_4),
                title: Text('সদস্য'),
                selected: _selectedIndex == 1,
                onTap: () {
                  _onItemTapped(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.schedule_sharp),
                title: Text('অনুষ্ঠানের সময়'),
                selected: _selectedIndex == 2,
                onTap: () {
                  _onItemTapped(2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('প্রোফাইল পরিবর্তন'),
                selected: _selectedIndex == 3,
                onTap: () {
                  _onItemTapped(3);
                  Navigator.pop(context);
                },
              ),
            ] else ...[
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('প্রোফাইল পরিবর্তন'),
                selected: _selectedIndex == 1,
                onTap: () {
                  _onItemTapped(1);

                  Navigator.pop(context);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDashboard(AuthState authState) {
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
                // _launchUrl(_url); // Call function properly
              },
              child: Text('ড্যাশবোর্ড', style: TextStyle(fontSize: 20)),
            ),
          ),
          if (!authState.isAdmin) ...[TimeCard(), TimeCard()],
        ],
      ),
    );
  }
}
