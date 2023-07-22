import 'package:flutter/material.dart';

import '../helper/sized_box_helper.dart';
import 'custom_text_field.dart';

class CustomHomeAppbar extends StatelessWidget implements PreferredSize {
  const CustomHomeAppbar({super.key});

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
                      onPressed: () {},
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ))
                ],
              ),
              SizedBoxHelper.sizedBox20,
              CustomTextField(
                  controller: TextEditingController(),
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
