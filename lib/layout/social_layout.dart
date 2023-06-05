import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/add_new_post/add_new_post.dart';
import 'package:social_app/shared/componants/componants.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';

class SocialLayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).getUserData();
    var cubit = SocialCubit.get(context);
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state)
      {
        if(state is SocialAddNewPostState)
        {
          navigateTo(context,AddNewPostScreen());
        }
      },
      builder:(context,state)
      {
        return Scaffold(
          appBar:AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style:Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),
            ),
            actions: [
              IconButton(
                  onPressed:(){},
                  icon:Icon(
                    Icons.notifications,
                  ),
              ),
              IconButton(
                onPressed:(){},
                icon:Icon(
                  Icons.search_outlined,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar:BottomNavigationBar(
            items:cubit.bottomNavBar,
            currentIndex:cubit.currentIndex,
            onTap:(int index)
            {
              cubit.changeBottomNav(index);
            },
          ),
        );
      }
    );
  }
}

Widget verifiedBar()=>   Column(
  children: [
    Container(
      color:Colors.amber.withOpacity(0.8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0),
        child: Row(
          children:[
            const Icon(
              Icons.info_outline,
            ),
            const SizedBox(
              width:5.0,
            ),
            Text(
              "Please verify Your Email Address",
              style:TextStyle(
                fontWeight:FontWeight.bold,
              ),
            ),
            Spacer(),
            defultTextButton(
              function: ()
              {
                FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value)
                {
                  showToast(text: "Check Your Mail", state:ToastStates.success);
                }).catchError((error){});
              },
              text: "Send",
            ),
          ],
        ),
      ),
    ),
  ],
);