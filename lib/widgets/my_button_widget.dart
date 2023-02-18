import 'package:contacts/utils/responsive.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.redAccent,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              fontSize: ScreenUtil(context).screenWidth < 1000
                  ? 16
                  : ScreenUtil(context).screenWidth * 0.013),
        ),
      ),
    );
  }
}
