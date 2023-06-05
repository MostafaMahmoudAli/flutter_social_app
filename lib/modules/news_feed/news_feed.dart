import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/models/social_creat_post_model/social_post_model.dart';
import 'package:social_app/shared/componants/componants.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';
import 'package:social_app/shared/styles/colors.dart';

import '../comments/comments_screen.dart';

class NewsFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    SocialCubit.get(context).getPosts();
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){},
      builder:(context,state)
      {
        return SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child:Column(
            children: [
              Card(
                clipBehavior:Clip.antiAliasWithSaveLayer,
                elevation:5.0,
                margin:EdgeInsets.all(8.0),
                child:Stack(
                  alignment:AlignmentDirectional.bottomEnd,
                  children:[
                    Image(
                      image:NetworkImage(
                        "https://img.freepik.com/free-photo/horizontal-shot-good-looking-afro-american-woman-feels-very-happy-holds-modern-smartphone-hand-wears-stereo-headphones-points-aside-blank-space-blue-background-leisure-concept_273609-45236.jpg?w=740&t=st=1670776982~exp=1670777582~hmac=2275140649ec7ec94263d9a4dd7e95405c49a193d76a475025917501b4470776",
                      ),
                      height: 210.0.h,
                      width:double.infinity,
                      fit:BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Communicate With Freinds",
                        style:Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize:18.0.sp,
                            color:Colors.black54,
                            fontWeight:FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SocialCubit.get(context).posts!.length > 0?
              ListView.separated(
                  shrinkWrap:true,
                  physics:const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index)=>buildPostItem(SocialCubit.get(context).posts![index],context,index),
                  separatorBuilder: (context,index)=> SizedBox(height:8.0.h,),
                  itemCount: SocialCubit.get(context).posts!.length,
              ) :
              const Center(child: CircularProgressIndicator()),
               SizedBox(height:10.0.h,),
            ],
          ),
        );
      },
    );
  }
}

