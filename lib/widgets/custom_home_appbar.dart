import 'package:flutter/material.dart';
import 'package:pdf_listner/screens/settings_screen.dart';

import '../helper/sized_box_helper.dart';
import 'custom_text_field.dart';

class CustomHomeAppbar extends StatelessWidget implements PreferredSize {
  final TextEditingController controller;
  final VoidCallback onsearch;
  const CustomHomeAppbar(
      {super.key, required this.controller, required this.onsearch});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(150),
      child: Container(
        color: const Color(0xFF1e5376),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/icon_text.png",
                    width: 150,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SettingScreen.routeName);
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ))
                ],
              ),
              SizedBoxHelper.sizedBox20,
              CustomTextField(
                  suffixIcon: IconButton(
                    icon: Text("Go"),
                    onPressed: onsearch,
                  ),
                  controller: controller,
                  hintText: "Enter the title of Document",
                  prefixIconData: Icons.search,
                  validator: (value) {
                    return null;
                  })
            ]),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(150);
}
