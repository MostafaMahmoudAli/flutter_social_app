import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/shared/componants/componants.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';

import '../../shared/cubit/social_states.dart';
import '../../shared/styles/colors.dart';

class AddNewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textController=TextEditingController();
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){},
      builder:(context,state)
      {
        return Scaffold(
          appBar:defaultAppBar(
            context: context,
            title:"Create Post",
            actions:[
              defultTextButton(
                function: ()
                {
                  if(SocialCubit.get(context).postImage==null)
                  {
                    SocialCubit.get(context).createNewPost(
                      text: textController.text,
                      dateTime:DateTime.now().toString(),
                    );
                  }else
                  {
                    SocialCubit.get(context).uploadPostImage(
                      text: textController.text,
                      dateTime: DateTime.now().toString(),
                    );
                  }
                },
                text: "Post",
              )
            ],
          ),
          body:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreateNewPostLoadingState)const LinearProgressIndicator(),
                if(state is SocialCreateNewPostLoadingState) SizedBox(
                  height:10.0.h,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius:30.0.r,
                      backgroundImage:NetworkImage(
                        "${SocialCubit.get(context).userModel!.image}",
                        // "https://img.freepik.com/free-photo/surprised-positive-dark-skinned-lady-points-smart-phone-device-suggests-have-conversation-group-chat-glad-recieve-many-messages-congratulation-mailbox-has-overjoyed-look_273609-26221.jpg?w=740&t=st=1670778647~exp=1670779247~hmac=7c45f0721c7cb3393411e83f80fb36ef388055c1ebbb6098d7fced1c977b8680",
                      ),
                    ),
                    SizedBox(width:10.0.w,),
                    Text(
                      "${SocialCubit.get(context).userModel!.name}",
                      // "UnKnown Woman",
                      style:TextStyle(
                        height:1.3.h,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    keyboardType:TextInputType.text,
                    maxLines:10,
                    decoration:const InputDecoration(
                        hintText:"Write What's On Your Mind ... ",
                        border:InputBorder.none
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postImage!=null) SizedBox(
                  height:10.0.h,
                ),
                if(SocialCubit.get(context).postImage!=null)Stack(
                  alignment:AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height:200.0.h,
                      width:double.infinity,
                      decoration:BoxDecoration(
                        borderRadius:BorderRadius.circular(5.0),
                        image:DecorationImage(
                          fit:BoxFit.cover,
                          image: FileImage(SocialCubit.get(context).postImage!),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: CircleAvatar(
                        radius:15.0.r,
                        backgroundColor:primarySwitchColor,
                        child:IconButton(
                          onPressed:()
                          {
                            SocialCubit.get(context).removePostImage();
                          },
                          icon:Icon(
                            Icons.close_outlined,
                            size:15.0.sp,
                            color:lightColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if(SocialCubit.get(context).postImage!=null) SizedBox(
                  height:10.0.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed:()
                        {
                          SocialCubit.get(context).pickPostImage();
                        },
                        child:Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                            ),
                            SizedBox(width: 5.0.w,),
                            Text(
                              "Add Photo",
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed:(){},
                        child:Text(
                          "# Tags",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}
