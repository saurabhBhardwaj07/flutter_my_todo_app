// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController inputController;
  final String? hintText;
  final String labelText;
  final TextInputAction inputAction;
  final TextInputType inputType;
  final int? maxLength;
  final int? minLine;
  final int? maxLine;
  final EdgeInsetsGeometry? contentPadding;
  final bool readOnly;
  final void Function()? onTap;
  const CustomFormField(
      {Key? key,
      required this.inputController,
      required this.hintText,
      required this.labelText,
      this.inputAction = TextInputAction.next,
      this.inputType = TextInputType.text,
      this.maxLength,
      this.maxLine,
      this.minLine,
      this.contentPadding,
      this.readOnly = false,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff5448C8);
    const secondaryColor = Color(0xff5448C8);
    const accentColor = Color(0xffffffff);
    const backgroundColor = Color(0xffffffff);
    const errorColor = Color(0xffEF4444);

    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextFormField(
        controller: inputController,
        readOnly: readOnly,
        onTap: onTap,
        onChanged: (value) {},
        keyboardType: inputType,
        style: const TextStyle(fontSize: 14, color: Colors.black),
        textInputAction: inputAction,
        maxLines: maxLine,
        minLines: minLine,
        maxLength: maxLength,
        validator: (v) {
          if (v == null) {
            return "field can't be null";
          } else if (v.isEmpty) {
            return "field can't be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          label: Text(labelText),
          labelStyle: const TextStyle(color: primaryColor),
          filled: true,
          fillColor: accentColor,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: secondaryColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: errorColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
}
