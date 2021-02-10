import 'dart:ui' as prefix0;
import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final String label;

  ButtonWithIcon({
    this.onPressed,
    this.icon,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: SizedBox(
        width: double.infinity,
        height: 50.0,
        child: RaisedButton.icon(
          onPressed: onPressed,
          icon: icon,
          label: Text(
            label,
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          color: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(prefix0.Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
