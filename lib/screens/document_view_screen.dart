import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_listner/helper/snackbar_helper.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class DocumentViewScreen extends StatelessWidget {
  const DocumentViewScreen({super.key});
  static String routeName = "/DocumentScreen";

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as DocumentViewScreenArgs;
    return Scaffold(
        appBar: AppBar(
          title: Text(args.fileName),
        ),
        body: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return (args.fileType == "pdf")
                    ? PdfView(path: snapshot.data!)
                    : Image.file(
                        File(
                          snapshot.data!,
                        ),
                      );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
            future: getDocumentData(args, context),
          ),
        ));
  }
}

Future<String> getDocumentData(
    DocumentViewScreenArgs documentViewScreenArgs, BuildContext context) async {
  final directory = await getApplicationSupportDirectory();
  File file = File("${directory.path}/${documentViewScreenArgs.fileName}");
  if (await file.exists()) {
    return file.path;
  } else {
    final response = await get(Uri.parse(documentViewScreenArgs.fileUrl));
    await file.writeAsBytes(response.bodyBytes).then((value) =>
        {SnackBarHelper.showSucessSnackBar(context, "File Downloaded")});
  }

  return file.path;
}

class DocumentViewScreenArgs {
  final String fileName;
  final String fileUrl;
  final String fileType;
  DocumentViewScreenArgs(
      {required this.fileName, required this.fileUrl, required this.fileType});
}