Widget buildPostItem(SocialCreatePost model,context,index)=> Card(
  color:Theme.of(context).scaffoldBackgroundColor,
  clipBehavior:Clip.antiAliasWithSaveLayer,
  elevation:5.0,
  margin: EdgeInsets.symmetric(horizontal:8.0.w),
  child:Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius:30.0.r,
              backgroundImage:NetworkImage(
                // "${model.image}",
                 "${SocialCubit.get(context).userModel!.image}",
                // "https://img.freepik.com/free-photo/surprised-positive-dark-skinned-lady-points-smart-phone-device-suggests-have-conversation-group-chat-glad-recieve-many-messages-congratulation-mailbox-has-overjoyed-look_273609-26221.jpg?w=740&t=st=1670778647~exp=1670779247~hmac=7c45f0721c7cb3393411e83f80fb36ef388055c1ebbb6098d7fced1c977b8680",
              ),
            ),
            SizedBox(width:20.0.w,),
            Expanded(
              child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${SocialCubit.get(context).userModel!.name}",
                        // "${model.name}",
                        // "UnKnown Woman",
                        style:TextStyle(
                          height:1.3.h,
                        ),
                      ),
                      SizedBox(width:5.0.w,),
                      Icon(
                        Icons.check_circle,
                        color:primarySwitchColor,
                        size:18.0.sp,
                      ),
                    ],
                  ),
                  Text(
                    "${model.dateTime}",
                    // "December 11,2022 at 7:24 pm",
                    style:Theme.of(context).textTheme.caption!.copyWith(
                      height:1.3.w,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width:20.0.w,),
            IconButton(
              onPressed: (){},
              icon:Icon(
                Icons.more_horiz_outlined,
              ),
            ),
          ],
        ),
        Padding(
          padding:  EdgeInsets.symmetric(
            vertical:12.0.h,
          ),
          child: Container(
            height:1.0.h,
            width: double.infinity,
            color:Colors.grey[300],
          ),
        ),
        Text(
          "${model.text}",
          // "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",
          style:Theme.of(context).textTheme.subtitle1,
        ),
        Container(
          width:double.infinity,
          child: Wrap(
            children:
            [
              Padding(
                padding:EdgeInsetsDirectional.only(
                  end:10.0.w,
                ),
                child: Container(
                  child:MaterialButton(
                    onPressed: (){},
                    height:20.0.h,
                    minWidth:1.0.w,
                    padding:EdgeInsets.zero,
                    child:Text(
                      "#Software",
                      style:TextStyle(
                        color:primarySwitchColor,
                      ),
                    ),
                  ),
                  height:20.0.h,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  end:10.0.w,
                ),
                child: Container(
                  height:20.0.h,
                  child: MaterialButton(
                    onPressed: (){},
                    height:20.0.h,
                    minWidth:1.0.w,
                    padding:EdgeInsets.zero,
                    child:Text(
                      "#Software Developments",
                      style:TextStyle(
                        color:primarySwitchColor,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  end:10.0.w,
                ),
                child: Container(
                  height:20.0.h,
                  child: MaterialButton(
                    onPressed: (){},
                    height:20.0.h,
                    minWidth:1.0.w,
                    padding:EdgeInsets.zero,
                    child:Text(
                      "#Dart Language",
                      style:TextStyle(
                        color:primarySwitchColor,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  end:10.0.w,
                ),
                child: Container(
                  height:25.0.h,
                  child: MaterialButton(
                    onPressed: (){},
                    height:20.0.h,
                    minWidth:1.0.w,
                    padding:EdgeInsets.zero,
                    child:Text(
                      "#Flutter",
                      style:TextStyle(
                        color:primarySwitchColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if(model.postImage!= "")Padding(
          padding: EdgeInsets.only(top: 15.0.h,),
          child: Container(
            height:200.0.h,
            width:double.infinity,
            decoration:BoxDecoration(
              borderRadius:BorderRadius.circular(5.0.r),
              image:DecorationImage(
                fit:BoxFit.cover,
                image: NetworkImage(
                  "${model.postImage}"
                  // "https://img.freepik.com/free-photo/joyful-black-author-works-writing-new-book-readers_273609-28047.jpg?t=st=1670786865~exp=1670787465~hmac=2625dc8a74622d0908d876372efc109bbb72d18c0f13df9c5d22e5887ac7709b",
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children:[
              Expanded(
                child: InkWell(
                  onTap: (){},
                  child: Row(
                    children:[
                      Icon(
                        Icons.recommend,
                        color:primarySwitchColor,
                      ),
                      SizedBox(width:5.0.w,),
                      Text(
                         // "0",
                          "${SocialCubit.get(context).likes[index]}",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: ()
                  {
                    SocialCubit.get(context).postsComment(SocialCubit.get(context).postsId[index]);
                  },
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.end,
                    children:[
                      Icon(
                        Icons.comment_sharp,
                        color:primarySwitchColor,
                      ),
                      SizedBox(width:5.0.w,),
                      Text(
                        "${SocialCubit.get(context).comments[index]}",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom:10.0.h,
          ),
          child: Container(
            height:1.0.h,
            width: double.infinity,
            color:Colors.grey[300],
          ),
        ),
        Row(
          children:
          [
            Expanded(
              child: InkWell(
                onTap:()
                {
                  navigateTo(context, CommentsScreen());
                },
                child: Row(
                  children:
                  [
                    CircleAvatar(
                      radius:20.0.r,
                      backgroundImage:NetworkImage(
                         "${SocialCubit.get(context).userModel!.image}",
                        // "${model.image}",
                        // "https://img.freepik.com/free-photo/surprised-positive-dark-skinned-lady-points-smart-phone-device-suggests-have-conversation-group-chat-glad-recieve-many-messages-congratulation-mailbox-has-overjoyed-look_273609-26221.jpg?w=740&t=st=1670778647~exp=1670779247~hmac=7c45f0721c7cb3393411e83f80fb36ef388055c1ebbb6098d7fced1c977b8680",
                      ),
                    ),
                    SizedBox(width: 5.0.w,),
                    Text(
                      "Write a Comment",
                      style:Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: ()
              {
                SocialCubit.get(context).postsLike( SocialCubit.get(context).postsId[index]);
              },
              child: Row(
                children:[
                  Icon(
                    Icons.recommend,
                    color:primarySwitchColor,
                  ),
                  SizedBox(width:5.0.w,),
                  Text(
                    "Like",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ],
        ),

      ],
    ),
  ),
);
