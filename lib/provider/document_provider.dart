import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf_listner/helper/snackbar_helper.dart';

class DocumentProvider extends ChangeNotifier {
  String _selectedFileName = "";

  String get selectedFilName => _selectedFileName;
  setSelectedFilename(String value) {
    _selectedFileName = value;
    notifyListeners();
  }

  pickDocuments(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ["pdf", "png", "jpg"]).then((result) {
      if (result != null) {
        PlatformFile selectedFile = result.files.first;
        setSelectedFilename(selectedFile.name);
      } else {
        SnackBarHelper.showErrorSnackBar(context, "No File selected");
      }
    });
  }
}
