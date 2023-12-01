import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooted_web/ui/widgets/snackbar.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../const.dart';
import '../home_view.dart';
import 'forgot_password_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String type = loginAuth;

  final _loginKey = GlobalKey<FormState>();
  final _registerKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController verifyController = TextEditingController();

  bool hidePasswords = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Registered && type != loginAuth) {
          type = loginAuth;
          snackbar(
            context,
            'Account Created! Log in with your new credentials...',
          );
        } else if (state is Authenticated) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeView()),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: type == loginAuth ? _buildLogin(state) : _buildRegister(state),
        );
      },
    );
  }

  Widget _buildLogin(AuthState state) {
    return Form(
      key: _loginKey,
      child: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/main_logo.png',
                    width: 250,
                    height: 250,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.trim().length < 4 || value.length > 32) {
                        return 'Must be at least 4-32 Characters';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter Username Here',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.trim().length < 4 || value.length > 32) {
                        return 'Must be 4-32 Characters';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) => _handleLogin(state),
                    obscureText: true,
                    textInputAction: TextInputAction.send,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Password Here',
                      labelText: 'Password',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen(),
                          ),
                        ),
                        child: const Text('Forgot Password?'),
                      ),
                      ElevatedButton(
                        child: state is Authenticating
                            ? const SizedBox(
                                width: 12,
                                height: 12,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Login'),
                        onPressed: () => _handleLogin(state),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('OR'),
                      ),
                      Expanded(
                        child: Container(
                          height: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        type = registerAuth;
                      });
                    },
                    child: const Text('Create Account'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin(AuthState state) {
    if (_loginKey.currentState!.validate() && state is! Authenticating) {
      context.read<AuthBloc>().add(
            SignInRequested(
              context: context,
              password: passwordController.text.trim(),
              username: usernameController.text.trim(),
            ),
          );
    }
  }

  Widget _buildRegister(AuthState state) {
    return Form(
      key: _registerKey,
      child: AutofillGroup(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/main_logo.png',
                      width: 250,
                      height: 250,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email*',
                        hintText: 'Enter your email here',
                      ),
                      autofillHints: const [AutofillHints.email],
                      keyboardType: TextInputType.emailAddress,
                      validator: (_) {
                        if (!EmailValidator.validate(
                          emailController.text,
                        )) {
                          return 'Not a valid email!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name*',
                        hintText: 'Enter your First Name Here',
                      ),
                      validator: (_) {
                        if (firstNameController.text.trim().length < 2 ||
                            firstNameController.text.length > 32) {
                          return 'Must be 2-32 Characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'Last Name*',
                        hintText: 'Enter your Last Name Here',
                      ),
                      validator: (_) {
                        if (lastNameController.text.trim().length < 2 ||
                            lastNameController.text.length > 32) {
                          return 'Must be 2-32 Characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: usernameController,
                      validator: (_) {
                        if (usernameController.text.trim().length < 4 ||
                            usernameController.text.length > 32) {
                          return 'Must be at least 4-32 Characters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Username*',
                        hintText: 'Enter Username Here',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      // TODO: Remove
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        hintText: '1234567890',
                      ),
                      validator: (value) {
                        if (phoneController.text.trim().isNotEmpty &&
                            phoneController.text.trim().length != 10) {
                          return 'Please only enter 10 digits';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9]'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (_) {
                        if (passwordController.text.trim().length < 4 ||
                            passwordController.text.length > 32) {
                          return 'Must be 4-32 Characters';
                        }
                        return null;
                      },
                      controller: passwordController,
                      obscureText: hidePasswords,
                      decoration: InputDecoration(
                        labelText: 'Password*',
                        hintText: 'Minimum 8 Characters',
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            hidePasswords = !hidePasswords;
                          }),
                          icon: Icon(
                            hidePasswords
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.send,
                      onFieldSubmitted: (_) => _handleRegister(state),
                      validator: (_) {
                        if (passwordController.text.trim() !=
                            verifyController.text.trim()) {
                          return 'Passwords do not Match!';
                        }
                        return null;
                      },
                      obscureText: hidePasswords,
                      controller: verifyController,
                      decoration: InputDecoration(
                        labelText: 'Verify Password*',
                        hintText: 'Re-Enter Your Password Here',
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            hidePasswords = !hidePasswords;
                          }),
                          icon: Icon(
                            hidePasswords
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _handleRegister(state),
                        child: state is Authenticating
                            ? const SizedBox(
                                width: 12,
                                height: 12,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Register'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('OR'),
                        ),
                        Expanded(
                          child: Container(
                            height: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => setState(() {
                        type = loginAuth;
                      }),
                      child: const Text('Login'),
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

  void _handleRegister(AuthState state) {
    if (_registerKey.currentState!.validate() && state is! Authenticating) {
      final String rawPhone = phoneController.text
          .replaceAll('+', '')
          .replaceAll(' ', '')
          .replaceAll(')', '')
          .replaceAll('(', '')
          .trim();

      context.read<AuthBloc>().add(
            RegisterRequested(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
              phone: rawPhone,
              username: usernameController.text.trim(),
              firstName: firstNameController.text.trim(),
              lastName: lastNameController.text.trim(),
              context: context,
            ),
          );
      setState(() {
        passwordController.clear();
        verifyController.clear();
      });
    }
  }
}
