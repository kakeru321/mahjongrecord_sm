import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/screens/member_add_screen.dart';
import 'package:mahjong_record_sm/screens/record_add_screen.dart';
import 'package:mahjong_record_sm/screens/record_inquiry_screen.dart';

class BottomNavigationBarOriginal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomAppBar(
        color: Colors.orange,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.article,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecordInquiryScreen())),
            ),
            IconButton(
              icon: Icon(
                Icons.photo_filter,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => RecordAddScreen())),
            ),
            IconButton(
              icon: Icon(
                Icons.person_add_sharp,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MemberAddScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
