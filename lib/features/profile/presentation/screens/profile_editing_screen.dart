import 'package:bjp_app/core/database/sub_district.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/district_sub_district_map.dart';
import '../../../../core/database/division_district_map_data.dart';
import '../../../../core/database/district.dart';
import '../../../../core/utils/utils.dart';
import '../controllers/profile_controller.dart';

class ProfileEditingScreen extends ConsumerStatefulWidget {
  const ProfileEditingScreen({super.key});

  @override
  ConsumerState<ProfileEditingScreen> createState() =>
      _ProfileEditingScreenState();
}

class _ProfileEditingScreenState extends ConsumerState<ProfileEditingScreen> {
  String? _selectedDivisionId;
  String? _selectedDistrictId;
  String? _selectedUpazilaId;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();

    super.dispose();
  }

  void _updateUserProfile() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final name = _nameController.text.trim();

    // Update user profile with the new name
    lgr.i('Updating profile with name: $name');
    ref
        .read(profileControllerProvider.notifier)
        .updateProfile(userName: name, context: context);
  }

  // var selected_value;
  @override
  Widget build(BuildContext context) {
    final List<District> districtsForSelectedDivision =
        _selectedDivisionId != null
            ? (divisionDistrictsMap[_selectedDivisionId] ?? [])
            : [];

    final List<SubDistrict> subDistrictsForSelectedDistrict =
        _selectedDistrictId != null
            ? (districtSubdistrictMap[_selectedDistrictId] ?? [])
            : [];
    return Scaffold(
      //appBar: AppBar(title: Text('প্রোফাইল পরিবর্তন'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('নাম'),
                    hintText: 'এখানে লিখুন',
                  ),
                  keyboardType: TextInputType.text,
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'নাম দিন';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('ইমেইল'),
                    hintText: 'এখানে লিখুন',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ইমেইল দিন';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('মোবাইল নম্বর'),
                    hintText: 'এখানে লিখুন',
                  ),
                  keyboardType: TextInputType.number,
                  controller: _mobileController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'মোবাইল নম্বর দিন';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField<String>(
                  value: _selectedDivisionId,
                  decoration: InputDecoration(
                    hintText: 'বিভাগ*',
                    labelText: 'বিভাগ',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      divisionMap.entries.map((entry) {
                        return DropdownMenuItem(
                          value: entry.value, // Store the division ID
                          child: Text(
                            entry.key,
                          ), // Display Bangla division name
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDivisionId = value;
                      // Reset the district selection when division changes.
                      _selectedDistrictId = null;
                    });
                  },
                  validator: (String? value) {
                    if (value == null) {
                      return 'বিভাগ দিন';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),

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
                          child: Text(
                            district.name,
                          ), // district name is displayed
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
                          child: Text(
                            district.name,
                          ), // district name is displayed
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
                SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    _updateUserProfile();
                  },
                  child: Text(
                    'সংরক্ষণ করুন',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
