import 'package:flutter/material.dart';

import '../../../../core/ui/app_icon_widget.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _shippingAddressTEController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              AppLogoWidget(width: 100, height: 100),
              SizedBox(height: 20),
              Text(
                'Complete Profile',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Get started with us with your details',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
              ),
              SizedBox(height: 24.0),
              _buildForm(),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                child: Text('Complete', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _firstNameTEController,
            decoration: InputDecoration(
              hintText: 'এখানে লিখুন',
              labelText: 'নাম',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter valid Name';
              }
              return null;
            },
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: _lastNameTEController,
            decoration: InputDecoration(
              hintText: 'এখানে লিখুন',
              labelText: 'জাতীয় পরিচয়পত্র (NID) নম্বর',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter valid NID number';
              }
              return null;
            },
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: _firstNameTEController,
            decoration: InputDecoration(
              hintText: 'এখানে লিখুন',
              labelText: 'ইমেইল',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter valid Name';
              }
              return null;
            },
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: _firstNameTEController,
            decoration: InputDecoration(
              hintText: 'এখানে লিখুন',
              labelText: 'পাসওয়ার্ড',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter valid Name';
              }
              return null;
            },
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: _firstNameTEController,
            decoration: InputDecoration(
              hintText: 'এখানে লিখুন',
              labelText: 'জন্ম তারিখ',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter valid Name';
              }
              return null;
            },
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: _mobileTEController,
            decoration: InputDecoration(
              labelText: 'ফোন নম্বর',
              hintText: 'এখানে লিখুন',
            ),
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: 11,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter your Mobile Number';
              }
              if (RegExp(r'^01[3-9]\d{8}$').hasMatch(value!) == false) {
                return 'Enter valid Mobile Number';
              }

              return null;
            },
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: _cityTEController,
            decoration: InputDecoration(
              labelText: 'বিভাগ',
              hintText: 'এখানে লিখুন',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter valid City';
              }
              return null;
            },
          ),
          SizedBox(height: 8.0),
          TextFormField(
            maxLines: 3,
            controller: _shippingAddressTEController,
            decoration: InputDecoration(hintText: 'Shipping Address'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter valid Shipping address';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _shippingAddressTEController.dispose();
    super.dispose();
  }
}
