import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
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

class HomeScreen extends StatefulWidget {
  static String routeName = "/homeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  StreamController<DatabaseEvent> streamController = StreamController();
  String userId = FirebaseAuth.instance.currentUser!.uid;
  setStream() {
    FirebaseDatabase.instance
        .ref()
        .child("files_info/$userId")
        .orderByChild("title")
        .startAt(searchController.text)
        .endAt("${searchController.text}" "\uf8ff")
        .onValue
        .listen((event) {
      streamController.add(event);
    });
  }

  @override
  void initState() {
    setStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: CustomFloatingActionButton(
          iconData: Icons.add,
          title: "Add File",
          onTap: () {
            Navigator.pushNamed(context, AddDocumentScreen.routeName);
          },
        ),
        appBar: CustomHomeAppbar(
          controller: searchController,
          onsearch: () {
            setStream();
          },
        ),
        body: ScreenBackground(
          child: StreamBuilder<DatabaseEvent>(
              stream: streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  List<FileCardModel> _list = [];
                  (snapshot.data!.snapshot.value as Map<dynamic, dynamic>)
                      .forEach((key, value) {
                    _list.add(FileCardModel.fromJson(value,key));
                  });
                  return ListView(
                      physics: const BouncingScrollPhysics(),
                      children: _list
                          .map(
                            (e) => FileCard(
                                model: FileCardModel(
                                    title: e.title,
                                    subTitle: e.subTitle,
                                    dateAdded: e.dateAdded,
                                    fileType: e.fileType,
                                    fileUrl: e.fileUrl,
                                    fileName: e.fileName,
                                    id: e.id
                                    )),
                          )
                          .toList());
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/icon_no_file.png",
                        height: 100,
                      ),
                      Text("no data"),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}
