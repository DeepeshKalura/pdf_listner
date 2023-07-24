import 'package:flutter/material.dart';
import 'package:pdf_listner/helper/sized_box_helper.dart';
import 'package:pdf_listner/provider/document_provider.dart';
import 'package:pdf_listner/widgets/custom_floatingbutton_screen.dart';
import 'package:pdf_listner/widgets/custom_text_field.dart';
import 'package:pdf_listner/widgets/screen_background.dart';
import 'package:provider/provider.dart';

class AddDocumentScreen extends StatefulWidget {
  static String routeName = "/AddDocumentScreen";
  const AddDocumentScreen({super.key});

  @override
  State<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {
  final _key = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Documents"),
        centerTitle: true,
      ),
      floatingActionButton: CustomFloatingActionButton(
        iconData: Icons.check,
        title: "Upload",
        onTap: () {},
      ),
      body: ScreenBackground(
          child: Form(
        key: _key,
        child: Column(children: [
          CustomTextField(
            controller: titleController,
            hintText: "Title",
            prefixIconData: Icons.title,
            validator: (String? value) {
              if (value!.isEmpty) return "please enter title";

              return null;
            },
            labelText: "please enter the title",
          ),
          SizedBoxHelper.sizedBox20,
          CustomTextField(
            controller: noteController,
            hintText: "note",
            prefixIconData: Icons.note,
            validator: (String? value) {
              if (value!.isEmpty) return "please enter note";

              return null;
            },
            labelText: "please enter the note",
          ),
          SizedBoxHelper.sizedBox20,
          Consumer<DocumentProvider>(builder: (context, provider, child) {
            return InkWell(
              onTap: () {
                provider.pickDocuments(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                ),
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("fileName"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.grey,
                        ),
                        Text(
                          "Upload file",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ]),
      )),
    );
  }
}
