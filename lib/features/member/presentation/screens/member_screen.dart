import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  String? _selectedDivision;

  // Mapping for display purposes (Bangla name -> division ID)
  final Map<String, String> _divisionMap = {
    'ঢাকা': 'f47ea481-c504-4dc6-9bf5-350bbb200719',
    'চট্টগ্রাম': '2be20dd7-39d9-4cc3-bfaa-f13761210051',
    'বরিশাল': 'a0a290a7-4f6f-4e21-8550-58f45cc122d8',
    'খুলনা': 'cd7e4fe4-9e2d-452c-96ae-6632bd4069ed',
    'ময়মনসিংহ': '3ec0a8e8-7552-4a23-8774-07702414d2cb',
    'রাজশাহী': 'b65f7d01-b5f9-4bd6-a124-4b7bb6d13641',
    'রংপুর': '8d02cf87-d0db-4112-b961-dcaceb68c084',
    'সিলেট': '9d15504f-4f19-4403-b2c3-ed686797864c',
  };

  String _getDivisionName(String divisionId) {
    return _divisionMap.keys.firstWhere(
      (key) => _divisionMap[key] == divisionId,
      orElse: () => 'Unknown',
    );
  }

  // Function to copy the mobile number to clipboard and show a snackbar.
  void _copyToClipboard(String mobile) async {
    await Clipboard.setData(ClipboardData(text: mobile));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("মোবাইল নম্বর কপি করা হয়েছে")));
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              value: _selectedDivision,
              decoration: InputDecoration(
                labelText: 'বিভাগ',
                border: OutlineInputBorder(),
              ),
              items:
                  _divisionMap.entries.map((entry) {
                    return DropdownMenuItem(
                      value: entry.value, // Store the division ID
                      child: Text(entry.key), // Display Bangla division name
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDivision = value;
                });
              },
            ),
            SizedBox(height: 20),

            // Search Button
            ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus(); // Dismiss keyboard
                ref
                    .read(memberControllerProvider.notifier)
                    .searchMembers(
                      context,
                      userId: _userIdController.text,
                      mobile: _mobileController.text,
                      name: _nameController.text,
                      division: _selectedDivision,
                    );
              },
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
                              subTitle: Text(
                                "বিভাগ: ${_getDivisionName(member.divisionId!)}",
                                style: TextStyle(fontSize: 14),
                              ),
                              trailing: SizedBox(
                                width: 120,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed:
                                          () => _copyToClipboard(
                                            member.phoneNumber!,
                                          ),
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
    );
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
              Text("মোবাইল: ${member.phoneNumber}"),
              SizedBox(height: 10),
              Text("বিভাগ: ${_getDivisionName(member.divisionId!)}"),
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
}
