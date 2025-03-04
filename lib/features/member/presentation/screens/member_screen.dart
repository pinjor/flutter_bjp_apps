import 'package:bjp_app/core/ui/customlisttile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class MemberScreen extends StatefulWidget {
  const MemberScreen({super.key});


  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  // Dropdown value for Division
  String? _selectedDivision;

  // Data for members list
  List<Map<String, String>> data = [
    {
      "userId": "1001",
      "name": "আব্দুল জলিল",
      "mobile": "0123456789",
      "division": "ঢাকা",
    },
    {
      "userId": "1002",
      "name": "মাহমুদুল হাসান",
      "mobile": "0987654321",
      "division": "চট্টগ্রাম",
    },
    {
      "userId": "1003",
      "name": "রবিউল ইসলাম",
      "mobile": "0123987654",
      "division": "রাজশাহী",
    },
    {
      "userId": "1004",
      "name": "আফরিন হক",
      "mobile": "0125478963",
      "division": "ঢাকা",
    },
    {
      "userId": "1005",
      "name": "মো. হাবিবুর রহমান",
      "mobile": "0986541230",
      "division": "বরিশাল",
    },
  ];

  // Filtered data for search results
  List<Map<String, String>> filteredData = [];

  @override
  void initState() {
    super.initState();
    filteredData = List.from(data); // Initialize filtered data with all data
  }

  // Function for search action
  void _searchData() {
    setState(() {
      filteredData =
          data.where((member) {
            final userIdMatch =
                _userIdController.text.isEmpty ||
                member["userId"]!.toLowerCase().contains(
                  _userIdController.text.toLowerCase(),
                );
            final mobileMatch =
                _mobileController.text.isEmpty ||
                member["mobile"]!.contains(_mobileController.text);
            final nameMatch =
                _nameController.text.isEmpty ||
                member["name"]!.toLowerCase().contains(
                  _nameController.text.toLowerCase(),
                );
            final divisionMatch =
                _selectedDivision == null ||
                member["division"] == _selectedDivision;
            return userIdMatch && mobileMatch && nameMatch && divisionMatch;
          }).toList();
    });
  }

  // Function to copy the mobile number to clipboard and open dialer
  void _copyToClipboard(String mobile) async {
    // Copy the number to the clipboard
    await Clipboard.setData(ClipboardData(text: mobile))
        .then((_) async {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("মোবাইল নম্বর কপি হয়েছে!")));

          // Open the phone dialer with the copied number
          final Uri phoneUri = Uri(scheme: 'tel', path: mobile);
          if (await canLaunchUrl(phoneUri)) {
            await launchUrl(phoneUri);
          } else {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("ডায়ালার খুলতে ব্যর্থ!")));
          }
        })
        .catchError((error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("কপি করতে ব্যর্থ: $error")));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('সদস্য'),
      //   centerTitle: true,
      //   //backgroundColor: Color(0xFF00B1B0),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Section
            // Text("খুঁজুন",
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                  ['ঢাকা', 'চট্টগ্রাম', 'রাজশাহী', 'বরিশাল']
                      .map(
                        (division) => DropdownMenuItem(
                          value: division,
                          child: Text(division),
                        ),
                      )
                      .toList(),
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
                _searchData(); // Perform search
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00B1B0),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text("অনুসন্ধান করুন", style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 20),

            // Results Table
            Text(
              "তালিকা",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Table/List of Results
            Expanded(
              child:
                  filteredData.isEmpty
                      ? Center(child: Text("কোন ফলাফল পাওয়া যায়নি"))
                      : ListView.builder(
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: CustomListTile(
                              height:
                                  130, // Set custom height for the list tile
                              title: Text(
                                filteredData[index]['name']!,
                                style: TextStyle(fontSize: 16),
                              ),
                              subTitle: Text(
                                "বিভাগ: ${filteredData[index]['division']}",
                                style: TextStyle(fontSize: 14),
                              ),
                              trailing: SizedBox(
                                width:
                                    120, // Constrain the width of the trailing widget
                                child: Column(
                                  mainAxisSize:
                                      MainAxisSize.min, // Use minimum space
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed:
                                          () => _copyToClipboard(
                                            filteredData[index]['mobile']!,
                                          ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF00B1B0),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ), // Reduce padding
                                      ),
                                      child: Text(
                                        "নম্বর কপি করুন",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ), // Reduce spacing between buttons
                                    ElevatedButton(
                                      onPressed: () {
                                        _showDetailsDialog(filteredData[index]);
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
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetailsDialog(Map<String, String> member) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(member['name']!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("মোবাইল: ${member['mobile']}"),
              SizedBox(height: 10),
              Text("বিভাগ: ${member['division']}"),
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
