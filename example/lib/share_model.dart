class ShareModel {
  String title;
  ShareModel(this.title);
}

List<ShareModel> data() {
  return List.generate(100, (index) => ShareModel('$index'));
}

List<ShareModel> data2() {
  return List.generate(80, (index) => ShareModel('$index'));
}
