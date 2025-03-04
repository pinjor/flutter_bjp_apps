import 'package:bjp_app/features/member/presentation/screens/member_screen.dart';
import 'package:bjp_app/features/profile/presentation/screens/profile_editing_screen.dart';
import 'package:bjp_app/features/programs/presentation/screens/program_scedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/constants/route_path.dart';
import '../../../../core/ui/app_icon_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _url = "https://rnd.egeneration.co/bjp/public/index.php";

  String _appBarTitle = 'ড্যাশবোর্ড';

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  int _selectedIndex = 0;

  // Convert _widgetOptions to a method
  List<Widget> _widgetOptions() {
    return <Widget>[
      Column(
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
                _launchUrl(_url); // Call function properly
              },
              child: Text('ড্যাশবোর্ড', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
      MemberScreen(),
      ProgramSceduleScreen(),
      ProfileEditingScreen(),

    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions()[_selectedIndex], // Call function properly
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
              leading: Icon(Icons.edit),
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

          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: Text(
          _appBarTitle,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutePath.loginPath);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
