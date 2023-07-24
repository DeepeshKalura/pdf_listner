class FileCardModel {
  final String title;
  final String subTitle;
  final String dateAdded;
  final String fileType;
  final String fileUrl;

  FileCardModel(
      {required this.title,
      required this.subTitle,
      required this.dateAdded,
      required this.fileType,
      required this.fileUrl});
}
