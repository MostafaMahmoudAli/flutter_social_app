import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/shared/componants/componants.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';
import 'package:social_app/shared/styles/colors.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).getUserData();
    var userModel=SocialCubit.get(context).userModel;
    var nameController= TextEditingController();
    var phoneController= TextEditingController();
    var bioController= TextEditingController();
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state)
      {
        nameController.text=userModel!.name!;
        phoneController.text=userModel.phone!;
        bioController.text=userModel.bio!;
      },
      builder:(context,state)
      {
        return Scaffold(
          appBar:defaultAppBar(
            context:context,
            title:"Edit Profile",
            actions:[
              defultTextButton(
                  function: ()
                  {
                    SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        bio: bioController.text,
                        phone: phoneController.text,
                    );
                  },
                  text: "upData",
              ),
              SizedBox(
                width:10.0.w,
              ),
            ],
          ),
          body:Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics:const BouncingScrollPhysics(),
              child: Column(
                children: [
                  if(state is SocialLoadingUpDateUserDataState)const LinearProgressIndicator(),
                  if(state is SocialLoadingUpDateUserDataState)SizedBox(
                    height:15.0.h,
                  ),
                  Container(
                    height:270.0.h,
                    clipBehavior:Clip.none,
                    child: Stack(
                      alignment:AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                           alignment: AlignmentDirectional.topCenter,
                          child:Stack(
                            alignment:AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height:200.0.h,
                                width:double.infinity,
                                decoration:BoxDecoration(
                                  borderRadius:BorderRadius.circular(5.0.r),
                                  image:DecorationImage(
                                    fit:BoxFit.cover,
                                    image:SocialCubit.get(context).coverImage==null?
                                    NetworkImage(
                                      "${userModel!.cover}",
                                    ) :
                                    FileImage(SocialCubit.get(context).coverImage!) as ImageProvider,
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
                                        SocialCubit.get(context).getCoverImage();
                                      },
                                    icon:Icon(
                                      Icons.camera_alt_rounded,
                                      size:15.0.sp,
                                      color:lightColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment:AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius:70.0.r,
                               backgroundColor:Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius:66.0.r,
                                backgroundImage: SocialCubit.get(context).profileImage==null ?NetworkImage(
                                  "${userModel!.image}",
                                ) : FileImage(SocialCubit.get(context).profileImage!) as ImageProvider,
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(
                                horizontal:10.0.w,
                              ),
                              child: CircleAvatar(
                                radius:15.0.r,
                                backgroundColor:primarySwitchColor,
                                child:IconButton(
                                  onPressed:()
                                  {
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                  icon:Icon(
                                    Icons.camera_alt_rounded,
                                    size:15.0.sp,
                                    color:lightColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if(SocialCubit.get(context).profileImage !=null || SocialCubit.get(context).coverImage!=null)Padding(
                    padding: EdgeInsets.only(top:10.0.h,left: 10.0.w,right:10.0.w,),
                    child: Row(
                      children: [
                        if(SocialCubit.get(context).profileImage !=null)Expanded(
                          child: defultButton(
                              function: ()
                              {
                                SocialCubit.get(context).uploadProfileImage(
                                  name: nameController.text,
                                  bio: bioController.text,
                                  phone: phoneController.text,
                                );
                              },
                              text: "Upload Profile",
                            height:40.0.h,
                          ),
                        ),
                         SizedBox(width:10.0.w,),
                        if(SocialCubit.get(context).coverImage !=null)Expanded(
                          child: defultButton(
                              function: ()
                              {
                                SocialCubit.get(context).uploadCoverImage(
                                  name: nameController.text,
                                  bio: bioController.text,
                                  phone: phoneController.text,
                                );
                              },
                              text: "Upload Cover",
                              height:40.0.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                   SizedBox(
                    height:20.0.h,
                  ),
                  defultFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: (String?value)
                      {
                        if(value!.isEmpty)
                        {
                          return "Name must not be Empty";
                        }
                          return null;
                      },
                      prefix:Icons.person,
                      text: "Name",
                  ),
                    SizedBox(
                     height:10.0.h,
                   ),
                  defultFormField(
                    controller: bioController,
                    keyboardType: TextInputType.text,
                    validator: (String?value)
                    {
                      if(value!.isEmpty)
                      {
                        return "Bio Must Not Be Empty";
                      }
                      return null;
                    },
                    prefix:Icons.info_outlined,
                    text: "Bio",
                  ),
                    SizedBox(
                     height:10.0.h,
                   ),
                  defultFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    validator: (String?value)
                    {
                      if(value!.isEmpty)
                      {
                        return "Phone Must Not Be Empty";
                      }
                      return null;
                    },
                    prefix:Icons.phone_android_rounded,
                    text: "Phone",
                  ),


                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
