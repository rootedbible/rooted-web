import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    required this.controller,
    hintText,
    this.submitFunc,
    this.obscureText = false,
    this.validationFunc,
    this.isRequired = false,
  }) : hintText = hintText ?? labelText;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function? submitFunc;
  final bool obscureText;
  final Function? validationFunc;
  final bool isRequired;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 15,
        ),
        labelText: widget.labelText + (widget.isRequired ? ' *' : ''),
        // hintText: 'Enter your email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: widget.obscureText == true
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
      ),
      validator: widget.validationFunc == null
          ? (value) {
              if (value!.trim().length < 4 || value.length > 32) {
                return 'Must be at least 4-32 Characters';
              }
              return null;
            }
          : (value) => widget.validationFunc!(value),
      keyboardType: widget.keyboardType,
      onFieldSubmitted:
          widget.submitFunc != null ? (_) => widget.submitFunc!() : null,
      obscureText: _obscureText,
    );
  }
}
