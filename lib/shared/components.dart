import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

navigateTo(context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

navigateAndFinish(context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false,
  );
}

class ValidatedTextField extends StatelessWidget {
  final GlobalKey<FormState> validator;
  final String errorText;
  final String hintText;
  final bool hasNextText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final TextEditingController controller;
  final bool enable;
  final IconData? icon;
  final Widget? suffixIcon;
  final bool obscureText;
  final double fontSize;
  final double radius;

  const ValidatedTextField(
      {Key? key,
        required this.controller,
        required this.validator,
        required this.errorText,
        required this.hintText,
        required this.onChanged,
        this.onFieldSubmitted,
        this.hasNextText = true,
        this.enable = true,
        this.icon,
        this.suffixIcon,
        this.obscureText = false,
        this.fontSize = 20.0,
        this.radius = 15.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextInputType? textInputType;
    if (hintText == 'email') {
      textInputType = TextInputType.emailAddress;
    } else if (hintText == 'phone number') {
      textInputType = TextInputType.phone;
    }
    return Form(
      key: validator,
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        controller: controller,
        enabled: enable,
        textInputAction:
        hasNextText ? TextInputAction.next : TextInputAction.done,
        keyboardType: textInputType,
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorText;
          }
          return null;
        },
        onChanged: onChanged,
        style: TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}

FToast fToast = FToast();

showToast(
    {required context,
      required String text,
      required Color color,
      int duration = 3}) {
  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: color,
    ),
    child: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
  );
  fToast.showToast(
    child: toast,
    gravity: ToastGravity.CENTER,
    toastDuration: Duration(seconds: duration),
  );
}

Widget showPasswordIcon(
    {required Function() onPressed, required bool passwordIsShown}) {
  return IconButton(
      onPressed: onPressed,
      icon: passwordIsShown
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off));
}