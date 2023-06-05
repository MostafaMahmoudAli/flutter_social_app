import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/shared/componants/componants.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';

import '../../models/social_user_model/social_user_model.dart';
import '../chat_details/chat_details_screen.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).getAllUsers();
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder:  (context,state)
    {
      return SocialCubit.get(context).users!.length>0 ?
      ListView.separated(
          physics:const BouncingScrollPhysics(),
          itemBuilder: (context,index)=>chatsItemBuilder(SocialCubit.get(context).users![index],context),
          separatorBuilder:  (context,index)=>myDivider(),
          itemCount: SocialCubit.get(context).users!.length,
      ) :
      const Center(child: CircularProgressIndicator());
    },
    );
  }
}

Widget chatsItemBuilder(SocialUserModel model,context)=>InkWell(
  onTap:()
  {
    navigateTo(context,ChatDetailsScreen(model));
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius:30.0.r,
          backgroundImage:NetworkImage(
             "${model.image}",
            // "https://img.freepik.com/free-photo/surprised-positive-dark-skinned-lady-points-smart-phone-device-suggests-have-conversation-group-chat-glad-recieve-many-messages-congratulation-mailbox-has-overjoyed-look_273609-26221.jpg?w=740&t=st=1670778647~exp=1670779247~hmac=7c45f0721c7cb3393411e83f80fb36ef388055c1ebbb6098d7fced1c977b8680",
          ),
        ),
        SizedBox(width:10.0.w,),
        Text(
           "${model.name}",
          // "UnKnown Woman",
          style:TextStyle(
            height:1.3.h,
          ),
        ),
      ],
    ),
  ),
);
