import 'package:bjp_app/features/chat/presentation/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/database/district.dart';
import '../../../../core/database/district_sub_district_map.dart';
import '../../../../core/database/division_district_map_data.dart';
import '../../../../core/database/sub_district.dart';
import '../../../../core/ui/customlisttile.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/member_model.dart';
import '../controllers/member_controller.dart';

class MemberScreen extends ConsumerStatefulWidget {
  const MemberScreen({super.key});

  @override
  ConsumerState<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends ConsumerState<MemberScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  // Dropdown value for Division (stores division ID)

  String? _selectedDivisionId;
  String? _selectedDistrictId;
  String? _selectedUpazilaId;

  String _getDivisionName(String? divisionId) {
    return divisionMap.keys.firstWhere(
      (key) => divisionMap[key] == divisionId,
      orElse: () => 'অজানা',
    );
  }

  String _getDistrictName(String? districtId) {
    return divisionDistrictsMap.entries
        .map((entry) => entry.value)
        .expand((element) => element)
        .firstWhere(
          (district) => district.id == districtId,
          orElse: () => District(id: '0', name: 'অজানা'),
        )
        .name;
  }

  String _getSubdistrictName(String? subdistrictId) {
    if (subdistrictId == null) return 'অজানা';
    for (var entry in districtSubdistrictMap.entries) {
      for (var subdistrict in entry.value) {
        if (subdistrict.id == subdistrictId) {
          return subdistrict.name;
        }
      }
    }
    return 'অজানা';
  }

