import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf_listner/helper/snackbar_helper.dart';

class DocumentProvider extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
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

  bool _isFileUploading = false;
  bool get isFileUploaded => _isFileUploading;
  setIsFileUploaded(bool value) {
    _isFileUploading = value;
    notifyListeners();
  }

  sendDocumentData({required BuildContext context}) async {
    try {
      setIsFileUploaded(true);
      UploadTask uploadTask = _firebaseStorage
          .ref()
          .child("files")
          .child(selectedFilName)
          .putFile(_file!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String uploadedFileUrl = await taskSnapshot.ref.getDownloadURL();
      await _firebaseDatabase.ref().child("files_info").push().set({
        "title": titleController.text,
        "note": noteController.text,
        "filename": _selectedFileName,
        "fileUrl": uploadedFileUrl,
        "dateAdded": DateTime.now().toString(),
        "fileType": _selectedFileName.split(".").last,
      });
      resetAll();
      setIsFileUploaded(false);
    } on FirebaseException catch (firebaseError) {
      setIsFileUploaded(false);
      SnackBarHelper.showErrorSnackBar(context, firebaseError.message!);
    } catch (error) {
      setIsFileUploaded(false);
      SnackBarHelper.showErrorSnackBar(context, error.toString());
    }
  }

  resetAll() {
    titleController = TextEditingController();
    noteController = TextEditingController();
    _selectedFileName = "";
    _file = null;
  }
}
