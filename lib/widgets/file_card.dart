import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf_listner/models/file_card_model.dart';
import 'package:pdf_listner/provider/document_provider.dart';
import 'package:provider/provider.dart';

import '../helper/sized_box_helper.dart';

class FileCard extends StatelessWidget {
  final FileCardModel model;
  const FileCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200, spreadRadius: 4, blurRadius: 4)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                (model.fileType == "pdf")
                    ? Image.asset(
                        "assets/images/icon_pdf_type.png",
                        width: 50,
                      )
                    : Image.asset(
                        "assets/images/icon_image_type.png",
                        width: 50,
                      ),
                SizedBoxHelper.sizedBox_5,
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                        maxLines: 2,
                      ),
                      Text(
                        model.subTitle,
                        style: Theme.of(context).textTheme.bodyLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(model.dateAdded.substring(0, 10),
                          style: Theme.of(context).textTheme.bodySmall)
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                    onTap: () {},
                    child: Text(
                      "view",
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              titleTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              backgroundColor: Colors.red,
                              title: const Text("Do you want to delete?"),
                              content: Text(
                                model.title,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Provider.of<DocumentProvider>(context,
                                              listen: false)
                                          .deleteDocument(
                                              model.id, model.fileName, context)
                                          .then((value) {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )),
                              ],
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
