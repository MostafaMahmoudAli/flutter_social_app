abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

//getUser
class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{
  final String error;
  SocialGetUserErrorState(this.error);
}

//changeNavBar
class SocialChangeNavBarState extends SocialStates{}

//addPost
class SocialAddNewPostState extends SocialStates{}

//profileImagePicked
class SocialProfileImagePickedSuccessState extends SocialStates{}

class SocialProfileImagePickedErrorState extends SocialStates{}

//CoverImagePicked
class SocialCoverImagePickedSuccessState extends SocialStates{}

class SocialCoverImagePickedErrorState extends SocialStates {}

//uploadCoverImage
class SocialUploadProfileImageSuccessState extends SocialStates{}

class SocialUploadProfileImageErrorState extends SocialStates{
  final String error;
  SocialUploadProfileImageErrorState(this.error);
}

class SocialUploadProfileImageUrlErrorState extends SocialStates{
  final String error;
  SocialUploadProfileImageUrlErrorState(this.error);
}
//uploadCoverImage
class SocialUploadCoverImageSuccessState extends SocialStates{}

class SocialUploadCoverImageErrorState extends SocialStates{
  final String error;
  SocialUploadCoverImageErrorState(this.error);
}

class SocialUploadCoverImageUrlErrorState extends SocialStates{
  final String error;
  SocialUploadCoverImageUrlErrorState(this.error);
}
// updateUserData
class SocialLoadingUpDateUserDataState extends SocialStates {}

class SocialUpDateUserDataErrorState extends SocialStates {
  final String error;

  SocialUpDateUserDataErrorState(this.error);
}

// pickPostImage
class SocialPickPostImageSuccessState extends SocialStates {}

class SocialPickPostImageErrorState extends SocialStates {}

//uploadPostImage
class SocialUploadPostImageSuccessState extends SocialStates{}

class SocialUploadPostImageUrlErrorState extends SocialStates{
  final String error;
  SocialUploadPostImageUrlErrorState(this.error);
}
class SocialUploadPostImageErrorState extends SocialStates{
  final String error;
  SocialUploadPostImageErrorState(this.error);
}

//createNewPost
class SocialCreateNewPostLoadingState extends SocialStates{}

class SocialCreateNewPostSuccessState extends SocialStates{}

class SocialCreateNewPostErrorState extends SocialStates{
  final String error;
  SocialCreateNewPostErrorState(this.error);
}

// removePostImage
class SocialRemovePostImageState extends SocialStates{}

// getPosts
class SocialGetNewPostsLoadingState extends SocialStates{}

class SocialGetNewPostsSuccessState extends SocialStates{}

class SocialGetNewPostsErrorState extends SocialStates{
  final String error;
  SocialGetNewPostsErrorState(this.error);
}

//postsLike
class SocialLikeNewPostsSuccessState extends SocialStates{}

class SocialLikeNewPostsErrorState extends SocialStates{
  final String error;
  SocialLikeNewPostsErrorState(this.error);
}

//postsComment
class SocialCommentNewPostsSuccessState extends SocialStates{}

class SocialCommentNewPostsErrorState extends SocialStates{
  final String error;
  SocialCommentNewPostsErrorState(this.error);
}

//getAllUsers
class SocialGetAllUsersLoadingState extends SocialStates{}

class SocialGetAllUsersSuccessState extends SocialStates{}

class SocialGetAllUsersErrorState extends SocialStates{
  final String error;
  SocialGetAllUsersErrorState(this.error);
}

// sendMessage
class SocialSendMessageSuccessState extends SocialStates{}

class SocialSendMessageErrorState extends SocialStates{
  final String error;
  SocialSendMessageErrorState(this.error);
}

class SocialSendFriendMessageSuccessState extends SocialStates{}

class SocialSendFriendMessageErrorState extends SocialStates{
  final String error;
  SocialSendFriendMessageErrorState(this.error);
}

//getMessage
class SocialGetMessagesSuccessState extends SocialStates{}

//pickedMessageImage
class SocialPickedMessageImageSuccessState extends SocialStates{}

class SocialPickedMessageImageErrorState extends SocialStates{}

//getMessageImage
class SocialGetMessageImageLoadingState extends SocialStates{}

class SocialGetMessageImageSuccessState extends SocialStates{}

class SocialGetMessageImageErrorState extends SocialStates{
  final String error;
  SocialGetMessageImageErrorState(this.error);
}

class SocialGetMessageImageUrlErrorState extends SocialStates{
  final String error;
  SocialGetMessageImageUrlErrorState(this.error);
}







