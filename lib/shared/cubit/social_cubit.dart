import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/social_user_model/social_user_model.dart';
import 'package:social_app/modules/chats/chats.dart';
import 'package:social_app/modules/news_feed/news_feed.dart';
import 'package:social_app/modules/users/users.dart';
import 'package:social_app/shared/cubit/social_states.dart';
import '../../models/messages_model/messages_model.dart';
import '../../models/social_creat_post_model/social_post_model.dart';
import '../../modules/add_new_post/add_new_post.dart';
import '../../modules/settings/settings.dart';
import '../componants/constant.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates>{

  SocialCubit() : super(SocialInitialState());

 static SocialCubit get(context)=>BlocProvider.of(context);

 int currentIndex = 0;

 changeBottomNav(int index)
 {
   if(index==2)
   {
     emit(SocialAddNewPostState());
   }else
   {
     currentIndex = index ;
     emit(SocialChangeNavBarState());
   }
 }

 List<String>titles=[
   "Home",
   "Chats",
   "Add Post",
   "Users",
   "Settings",
 ];

 List<Widget>screens=[
   NewsFeedScreen(),
   ChatsScreen(),
   AddNewPostScreen(),
   UsersScreen(),
   SettingsScreen(),
 ];

List<BottomNavigationBarItem>bottomNavBar= [
  BottomNavigationBarItem(
    icon:Icon(
        Icons.home_filled,
    ),
    label:"Home",
  ),
  BottomNavigationBarItem(
    icon:Icon(
      Icons.chat_outlined,
    ),
    label:"Chats",
  ),
  BottomNavigationBarItem(
    icon:Icon(
      Icons.upload_file_outlined,
    ),
    label:"Add Post",
  ),
  BottomNavigationBarItem(
    icon:Icon(
      Icons.person,
    ),
    label:"Users",
  ),
  BottomNavigationBarItem(
    icon:Icon(
      Icons.settings,
    ),
    label:"Settings",
  ),
];


  SocialUserModel?userModel;

  void getUserData()
  {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection("users").doc(uId).get().then((value)
    {
      print("hhhhhhhhhhhhhhhhhhh");
      print(value.data()!);
      userModel=SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error)
    {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  File?profileImage;

 final ImagePicker?pickerProfile =  ImagePicker();

  Future<void>getProfileImage()async
  {
    XFile?pickedFile = await pickerProfile!.pickImage(source: ImageSource.gallery);

    if(pickedFile !=null)
    {
      profileImage= File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }else
    {
      print("No Image Selected");
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File?coverImage;

  final ImagePicker?pickerCover = ImagePicker();

  Future<void>getCoverImage()async
  {
    XFile?pickedFile = await pickerCover!.pickImage(source: ImageSource.gallery);

    if(pickedFile!=null)
    {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    }else
    {
      emit(SocialCoverImagePickedErrorState());
    }
  }

  String?profileImageURL;

 void uploadProfileImage({
   required String name,
   required String phone,
   required String bio,
})
 {
   emit(SocialLoadingUpDateUserDataState());
   firebase_storage.FirebaseStorage.instance.ref()
       .child("users/${Uri.file(profileImage!.path).pathSegments.last}")
       .putFile(profileImage!).then((value)
   {
     value.ref.getDownloadURL().then((value)
     {
       profileImageURL=value;
       updateUser(
           name: name,
           bio: bio,
           phone: phone,
           profile:profileImageURL
       );

       print(value);
       emit(SocialUploadProfileImageSuccessState());
     }).catchError((error)
     {
       emit(SocialUploadProfileImageUrlErrorState(error.toString()));
     });
   }).catchError((error)
   {
     emit(SocialUploadProfileImageErrorState(error.toString()));
   });
 }

 String?coverImageURL;

 void uploadCoverImage({
   required String name,
   required String bio,
   required String phone,
})
 {
   emit(SocialLoadingUpDateUserDataState());
   firebase_storage.FirebaseStorage.instance.ref()
       .child("users/${Uri.file(coverImage!.path).pathSegments.last}")
       .putFile(coverImage!).then((value)
   {
     value.ref.getDownloadURL().then((value)
     {
       coverImageURL=value;
      updateUser(
          name: name,
          bio: bio,
          phone: phone,
          cover: coverImageURL,
      );
       print(value);
      emit(SocialUploadCoverImageSuccessState());
     }).catchError((error)
     {
       emit(SocialUploadCoverImageUrlErrorState(error.toString()));
     });
   }).catchError((error)
   {
     emit(SocialUploadCoverImageErrorState(error.toString()));
   });
 }

 void updateUser({
   required String name,
   required String bio,
   required String phone,
   String?cover,
   String?profile,
})
 {
   emit(SocialLoadingUpDateUserDataState());

   SocialUserModel model = SocialUserModel(
     image:profile??userModel!.image,
     uId:userModel!.uId,
     email:userModel!.email,
     cover:cover??userModel!.cover,
     phone:phone,
     name:name,
     bio:bio,
     isEmailVerified:false,
   );

   FirebaseFirestore.instance.collection("users")
       .doc(uId)
       .update(model.toMap())
       .then((value)
   {
     getUserData();
   })
       .catchError((error)
   {
     emit(SocialUpDateUserDataErrorState(error.toString()));
   });
 }

 File?postImage;

 final ImagePicker?postImagePicker = ImagePicker();

 Future<void>pickPostImage()async
 {
   XFile?pickedFile = await postImagePicker!.pickImage(source: ImageSource.gallery);

   if(pickedFile!=null)
   {
     postImage=File(pickedFile.path);
     emit(SocialPickPostImageSuccessState());
   }else
   {
     emit(SocialPickPostImageErrorState());
   }
 }

 String?postImageURL;

 void uploadPostImage({
   required String text,
   required String dateTime,
})
 {
   emit(SocialCreateNewPostLoadingState());

   firebase_storage.FirebaseStorage.instance.ref()
       .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
       .putFile(postImage!)
       .then((value)
   {
     value.ref.getDownloadURL()
         .then((value)
     {
       postImageURL=value;
       createNewPost(
         text:text,
         dateTime:dateTime,
         postImage:value,
       );
       emit(SocialUploadPostImageSuccessState());
     }).catchError((error)
     {
       emit(SocialUploadPostImageUrlErrorState(error.toString()));
     });
   }).catchError((error)
   {
     emit(SocialUploadPostImageErrorState(error.toString()));
   });
 }

 void createNewPost({
   required String text,
   required String dateTime,
   String?postImage,
})
 {

   SocialCreatePost postModel = SocialCreatePost(
     name:userModel!.name,
     uId:userModel!.uId,
     image:userModel!.image,
     text:text,
     dateTime: dateTime,
     postImage:postImage??"",
   );

   emit(SocialCreateNewPostLoadingState());

   FirebaseFirestore.instance.collection("posts")
       .add(postModel.toMap())
       .then((value)
   {
     emit(SocialCreateNewPostSuccessState());
   }).catchError((error)
   {
     emit(SocialCreateNewPostErrorState(error.toString()));
   });
 }

 void removePostImage()
 {
   postImage=null;
   emit(SocialRemovePostImageState());
 }

 List<SocialCreatePost>?posts;

 List<String>postsId=[];

 List<int>likes=[];

  List<int>comments=[];

 void getPosts()
 {
   emit(SocialGetNewPostsLoadingState());

   posts=[];

   FirebaseFirestore.instance.collection("posts")
       .get()
       .then((value)
   {
     value.docs.forEach((element)
     {
       element.reference
           .collection("comments")
           .get()
           .then((value)
       {
         comments.add(value.docs.length);
       })
           .catchError((error){});
       element.reference
           .collection("likes")
           .get()
           .then((value)
       {
         likes.add(value.docs.length);

       }).catchError((error)
       {

       });
       postsId.add(element.id);
       posts!.add(SocialCreatePost.fromJson(element.data()));

       emit(SocialGetNewPostsSuccessState());
     });
   }).catchError((error)
   {
     emit(SocialGetNewPostsErrorState(error.toString()));
   });
 }

 void postsLike(String?postId)
 {
   FirebaseFirestore.instance
       .collection("posts")
       .doc(postId)
       .collection("likes")
       .doc(userModel!.uId)
       .set({
     "like":true,
   }).then((value)
   {
     emit(SocialLikeNewPostsSuccessState());
   }).catchError((error)
   {
     emit(SocialLikeNewPostsErrorState(error.toString()));
   });
 }

 void postsComment(String?postId)
 {
   FirebaseFirestore.instance
       .collection("posts")
       .doc(postId)
       .collection("comments")
       .doc(userModel!.uId)
       .set({
     "comment":true,
   }).then((value)
   {
     emit(SocialCommentNewPostsSuccessState());
   }).catchError((error)
   {
     emit(SocialCommentNewPostsErrorState(error.toString()));
   });
 }

 List<SocialUserModel>?users;

 void getAllUsers()
 {
   emit(SocialGetAllUsersLoadingState());

   users=[];

   FirebaseFirestore.instance
       .collection("users")
       .get()
       .then((value)
   {
     value.docs.forEach((element)
     {
       if(element.data()["uId"] != userModel!.uId)
       {
         users!.add(SocialUserModel.fromJson(element.data()));
       }

     });
     emit(SocialGetAllUsersSuccessState());
   }).catchError((error)
   {
     emit(SocialGetAllUsersErrorState(error.toString()));
   });
 }

 void sendMessage({
   required String?receiverId,
   String?text,
   required String datetime,
   String?messageImage,
})
 {
   MessageModel model =MessageModel(
     senderId:userModel!.uId,
     receiverId:receiverId,
     dateTime:datetime,
     text:text,
     messageImage:messageImage,
   );

   //setMyChat
   FirebaseFirestore.instance
       .collection("users")
   .doc(userModel!.uId)
   .collection("chats")
   .doc(receiverId)
   .collection("messages")
   .add(model.toMap())
   .then((value)
   {
     emit(SocialSendMessageSuccessState());
   })
   .catchError((error)
   {
     emit(SocialSendMessageErrorState(error.toString()));
   });

   //setFriendChat
   FirebaseFirestore.instance
   .collection("users")
   .doc(receiverId)
   .collection("chats")
   .doc(userModel!.uId)
   .collection("messages")
   .add(model.toMap())
   .then((value)
   {
     emit(SocialSendFriendMessageSuccessState());
   })
   .catchError((error)
   {
     emit(SocialSendFriendMessageErrorState(error.toString()));
   });
 }

  List<MessageModel>messages=[];

 void getMessages({required String?receiverId,})
 {

   FirebaseFirestore.instance
       .collection("users")
       .doc(userModel!.uId)
       .collection("chats")
       .doc(receiverId)
       .collection("messages")
       .orderBy("dateTime")
       .snapshots()
       .listen((event)
   {
     messages=[];
     event.docs.forEach((element)
     {
       messages.add(MessageModel.fromJson(element.data()));
     });

     emit(SocialGetMessagesSuccessState());
   });
 }

 File?messageImage;

 final ImagePicker?messageImagePicker=ImagePicker();

 void pickMessageImage({
   required String receiverId,
   required String datetime,
 })async
 {
   XFile?pickedFile= await messageImagePicker!.pickImage(source:ImageSource.gallery,);

   if(pickedFile!=null)
   {
     messageImage=File(pickedFile.path);
     uploadMessageImage(
       datetime:datetime,
       receiverId:receiverId,
     );
     emit(SocialPickedMessageImageSuccessState());
   }else
   {
     emit(SocialPickedMessageImageErrorState());
   }
 }

 String?chatMessageImage;

 void uploadMessageImage({
    required String receiverId
   ,required String datetime
 })
 {
   emit(SocialGetMessageImageLoadingState());

   firebase_storage.FirebaseStorage.instance
   .ref()
   .child("messages/${Uri.file(messageImage!.path).pathSegments.last}")
   .putFile(messageImage!)
   .then((value)
   {
     value.ref.getDownloadURL().then((value)
     {
       chatMessageImage=value;
       sendMessage(
           receiverId: receiverId,
           datetime: datetime,
         messageImage: chatMessageImage,
       );
       emit(SocialGetMessageImageSuccessState());
     }).catchError((error)
     {
       emit(SocialGetMessageImageUrlErrorState(error.toString()));
     });

   })
   .catchError((error)
   {
     emit(SocialGetMessageImageErrorState(error.toString()));
   });
 }
}