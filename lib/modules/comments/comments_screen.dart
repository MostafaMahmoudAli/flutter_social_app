import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/shared/componants/componants.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';

class CommentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var commentController= TextEditingController();
    int index=0;
    return BlocConsumer<SocialCubit,SocialStates>(
       listener:(context,state){},
    builder: (context,state){
         return Scaffold(
           appBar:defaultAppBar(
               context: context,
             title:"Comments",
           ),
           body:Padding(
             padding: const EdgeInsets.all(10.0),
             child: Column(
               children: [
                 Expanded(
                   child: ListView.separated(
                     physics:const BouncingScrollPhysics(),
                       itemBuilder:(context,index)=>commentsItemBuilder() ,
                       separatorBuilder: (context,index)=> SizedBox(height:10.0.h,),
                       itemCount: 20,

                   ),
                 ),
                 TextFormField(
                   controller:commentController,
                   keyboardType:TextInputType.text,
                   decoration:InputDecoration(
                     hintText:"Write a Comment",
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

Widget commentsItemBuilder()=>Align(
  alignment:AlignmentDirectional.centerStart,
  child: Container(
    padding:EdgeInsets.symmetric(vertical: 5.0.h, horizontal:10.0.w,),
    decoration:BoxDecoration(
        color:Colors.grey[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd:Radius.circular(10.0),
          topStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
        )
    ),
    child: Text(
      "Hello",
    ),
  ),
);

