class MessageModel
{
  String?senderId;
  String?receiverId;
  String?text;
  String?dateTime;
  String?messageImage;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.text,
    this.dateTime,
    this.messageImage,
  });

  MessageModel.fromJson(Map<String,dynamic>json)
  {
    senderId = json["senderId"];
    receiverId= json["receiverId"];
    text = json["text"];
    dateTime = json["dateTime"];
    messageImage = json["messageImage"];
  }

  Map<String,dynamic>toMap()
  {
    return {
      "senderId" :senderId,
      "receiverId":receiverId,
      "text" : text,
      "dateTime":dateTime,
      "messageImage":messageImage,
    };
  }


}