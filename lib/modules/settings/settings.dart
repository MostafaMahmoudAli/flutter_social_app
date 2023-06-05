import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/shared/componants/componants.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';

import '../edit_profile/edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    SocialCubit.get(context).getUserData();
    var userModel=SocialCubit.get(context).userModel;
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){},
      builder: (context,state)
      {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height:270.0.h,
                  child: Stack(
                    alignment:AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment:AlignmentDirectional.topCenter,
                        child: Container(
                          height:200.0.h,
                          width:double.infinity,
                          decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(5.0.r),
                            image:DecorationImage(
                              fit:BoxFit.cover,
                              image: NetworkImage(
                                "${userModel!.cover}",
                                // "https://img.freepik.com/free-photo/horizontal-shot-administrative-manger-sits-lotus-pose-floor-studies-contract_273609-18031.jpg?w=740&t=st=1670867380~exp=1670867980~hmac=c8572adcd3d42d86b15ed2dbfcd755f1ad904ec72672ab4b593936bc021ec588",
                              ),
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius:70.0.r,
                        backgroundColor:Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius:66.0.r,
                          backgroundImage:NetworkImage(
                            "${userModel.image}",
                            // "https://img.freepik.com/free-photo/surprised-positive-dark-skinned-lady-points-smart-phone-device-suggests-have-conversation-group-chat-glad-recieve-many-messages-congratulation-mailbox-has-overjoyed-look_273609-26221.jpg?w=740&t=st=1670862956~exp=1670863556~hmac=599f6e3b7036a0db20edd47a1a52b837929314f65d60207dff39db7d149ff2a7",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                 SizedBox(
                  height:5.0.h,
                ),
                Text(
                  "${userModel.name}",
                  // "UnKnown Woman",
                  style:Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height:3.0.h,),
                Text(
                  "${userModel.bio}",
                  // "bio...",
                  style:Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0.h),
                  child: Row(
                    children:[
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text(
                                "100",
                                style:Theme.of(context).textTheme.bodyText2,
                              ),
                              SizedBox(height:3.0.h,),
                              Text(
                                "Posts",
                                style:Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text(
                                "400",
                                style:Theme.of(context).textTheme.bodyText2,
                              ),
                              SizedBox(height:3.0.h,),
                              Text(
                                "Photos",
                                style:Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text(
                                "5K",
                                style:Theme.of(context).textTheme.bodyText2,
                              ),
                              SizedBox(height:3.0.h,),
                              Text(
                                "Followers",
                                style:Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text(
                                "500",
                                style:Theme.of(context).textTheme.bodyText2,
                              ),
                              SizedBox(height:3.0.h,),
                              Text(
                                "Following",
                                style:Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height:20.0.h,),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: (){},
                        child: const Text("Add Photo"),
                      ),
                    ),
                    SizedBox(width:10.0.w,),
                    OutlinedButton(
                      onPressed: ()
                      {
                        navigateTo(context, EditProfileScreen(),);
                      },
                      child: const Icon(Icons.edit,),
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
