import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../bloc/auth/auth_bloc.dart";
import "../../../const.dart";
import "../../../themes.dart/colors.dart";
import "../../home/home_view.dart";
import "auth_textfield.dart";
import "forgot_password_screen.dart";

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

  final ScrollController _scrollController = ScrollController();

  bool hidePasswords = true;

  @override
  void dispose() {
    _scrollController.dispose();
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    verifyController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeView()),
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: AppColors.primary,
              toolbarHeight: 1,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: AppColors.primary,
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/images/primary_white_logo.png",
                          width: 250,
                          height: 250,
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 500,
                      ),
                      child: type == loginAuth
                          ? _buildLogin(state)
                          : _buildRegister(state),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogin(AuthState state) {
    return Form(
      key: _loginKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AuthTextField(
              labelText: "Username",
              controller: usernameController,
              submitFunc: () => _handleLogin(state),
            ),
            const SizedBox(height: doublePadding),
            AuthTextField(
              labelText: "Password",
              controller: passwordController,
              submitFunc: () => _handleLogin(state),
              obscureText: true,
            ),
            const SizedBox(height: doublePadding),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: state is Authenticating
                    ? const SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(),
                      )
                    : const Text("Login"),
                onPressed: () => _handleLogin(state),
              ),
            ),
            const SizedBox(height: doublePadding),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen(),
                  ),
                ),
                child: const Text("Forgot Password?"),
              ),
            ),
            const Divider(
              height: 10,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      type = registerAuth;
                    });
                  },
                  child: const Text("Create Free Account"),
                ),
              ),
            ),
          ],
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
    final registrationTextFields = <Map<String, dynamic>>[
      {
        "labelText": "Email",
        "keyboardType": TextInputType.emailAddress,
        "controller": emailController,
        "obscureText": false,
        "isRequired": true,
        "validationFunc": (value) {
          if (!EmailValidator.validate(value!)) {
            return "Not a valid email!";
          }
          return null;
        },
      },
      {
        "labelText": "First Name",
        "keyboardType": TextInputType.text,
        "controller": firstNameController,
        "obscureText": false,
        "isRequired": true,
        "validationFunc": (value) {
          if (firstNameController.text.trim().length < 2 ||
              firstNameController.text.length > 32) {
            return "First Name must be 2-32 Characters!";
          }
          return null;
        },
      },
      {
        "labelText": "Last Name",
        "keyboardType": TextInputType.text,
        "controller": lastNameController,
        "obscureText": false,
        "isRequired": true,
        "validationFunc": (value) {
          if (lastNameController.text.trim().length < 2 ||
              lastNameController.text.length > 32) {
            return "Last Name must be 2-32 Characters!";
          }
          return null;
        },
      },
      {
        "labelText": "Username",
        "keyboardType": TextInputType.text,
        "controller": usernameController,
        "obscureText": false,
        "isRequired": true,
      },
      {
        "labelText": "Phone Number",
        "keyboardType": TextInputType.phone,
        "controller": phoneController,
        "obscureText": false,
        "validationFunc": (value) {
          if (value!.trim().isNotEmpty && value.trim().length != 10) {
            return "Please only enter 10 digits";
          }
          return null;
        },
      },
      {
        "labelText": "Password",
        "keyboardType": TextInputType.text,
        "controller": passwordController,
        "obscureText": true,
        "isRequired": true,
        "validationFunc": (value) {
          if (value!.trim().length < 4 || value.length > 32) {
            return "Must be 4-32 Characters";
          }
          return null;
        },
      },
      {
        "labelText": "Verify Password",
        "keyboardType": TextInputType.text,
        "controller": verifyController,
        "obscureText": true,
        "isRequired": true,
        "validationFunc": (value) {
          if (passwordController.text.trim() != value!.trim()) {
            return "Passwords do not Match!";
          }
          return null;
        },
      }
    ];

    return Form(
      key: _registerKey,
      child: AutofillGroup(
        child: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => setState(() {
                        type = loginAuth;
                      }),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Text(
                      "Register",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: doublePadding),
                ...[
                  for (final field in registrationTextFields) ...[
                    AuthTextField(
                      labelText: field["labelText"]!,
                      keyboardType: field["keyboardType"]!,
                      controller: field["controller"]!,
                      obscureText: field["obscureText"]!,
                      isRequired: field["isRequired"] ?? false,
                      validationFunc: field["validationFunc"],
                    ),
                    const SizedBox(height: doublePadding),
                  ],
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _handleRegister(state),
                    child: state is Authenticating
                        ? const SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(),
                          )
                        : const Text("Register"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Text("OR"),
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
                    child: const Text("Login"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleRegister(AuthState state) {
    if (_registerKey.currentState!.validate() && state is! Authenticating) {
      final String rawPhone = phoneController.text
          .replaceAll("+", "")
          .replaceAll(" ", "")
          .replaceAll(")", "")
          .replaceAll("(", "")
          .trim();
      debugPrint(passwordController.text.trim());
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
