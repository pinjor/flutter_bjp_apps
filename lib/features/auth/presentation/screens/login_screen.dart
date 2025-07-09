import 'package:bjp_app/config/app_colors.dart';
import 'package:bjp_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:bjp_app/features/auth/presentation/screens/enter_email_screen.dart';
import 'package:bjp_app/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailOrMobileController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isAdminLogin = false;

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      final mobileOrEmail = _emailOrMobileController.text.trim();
      final password = _passwordController.text.trim();

      ref
          .read(authControllerProvider.notifier)
          .login(
            mobileOrEmail: mobileOrEmail,
            password: password,
            isAdmin: _isAdminLogin,
          );
      // Navigation handled by GoRouter redirect method automatically
    }
  }

  @override
  void initState() {
    // _emailOrMobileController.text = '01712345678';
    // _passwordController.text = 'Arp@12345';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Align(
                    // alignment: Alignment.topRight,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _isAdminLogin ? 'অ্যাডমিন' : 'সদস্য',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Switch(
                          activeColor: AppColors.themeColor,
                          value: _isAdminLogin,
                          onChanged: (bool value) {
                            setState(() {
                              _isAdminLogin = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 80),
                  Text(
                    _isAdminLogin ? 'অ্যাডমিন লগইন' : 'সদস্য লগইন',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 50.0),
                  TextFormField(
                    controller: _emailOrMobileController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      label: Text(_isAdminLogin ? 'ইমেইল*' : 'মোবাইল নম্বর*'),
                      hintText: 'এখানে লিখুন',
                    ),
                    keyboardType:
                        _isAdminLogin
                            ? TextInputType.emailAddress
                            : TextInputType.phone,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return _isAdminLogin ? 'ইমেইল দিন' : 'মোবাইল নম্বর দিন';
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          //! maybe this should be changed
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EnterEmailScreen(),
                            ),
                          );
                          // context.push(RoutePath.enterEmailScreenPath); // not working
                        },
                        child: Text(
                          'পাসওয়ার্ড ভুলে গেছেন ?',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  if (authState.isLoading)
                    CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: _loginUser,
                      child: Text(
                        'লগইন',
                        style: TextStyle(color: Colors.white),
                      ),
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
                            // _launchUrl(_url);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                          child: Text('মেম্বার হোন'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
