import 'package:flutter/material.dart';

import '../../../../core/constants/route_path.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});


  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  Map<String, String> formValues = {"phone_number": "", "password": ""};
  bool loading = false;

  // Track password visibility
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  InputOnChange(MapKey, Textvalue) {
    setState(() {
      formValues.update(MapKey, (value) => Textvalue);
    });
  }

  formOnSubmit() async {
    if (formValues['phone_number']!.isEmpty) {
      print('Phone number error');
    } else if (formValues['password']!.isEmpty) {
      print('Password error');
    } else {
      setState(() {
        loading = true;
      });
      // bool response = await loginRequest(formValues);

      // if (response == true) {}
      // setState(() {
      //   loading = false;
      // });
    }
  }

  final TextEditingController _passwordTEController = TextEditingController();

  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                SizedBox(height: 80),
                Text(
                  'নতুন পাসওয়ার্ড লিখুন',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 50.0),
                TextFormField(
                  controller: _passwordTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('পাসওয়ার্ড'),
                    hintText: 'এখানে লিখুন',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_isPasswordVisible, // Toggle obscure text
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'পাসওয়ার্ড দিন';
                    }
                    return null;
                  },
                  onChanged: (Textvalue) {
                    InputOnChange("phone_number", Textvalue);
                  },
                ),
                SizedBox(height: 40.0),
                TextFormField(
                  controller: _confirmPasswordTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('পাসওয়ার্ড নিশ্চিত করুন'),
                    hintText: 'এখানে লিখুন',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  obscureText:
                      !_isConfirmPasswordVisible, // Toggle obscure text
                  onChanged: (Textvalue) {
                    InputOnChange("password", Textvalue);
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    formOnSubmit();
                    Navigator.pushReplacementNamed(
                      context,
                      RoutePath.loginPath, //'/program_timeline'
                    );
                  },
                  child: Text('পরবর্তী', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
