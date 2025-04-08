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

  void _copyToClipboard(String mobile) async {
    await Clipboard.setData(ClipboardData(text: mobile));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('মোবাইল নম্বর কপি করা হয়েছে')),
    );
  }

  Future<void> _openDialer(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw Exception('Could not launch $url');
    }
  }

  void _findMember() {
    FocusScope.of(context).unfocus();
    final userId = _userIdController.text.trim().isEmpty ? null : _userIdController.text.trim();
    final mobile = _mobileController.text.trim().isEmpty ? null : _mobileController.text.trim();
    final name = _nameController.text.trim().isEmpty ? null : _nameController.text.trim();

    ref.read(memberControllerProvider.notifier).searchMembers(
      context,
      userId: userId,
      mobile: mobile,
      name: name,
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
    final List<District> districtsForSelectedDivision = _selectedDivisionId != null
        ? (divisionDistrictsMap[_selectedDivisionId] ?? [])
        : [];
    final List<SubDistrict> subDistrictsForSelectedDistrict = _selectedDistrictId != null
        ? (districtSubdistrictMap[_selectedDistrictId] ?? [])
        : [];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              children: [
                TextField(
                  controller: _userIdController,
                  decoration: InputDecoration(
                    labelText: 'ব্যবহারকারী আইডি',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _mobileController,
                  decoration: InputDecoration(
                    labelText: 'মোবাইল নম্বার',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'নাম',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedDivisionId,
                  decoration: InputDecoration(
                    labelText: 'বিভাগ',
                    border: OutlineInputBorder(),
                  ),
                  items: divisionMap.entries.map((entry) {
                    return DropdownMenuItem(
                      value: entry.value,
                      child: Text(entry.key),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDivisionId = value;
                      _selectedDistrictId = null;
                      _selectedUpazilaId = null;
                    });
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedDistrictId,
                  decoration: InputDecoration(
                    labelText: 'জেলা',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _selectedDivisionId == null
                      ? null
                      : (value) {
                    setState(() {
                      _selectedDistrictId = value;
                      _selectedUpazilaId = null;
                    });
                  },
                  items: districtsForSelectedDivision.map((district) {
                    return DropdownMenuItem(
                      value: district.id,
                      child: Text(district.name),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedUpazilaId,
                  decoration: InputDecoration(
                    labelText: 'উপজেলা',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _selectedDistrictId == null
                      ? null
                      : (value) {
                    setState(() {
                      _selectedUpazilaId = value;
                    });
                  },
                  items: subDistrictsForSelectedDistrict.map((subdistrict) {
                    return DropdownMenuItem(
                      value: subdistrict.id,
                      child: Text(subdistrict.name),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _findMember,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B1B0),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: const Text("অনুসন্ধান করুন", style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 20),
                const Text(
                  "তালিকা",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                membersListState.when(
                  data: (members) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.4,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: members.length,
                        itemBuilder: (context, index) {
                          final member = members[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: CustomListTile(
                              height: 130,
                              title: Text(
                                member.name!,
                                style: const TextStyle(fontSize: 16),
                              ),
                              subTitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("মোবাইল: ${member.phoneNumber}"),
                                  Text("বিভাগ: ${_getDivisionName(member.divisionId!)}"),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatPage(
                                            userInfo: member.userId,
                                            name: member.name,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF00B1B0),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                    ),
                                    child: const Text("চ্যাট", style: TextStyle(fontSize: 12)),
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
                                        backgroundColor: const Color(0xFF00B1B0),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                      ),
                                      child: const Text("নম্বর কপি করুন", style: TextStyle(fontSize: 12)),
                                    ),
                                    const SizedBox(height: 4),
                                    ElevatedButton(
                                      onPressed: () => _showDetailsDialog(member),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF00B1B0),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                      ),
                                      child: const Text("বিস্তারিত", style: TextStyle(fontSize: 12)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  error: (err, st) => Center(
                    child: Text("তথ্য পাওয়া যায়নি", style: TextStyle(fontSize: 16)),
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}