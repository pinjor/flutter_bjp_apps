import 'package:bjp_app/core/constants/route_path.dart';
import 'package:bjp_app/features/auth/domain/register_input_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/auth_controller.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<RegisterScreen> {
  String? _selectedDivision;
  final TextEditingController _nameTEController = TextEditingController();

  final TextEditingController _nidTEController = TextEditingController();

  final TextEditingController _emailTEController = TextEditingController();

  final TextEditingController _dobTEController = TextEditingController();
  final TextEditingController _phoneNumberTEController =
      TextEditingController();

  final TextEditingController _districtTEController = TextEditingController();
  final TextEditingController _subDistrictTEController =
      TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _registerUser() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      final name = _nameTEController.text.trim();
      final nid = _nidTEController.text.trim();
      final email = _emailTEController.text.trim();
      final dob = _dobTEController.text.trim();
      final phoneNumber = _phoneNumberTEController.text.trim();
      final district = _districtTEController.text.trim();
      final subDistrict = _subDistrictTEController.text.trim();
      final password = _passwordTEController.text.trim();
      final confirmPassword = _confirmPasswordTEController.text.trim();

      final newUser = RegisterInputModel(
        name: name,
        nid: nid,
        email: email,
        dob: dob,
        phone: phoneNumber,
        division: _selectedDivision!,
        district: district,
        upazila: subDistrict,
        password: password,
        confirmPassword: confirmPassword,
      );

      // ref.read(authControllerProvider.notifier).register(data: newUser);

      // Navigation handled by GoRouter redirect method automatically
    }
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1700),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dobTEController.text = picked.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 50),
                Text(
                  'মেম্বার রেজিস্ট্রেশন',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 50.0),
                TextFormField(
                  controller: _nameTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('নাম'),
                    hintText: 'এখানে লিখুন',
                  ),
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'নাম দিন';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _nidTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('জাতীয় পরিচয়পত্র (NID) নম্বর'),
                    hintText: 'এখানে লিখুন',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'জাতীয় পরিচয়পত্র নম্বর দিন';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _emailTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('ইমেইল'),
                    hintText: 'এখানে লিখুন',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'ইমেইল দিন';
                    }
                    return null;
                  },
                  onChanged: (textValue) {
                    //inputOnChange("phone_number", textValue);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _dobTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('জন্ম তারিখ'),
                    prefixIcon: Icon(Icons.calendar_today),
                    hintText: 'এখানে লিখুন',
                  ),
                  readOnly: true,
                  keyboardType: TextInputType.datetime,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'জন্ম তারিখ দিন';
                    }
                    return null;
                  },
                  onTap: () {
                    _selectDate();
                  },

                  onChanged: (textValue) {
                    //inputOnChange("phone_number", textValue);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _phoneNumberTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('ফোন নম্বর'),
                    hintText: 'এখানে লিখুন',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'ফোন নম্বর দিন';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20.0),
                DropdownButtonFormField<String>(
                  value: _selectedDivision,
                  decoration: InputDecoration(
                    hintText: 'বিভাগ',
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
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _districtTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('জেলা'),
                    hintText: 'এখানে লিখুন',
                  ),
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'জেলা দিন';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _subDistrictTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('উপজেলা'),
                    hintText: 'এখানে লিখুন',
                  ),
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'উপজেলা দিন';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _passwordTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('পাসওয়ার্ড'),
                    hintText: 'এখানে লিখুন',
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (textValue) {
                    //("password", textValue);
                  },
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  controller: _confirmPasswordTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('পাসওয়ার্ড নিশ্চিত করুন'),
                    hintText: 'এখানে লিখুন',
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (textValue) {
                    //("password", textValue);
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    //formOnSubmit();
                    Navigator.pushReplacementNamed(
                      context,
                      RoutePath.loginPath, //'/program_timeline'
                    );
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
