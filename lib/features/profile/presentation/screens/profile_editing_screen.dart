import 'package:flutter/material.dart';

class ProfileEditingScreen extends StatefulWidget {
  const ProfileEditingScreen({super.key});

  @override
  State<ProfileEditingScreen> createState() => _ProfileEditingScreenState();
}

class _ProfileEditingScreenState extends State<ProfileEditingScreen> {
  var selected_value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('প্রোফাইল পরিবর্তন'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('নাম'),
                    hintText: 'এখানে লিখুন',
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('ইমেইল'),
                    hintText: 'এখানে লিখুন',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('মোবাইল নম্বর'),
                    hintText: 'এখানে লিখুন',
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  hint: Text('বিভাগ'),
                  onChanged: (val) {
                    setState(() {
                      val = selected_value;
                    });
                  },
                  value: selected_value,
                  items: [
                    DropdownMenuItem(value: 'ঢাকা', child: Text('ঢাকা')),
                    DropdownMenuItem(value: 'রংপুর', child: Text('রংপুর')),
                    DropdownMenuItem(value: 'সিলেট', child: Text('সিলেট')),
                    DropdownMenuItem(value: 'বরিশাল', child: Text('বরিশাল')),
                    DropdownMenuItem(value: 'রাজশাহী', child: Text('রাজশাহী')),
                    DropdownMenuItem(
                      value: 'দিনাজপুর',
                      child: Text('দিনাজপুর'),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('জেলা'),
                    hintText: 'এখানে লিখুন',
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('উপজেলা'),
                    hintText: 'এখানে লিখুন',
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
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
