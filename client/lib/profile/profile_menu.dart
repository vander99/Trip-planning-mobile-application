import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xFFF5F6F9),
        onPressed: press,
        child: Row(children: [
          SvgPicture.asset(icon, width: 22, color: Colors.green //kPrimary
              ),
          SizedBox(width: 20),
          Expanded(
              child: Text(text, style: TextStyle(color: Color(0xFF757575)))),
          Icon(Icons.arrow_forward_ios, color: Colors.green)
        ]),
      ),
    );
  }
}
