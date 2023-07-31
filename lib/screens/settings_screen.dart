import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf_listner/helper/sized_box_helper.dart';
import 'package:pdf_listner/provider/auth_provider.dart';
import 'package:pdf_listner/provider/user_info_provider.dart';
import 'package:pdf_listner/widgets/custom_button.dart';
import 'package:pdf_listner/widgets/custom_text_field.dart';
import 'package:pdf_listner/widgets/screen_background.dart';
import 'package:pdf_listner/widgets/settings_card.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  static String routeName = "/SettingScreen";
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserInfoProvider>(context, listen: false);
    provider.getUsername();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ScreenBackground(
          child: Column(
        children: [
          Consumer<UserInfoProvider>(builder: (context, model, child) {
            return SettingsCardWidget(
              title: model.userName,
              leadingIconData: Icons.person,
              trailing: IconButton(
                  onPressed: () {
                    TextEditingController controller = TextEditingController();
                    showModalBottomSheet(
                        context: context,
                        builder: (contex) => Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Container(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(children: [
                                    CustomTextField(
                                      controller: controller,
                                      hintText: "username",
                                      prefixIconData: Icons.person,
                                      validator: (value) {
                                        return null;
                                      },
                                      labelText: "Username",
                                    ),
                                    SizedBoxHelper.sizedBox20,
                                    CustomButton(
                                        onPressed: () {
                                          model.updateUsername(
                                              controller.text, contex);
                                        },
                                        title: "Update Username")
                                  ]),
                                ),
                              ),
                            ));
                  },
                  icon: const Icon(Icons.edit)),
            );
          }),
          SettingsCardWidget(
            title: provider.user!.email!,
            leadingIconData: Icons.email,
          ),
          SettingsCardWidget(
            title: "Log Out",
            leadingIconData: Icons.logout,
            trailing: IconButton(
                onPressed: () {
                  
                  Provider.of<AuthProvider>(context, listen: false)
                      .logOut(context);
                },
                icon: const Icon(Icons.logout)),
          )
        ],
      )),
    );
  }
}
