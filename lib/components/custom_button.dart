import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.onPressedCallback,
    this.buttonSize,
    required this.centerText,
  }) : super(key: key);

  final void Function()? onPressedCallback;
  final String centerText;
  final Size? buttonSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedCallback,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff5448C8)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size>(
            buttonSize ?? const Size(double.infinity, 65)),
      ),
      child: Text(
        centerText,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}
