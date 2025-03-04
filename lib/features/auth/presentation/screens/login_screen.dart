
import 'package:bjp_app/core/constants/route_path.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map<String, String> formValues = {"phone_number": "", "password": ""};
  bool loading = false;

  inputOnChange(mapKey, textValue) {
    setState(() {
      formValues.update(mapKey, (value) => textValue);
    });
  }

  formOnSubmit() async {
    if (formValues['phone_number']!.isEmpty) {
      print('email error');
    } else if (formValues['password']!.isEmpty) {
      print('pass error');
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

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String _url =
      "https://rnd.egeneration.co/bjp/public/index.php/registration";

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 80),
                Text('লগইন', style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 50.0),
                TextFormField(
                  controller: _emailTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('মোবাইল নম্বর*'),
                    hintText: 'এখানে লিখুন',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'মোবাইল নম্বর দিন';
                    }
                    return null;
                  },
                  onChanged: (textValue) {
                    inputOnChange("phone_number", textValue);
                  },
                ),
                SizedBox(height: 40.0),
                TextFormField(
                  controller: _passwordTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('পাসওয়ার্ড*'),
                    hintText: 'এখানে লিখুন',
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (textValue) {
                    inputOnChange("password", textValue);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 183.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/otp-verification',
                      );
                    },
                    child: Text('পাসওয়ার্ড ভুলে গেছেন ?'),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    formOnSubmit();
                    Navigator.pushReplacementNamed(
                      context,
                      RoutePath.homeScreenPath, //'/program_timeline'
                    );
                  },
                  child: Text('লগইন', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.only(left: 75),
                  child: Row(
                    children: [
                      Text('অ্যাকাউন্ট নেই? এখনই '),
                      TextButton(
                        onPressed: () {
                          _launchUrl(_url);
                        },
                        child: Text('মেম্বার হন।'),
                      ),
                    ],
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
