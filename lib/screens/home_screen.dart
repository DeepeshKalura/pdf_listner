import 'package:flutter/material.dart';
import 'package:pdf_listner/helper/sized_box_helper.dart';
import 'package:pdf_listner/models/file_card_model.dart';
import 'package:pdf_listner/provider/auth_provider.dart';
import 'package:pdf_listner/screens/add_document_screen.dart';
import 'package:pdf_listner/widgets/custom_floatingbutton_screen.dart';
import 'package:pdf_listner/widgets/custom_home_appbar.dart';
import 'package:pdf_listner/widgets/custom_text_field.dart';
import 'package:pdf_listner/widgets/file_card.dart';
import 'package:pdf_listner/widgets/screen_background.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/homeScreen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton:CustomFloatingActionButton(iconData: Icons.add,title: "Add File",onTap: (){Navigator.pushNamed(context, AddDocumentScreen.routeName);},),
        appBar: const CustomHomeAppbar(),
        body: ScreenBackground(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              FileCard(
                  model: FileCardModel(
                      title: "Title",
                      subTitle: "subtitle",
                      dateAdded: DateTime.now().toString().substring(0, 10),
                      fileType: "pdf")),
            ],
          ),
        ),
      ),
    );
  }
}
