import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final String? hintText;
  final Color? containerColor;
  final TextInputType? keyboardType;
  final String? initialValue;
  final bool? obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Color? iconColor;
  final Color? borderColor;
  final IconData? iconData;
  final VoidCallback? suffixIconPressed;
  final IconData? iconDataSuffix;
  final bool? enabled;
  final bool? expands;
  final int? maxLines;
  final TextEditingController? controller;

  final double? borderRadius;
  const CustomForm(
      {Key? key,
      this.hintText,
      this.initialValue,
      this.obscureText = false,
      this.controller,
      this.expands = false,
      this.maxLines = 1,
      this.borderRadius,
      this.enabled,
      this.iconData,
      this.validator,
      this.iconDataSuffix,
      this.suffixIconPressed,
      this.containerColor,
      this.keyboardType,
      this.onChanged,
      this.iconColor,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius!),
        color: containerColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: TextFormField(
          expands: expands!,
          controller: controller,
          maxLines: maxLines,
          obscureText: obscureText!,
          initialValue: initialValue,
          enabled: enabled,
          validator: validator,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: Theme.of(context).textTheme.headline5,
          decoration: InputDecoration(
            enabled: true,
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.grey),
            prefixIcon: iconData == null
                ? null
                : Icon(
                    iconData,
                    size: 30,
                    color: iconColor,
                  ),
            suffixIcon: iconDataSuffix == null
                ? null
                : IconButton(
                    onPressed: suffixIconPressed,
                    icon: Icon(
                      iconDataSuffix,
                      color: iconColor,
                      size: 18,
                    ),
                  ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: borderColor!),
            ),
          ),
        ),
      ),
    );
  }
}