  void _showDetailsDialog(MemberModel member) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(member.name!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ব্যবহারকারী আইডি: ${member.userId}"),
              Text("ইমেইল: ${member.email}"),
              Text("জেলা: ${_getDistrictName(member.districtId!)}"),
              Text("উপজেলা: ${_getSubdistrictName(member.upazilaId)}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("ঠিক আছে"),
            ),
          ],
        );
      },
    );
  }

  // Function to copy the mobile number to clipboard and show a snackbar.
  void _copyToClipboard(String mobile) async {
    await Clipboard.setData(ClipboardData(text: mobile));
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('মোবাইল নম্বর কপি করা হয়েছে')));
  }

  // Function to launch the phone dialer with the given mobile number.
  Future<void> _openDialer(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw Exception('Could not launch $url');
    }
  }

  void _findMember() {
    FocusScope.of(context).unfocus(); // Dismisses keyboard
    ref
        .read(memberControllerProvider.notifier)
        .searchMembers(
          context,
          userId: _userIdController.text.trim(),
          mobile: _mobileController.text.trim(),
          name: _nameController.text.trim(),
          divisionId: _selectedDivisionId,
          districtId: _selectedDistrictId,
          subdistrictId: _selectedUpazilaId,
        );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(memberControllerProvider.notifier).fetchMembers(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final membersListState = ref.watch(memberControllerProvider);

    final List<District> districtsForSelectedDivision =
        _selectedDivisionId != null
            ? (divisionDistrictsMap[_selectedDivisionId] ?? [])
            : [];
    final List<SubDistrict> subDistrictsForSelectedDistrict =
        _selectedDistrictId != null
            ? (districtSubdistrictMap[_selectedDistrictId] ?? [])
            : [];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
          child: Column(
            children: [
              SizedBox(height: 20),
          
              // User ID TextField
              TextField(
                controller: _userIdController,
                decoration: InputDecoration(
                  labelText: 'ব্যবহারকারী আইডি',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
          
              // Mobile Number TextField
              TextField(
                controller: _mobileController,
                decoration: InputDecoration(
                  labelText: 'মোবাইল নম্বার',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10),
          
              // Name TextField
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'নাম',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
          
              // Division Dropdown
              DropdownButtonFormField<String>(
                value: _selectedDivisionId,
                decoration: InputDecoration(
                  labelText: 'বিভাগ',
                  border: OutlineInputBorder(),
                ),
                items:
                    divisionMap.entries.map((entry) {
                      return DropdownMenuItem(
                        value: entry.value, // Store the division ID
                        child: Text(entry.key), // Display Bangla division name
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDivisionId = value;
                  });
                },
              ),
              SizedBox(height: 20),
          
              DropdownButtonFormField<String>(
                value: _selectedDistrictId,
                decoration: InputDecoration(
                  hintText: 'জেলা*',
                  labelText: 'জেলা',
                  border: OutlineInputBorder(),
                ),
                // If no division is selected, disable the dropdown.
                onChanged:
                    _selectedDivisionId == null
                        ? null
                        : (value) {
                          setState(() {
                            _selectedDistrictId = value;
                          });
                        },
                items:
                    districtsForSelectedDivision.map((district) {
                      return DropdownMenuItem(
                        value: district.id, // district ID is stored
                        child: Text(district.name), // district name is displayed
                      );
                    }).toList(),
                validator: (value) {
                  if (_selectedDivisionId == null) {
                    return 'প্রথমে বিভাগ নির্বাচন করুন';
                  }
                  if (value == null) {
                    return 'জেলা দিন';
                  }
                  return null;
                },
              ),
          
              SizedBox(height: 20.0),
              DropdownButtonFormField<String>(
                value: _selectedUpazilaId,
                decoration: InputDecoration(
                  hintText: 'উপজেলা*',
                  labelText: 'উপজেলা',
                  border: OutlineInputBorder(),
                ),
                // If no division is selected, disable the dropdown.
                onChanged:
                    _selectedDivisionId == null
                        ? null
                        : (value) {
                          setState(() {
                            _selectedUpazilaId = value;
                          });
                        },
                items:
                    subDistrictsForSelectedDistrict.map((district) {
                      return DropdownMenuItem(
                        value: district.id, // district ID is stored
                        child: Text(district.name), // district name is displayed
                      );
                    }).toList(),
                validator: (value) {
                  if (_selectedDistrictId == null) {
                    return 'প্রথমে জেলা নির্বাচন করুন';
                  }
                  if (value == null) {
                    return 'উপজেলা দিন';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
          
              // Search Button
              ElevatedButton(
                onPressed: _findMember,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00B1B0),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text("অনুসন্ধান করুন", style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 20),
          
              // Results Table Header
              Text(
                "তালিকা",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
          
              // List of Results
              Expanded(
                child: membersListState.when(
                  data: (members) {
                    lgr.i('member length: ${members.length}');
                    return members.isEmpty
                        ? Center(
                          child: Text(
                            "কোন সদস্য পাওয়া যায়নি",
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                        : ListView.builder(
                          itemCount: members.length,
                          itemBuilder: (context, index) {
                            final member = members[index];
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: CustomListTile(
                                height: 130,
                                title: Text(
                                  member.name!,
                                  style: TextStyle(fontSize: 16),
                                ),
                                subTitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // phone number
                                    Text(
                                      "মোবাইল: ${member.phoneNumber}",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    // division
                                    Text(
                                      "বিভাগ: ${_getDivisionName(member.divisionId!)}",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.chat_rounded,color: Colors.white,),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>  ChatPage(userInfo: member.userId, name: member.name,),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF00B1B0),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                      ),
                                      // child: Text(
                                      //   "চ্যাট",
                                      //   style: TextStyle(fontSize: 12),
                                      // ),
                                    ),
                                  ],
                                ),
                                trailing: SizedBox(
                                  width: 120,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          _copyToClipboard(member.phoneNumber!);
                          
                                          _openDialer(member.phoneNumber!);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF00B1B0),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                        ),
                                        child: Text(
                                          "নম্বর কপি করুন",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      ElevatedButton(
                                        onPressed: () {
                                          _showDetailsDialog(member);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF00B1B0),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                        ),
                                        child: Text(
                                          "বিস্তারিত",
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
                  error: (err, st) {
                    return Center(
                      child: Text(
                        "তথ্য পাওয়া যায়নি",
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  },
                  loading: () {
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
