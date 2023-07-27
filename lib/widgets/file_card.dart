import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf_listner/models/file_card_model.dart';

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
                    onPressed: () {},
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
