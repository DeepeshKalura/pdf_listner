import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf_listner/helper/snackbar_helper.dart';

class DocumentProvider extends ChangeNotifier {
  String _selectedFileName = "";
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  File? _file;

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
        _file = File(selectedFile.path!);
      } else {
        SnackBarHelper.showErrorSnackBar(context, "No File selected");
      }
    });
  }

  sendDocumentData({required String title, required String note}) async {
    UploadTask uploadTask = _firebaseStorage
        .ref()
        .child("files")
        .child(selectedFilName)
        .putFile(_file!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String uploadedFileUrl = await taskSnapshot.ref.getDownloadURL();
    await _firebaseDatabase.ref().child("files_info").push().set({
      "title": title,
      "note": note,
      "filename": _selectedFileName,
      "fileUrl": uploadedFileUrl,
      "dateAdded": DateTime.now().toString(),
      "fileType": _selectedFileName.split(".").last,
    });
  }
}
