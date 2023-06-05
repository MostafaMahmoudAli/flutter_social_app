import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/shared/cubit/social_states.dart';
import 'package:social_app/shared/styles/colors.dart';
import '../../models/messages_model/messages_model.dart';
import '../../models/social_user_model/social_user_model.dart';
import '../../shared/cubit/social_cubit.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel userModel;
  ChatDetailsScreen(this.userModel);
  @override
  Widget build(BuildContext context) {

    SocialCubit.get(context).getMessages(receiverId: userModel.uId);
    var messageController=TextEditingController();
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){},
      builder: (context,state)
      {
        return Scaffold(
          appBar:AppBar(
            titleSpacing:0.0,
            title:Row(
              children: [
                CircleAvatar(
                  radius:30.0.r,
                  backgroundImage:NetworkImage(
                     "${userModel.image}",
                    //   "${SocialCubit.get(context).userModel!.name}",
                    // "https://img.freepik.com/free-photo/surprised-positive-dark-skinned-lady-points-smart-phone-device-suggests-have-conversation-group-chat-glad-recieve-many-messages-congratulation-mailbox-has-overjoyed-look_273609-26221.jpg?w=740&t=st=1670778647~exp=1670779247~hmac=7c45f0721c7cb3393411e83f80fb36ef388055c1ebbb6098d7fced1c977b8680",
                  ),
                ),
                SizedBox(width:10.0.w,),
                Text(
                  "${userModel.name}",
                  // "${SocialCubit.get(context).userModel!.name}",
                  // "UnKnown Woman",
                  style:TextStyle(
                    height:1.3.h,
                  ),
                ),
              ],
            ),

          ),
          body:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    physics:const BouncingScrollPhysics(),
                      itemBuilder:(context,index)
                      {
                        if(SocialCubit.get(context).userModel!.uId==SocialCubit.get(context).messages[index].senderId)
                        {
                          return sendMyMessage(SocialCubit.get(context).messages[index],);
                        }
                        return sendFriendMessage(SocialCubit.get(context).messages[index],);
                      },
                      separatorBuilder: (context,index)=> SizedBox(height:15.0.h,),
                      itemCount:SocialCubit.get(context).messages.length,
                  ),
                ),
                Container(
                  clipBehavior:Clip.antiAliasWithSaveLayer,
                  decoration:BoxDecoration(
                    border:Border.all(
                      color:Colors.grey[300]!,
                      width:2.0.w,
                    ),
                    borderRadius:BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller:messageController,
                          decoration:InputDecoration(
                            border:InputBorder.none,
                            hintText:"Type Your Message Here ...",
                          ),
                        ),
                      ),
                      Container(
                        height:40.0.h,
                        width:40.0.w,
                        color:Colors.grey.withOpacity(.7),
                        child: IconButton(
                          onPressed: ()
                          {
                            SocialCubit.get(context).pickMessageImage(
                              receiverId:userModel.uId!,
                              datetime:DateTime.now().toString(),
                            );
                          },
                          icon:Icon(
                            Icons.image_outlined,
                            color:Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width:5.0.w,
                      ),
                      Container(
                        height:50.0.h,
                        color:primarySwitchColor,
                        child: MaterialButton(
                          onPressed:()
                          {
                            SocialCubit.get(context).sendMessage(
                                receiverId: userModel.uId,
                                text: messageController.text,
                                datetime:DateTime.now().toString(),
                            );
                            messageController.clear();
                          },
                          minWidth:1.5.w,
                          child:Icon(
                            Icons.send_outlined,
                            color:Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget sendFriendMessage(MessageModel friendModel)=>Align(
  alignment:AlignmentDirectional.centerStart,
  child: friendModel.messageImage!= null ?
  Stack(
    alignment:AlignmentDirectional.topEnd,
    children: [
      Container(
        height:200.0.h,
        width:double.infinity,
        decoration:BoxDecoration(
          borderRadius:BorderRadius.circular(5.0),
          image:DecorationImage(
            fit:BoxFit.cover,
            image:NetworkImage(friendModel.messageImage!),
            //FileImage(SocialCubit.get(context).messageImage!),
          ),
        ),
      ),
    ],
  ) :
  Container(
    padding:EdgeInsets.symmetric(vertical: 5.0.h, horizontal:10.0.w,),
    decoration:BoxDecoration(
        color:Colors.grey[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd:Radius.circular(10.0.r),
          topStart: Radius.circular(10.0.r),
          topEnd: Radius.circular(10.0.r),
        )
    ),
    child: Text(
      friendModel.text!,
    ),
  ),
);

Widget sendMyMessage(MessageModel myModel)=>Align(
  alignment:AlignmentDirectional.bottomEnd,
  child:myModel.messageImage==null?
  Container(
    padding:EdgeInsets.symmetric(vertical: 5.0.h, horizontal:10.0.w,),
    decoration:BoxDecoration(
        color:primarySwitchColor.withOpacity(.4),
        borderRadius: BorderRadiusDirectional.only(
          bottomStart:Radius.circular(10.0.r),
          topStart: Radius.circular(10.0.r),
          topEnd: Radius.circular(10.0.r),
        ),
    ),
    child: Text(
      myModel.text!,
    ),
  ) :
  Stack(
    alignment:AlignmentDirectional.topEnd,
    children: [
      Container(
        height:200.0.h,
        width:double.infinity,
        decoration:BoxDecoration(
          borderRadius:BorderRadius.circular(5.0.r),
          image:DecorationImage(
            fit:BoxFit.cover,
            image:NetworkImage(myModel.messageImage!),
            // FileImage(SocialCubit.get(context).messageImage!),
          ),
        ),
      ),
    ],
  ),
);
