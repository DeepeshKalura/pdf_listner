import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingsCardWidget extends StatelessWidget {
  final String title;
  final IconData leadingIconData;
  final Widget? trailing;
  const SettingsCardWidget(
      {super.key,
      required this.title,
      required this.leadingIconData,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200, blurRadius: 4, spreadRadius: 4)
          ]),
      child: ListTile(
        title: Text(title),
        trailing: trailing,
        leading: Icon(leadingIconData),
      ),
    );
  }
}
