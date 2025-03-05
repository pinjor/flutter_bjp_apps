import 'package:bjp_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      final mobile = _mobileController.text.trim();
      final password = _passwordController.text.trim();

      ref.read(authControllerProvider.notifier).login(mobile, password);
      // Navigation handled by GoRouter redirect
    }
  }

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
    final authState = ref.watch(authControllerProvider);

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
                  controller: _mobileController,
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
                ),
                SizedBox(height: 40.0),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'পাসওয়ার্ড দিন';
                    }
                    return null;
                  },
                  controller: _passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    
                    label: Text('পাসওয়ার্ড*'),
                    hintText: 'এখানে লিখুন',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 183.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text('পাসওয়ার্ড ভুলে গেছেন ?'),
                  ),
                ),
                SizedBox(height: 16.0),
                if (authState.isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _loginUser,
                    child: Text('লগইন', style: TextStyle(color: Colors.white)),
                  ),
                if (authState.error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      authState.error!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.only(left: 75),
                  child: Row(
                    children: [
                      Text('অ্যাকাউন্ট নেই? এখনই'),
                      TextButton(
                        onPressed: () {
                          _launchUrl(_url);
                        },
                        child: Text('মেম্বার হন'),
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
