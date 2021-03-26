import 'dart:ui' as prefix0;
import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/parts/hex_color.dart';

class ButtonWithIconOnline extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final String label;

  ButtonWithIconOnline({
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
              color: HexColor('f9f7f7'),
              fontWeight: FontWeight.bold,
            ),
          ),
          color: HexColor('3f72af'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(prefix0.Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
