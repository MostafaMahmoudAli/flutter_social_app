class SocialCreatePost
{
  String?name;
  String?image;
  String?uId;
  String?text;
  String?postImage;
  String?dateTime;

  SocialCreatePost({
    this.name,
    this.image,
    this.uId,
    this.text,
    this.postImage,
    this.dateTime,
  });

  SocialCreatePost.fromJson(Map<String,dynamic>json)
  {
    name = json["name"];
    image= json["image"];
    uId = json["uId"];
    text = json["text"];
    postImage = json["postImage"];
    dateTime = json["dateTime"];
  }

  Map<String,dynamic>toMap()
  {
    return {
      "name" :name,
      "image":image,
      "uId": uId,
      "text" : text,
      "postImage" : postImage,
      "dateTime":dateTime,
    };
  }
}