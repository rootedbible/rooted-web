import "package:flutter/material.dart";

import "../../../api/services/auth_service.dart";
import "../../widgets/error_dialog.dart";
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController verifyController = TextEditingController();

  bool loading = false;
  bool emailSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Reset Your Password"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              buildUserInput(),
              if (emailSuccess) buildResetInput(),
              if (loading) const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Enter your email or username to receive a password reset code.",
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: userController,
              decoration: const InputDecoration(
                labelText: "Username or Email",
                hintText: "Enter your Username or Email",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async => await _handleUserSubmit(),
              child: const Text("Request Reset Code"),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildResetInput() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Enter the code sent to your email and set your new password.",
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: pinController,
                decoration: const InputDecoration(
                  labelText: "Code",
                  hintText: "Enter the Received Code",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the code sent to your email";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "New Password",
                  hintText: "Create a New Password",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please create a password";
                  } else if (value.length < 4 || value.length > 32) {
                    return "Password must be 4-32 characters long";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: verifyController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Confirm Password",
                  hintText: "Confirm Your New Password",
                ),
                validator: (value) {
                  if (value != passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async => await _handleReset(),
                child: const Text("Change Password"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleUserSubmit() async {
    setState(() => loading = true);
    try {
      await AuthService().sendReset(userController.text.trim());
      setState(() {
        emailSuccess = true;
      });
    } catch (e) {
      errorDialog(e.toString(), context);
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> _handleReset() async {
    if (_formKey.currentState!.validate()) {
      setState(() => loading = true);
      try {
        await AuthService().resetPassword(
            pin: pinController.text.trim(),
            password: passwordController.text.trim(),);
        Navigator.pop(context);
      } catch (e) {
        errorDialog(e.toString(), context);
      } finally {
        setState(() => loading = false);
      }
    }
  }
}
