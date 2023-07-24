import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf_listner/helper/snackbar_helper.dart';

class DocumentProvider extends ChangeNotifier {
  pickDocuments(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ["pdf", "png", "jpg"]).then((result) {
      if (result != null) {
        PlatformFile selectedFile = result.files.first;
        SnackBarHelper.showSucessSnackBar(context, selectedFile.name);
      } else {
        SnackBarHelper.showErrorSnackBar(context, "No File selected");
      }
    });
  }
}
