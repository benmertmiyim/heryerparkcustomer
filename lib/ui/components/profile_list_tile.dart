import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget onTap;
  final String? subtitle;

  const ProfileListTile(
      {Key? key,
      required this.icon,
      required this.title,
      required this.onTap,
      this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => onTap),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                  ),
                  subtitle != null ? Text(subtitle!,style: TextStyle(color: Colors.red.withOpacity(0.5)),) : Container(),
                ],
              ),
            ),
            const Icon(
              MdiIcons.chevronRight,
            ),
          ],
        ),
      ),
    );
  }
}
