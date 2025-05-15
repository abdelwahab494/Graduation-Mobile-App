class InfoModel {
  final String name;
  final String image;

  InfoModel({required this.name, required this.image});
}

class IssuesModel {
  final String title;
  final String subTitle;
  final String discription;
  final String subDiscription;
  final String treatment;
  final String subTreatment;

  IssuesModel({
    required this.title,
    required this.subTitle,
    required this.discription,
    required this.subDiscription,
    required this.treatment,
    required this.subTreatment,
  });
}

class MessagesModel {
  final String userM;
  final String botM;

  MessagesModel({required this.userM, required this.botM});
}
