import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final onPressed;
  final Color color;
  final Color textColor;
  final double width;
  final Icon icon;

  const CustomButton({super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.white70,
    this.textColor = Colors.black,
    this.width = double.infinity,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80),
        gradient: const LinearGradient(
          begin: Alignment.center,
          colors: [Color(0xffffae88), Color(0xff8f93ea)]
        ),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: const TextStyle(
                color: Colors.white
                ),
              ),
              const SizedBox(width: 10,),
              icon,
            ],
          ),
        ),
        ),

      );
  }
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final bool? autoValidate;
  final bool? autoCorrect;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final EdgeInsetsGeometry? contentPadding;
  final bool enabled;
  final Color? fillColor;
  final TextStyle? textStyle;
  final Color? borderColor;
  final double borderWidth;
  final BorderRadiusGeometry? borderRadius;
  final Icon? iconData;
  final TextEditingController controller;

  const CustomTextField({
    required this.labelText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.validator,
    this.contentPadding,
    this.enabled = true,
    this.fillColor,
    this.textStyle,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderRadius,
    this.iconData,
    required this.controller,
    this.autoValidate,
    this.autoCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: contentPadding,
        fillColor: fillColor,
        filled: fillColor != null,
        enabledBorder: _buildOutlineInputBorder(),
        focusedBorder: _buildOutlineInputBorder(),
        errorBorder: _buildOutlineInputBorder(error: true),
        focusedErrorBorder: _buildOutlineInputBorder(error: true),
        prefixIcon: iconData,
      ),
      style: textStyle,
    );
  }

  OutlineInputBorder _buildOutlineInputBorder({bool error = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(
        color: error ? Colors.red : borderColor ?? Colors.lightBlue,
        width: borderWidth,
      ),
    );
  }
}


