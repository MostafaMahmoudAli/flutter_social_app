import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/social_register/cubit/social_register_states.dart';
import 'package:social_app/shared/componants/componants.dart';

import '../../shared/componants/constant.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/social_register_cubit.dart';

class SocialRegisterScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener:(context,state)
        {
          if(state is SocialRegisterErrorState)
          {
            showToast(
                text:state.error,
                state:ToastStates.error,
            );
          }
          if(state is SocialCreateUserSuccessState)
          {
            uId = state.uId;
            CacheHelper.saveData(
              key: "uId",
              value:state.uId,
            ).then((value)
            {

              navigateAndFinish(context, SocialLayoutScreen());
            });
          }
        },
        builder:(context,state)
        {
          return Scaffold(
            appBar:AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key:formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children:[
                        Text(
                          "REGISTER",
                          style:Theme.of(context).textTheme.headline5?.copyWith(
                              color:Colors.black,
                              fontWeight:FontWeight.w900,
                              fontSize:28.0.sp,
                          ),
                        ),
                         SizedBox(
                          height:20.0.h,
                        ),
                        Text(
                          "Register Now To Communicate With Your Friends",
                          style:Theme.of(context).textTheme.bodyText1?.copyWith(
                            color:Colors.grey,
                            fontWeight:FontWeight.w900,
                            fontSize:18.0.sp,
                          ),
                        ),
                         SizedBox(
                          height:30.0.h,
                        ),
                        defultFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validator: (String?value)
                            {
                              if(value!.isEmpty)
                              {
                                return "Name Must Not Be Empty";
                              }
                              return null;
                            },
                            prefix:Icons.person,
                            text: "name",
                        ),
                         SizedBox(
                          height:15.0.h,
                        ),
                        defultFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (String?value)
                            {
                              if(value!.isEmpty)
                              {
                                return "EmailAddress Must Not Be Empty";
                              }
                              return null;

                            },
                            prefix: Icons.email_outlined,
                            text: "EmailAddress",
                        ),
                         SizedBox(
                          height:15.0.h,
                        ),
                        defultFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (String?value)
                            {
                              if(value!.isEmpty)
                              {
                                return "Password Must Not Be Empty";
                              }
                              return null;
                            },
                            prefix: Icons.lock,
                            text:"Password",
                          isPassword:SocialRegisterCubit.get(context).isPassword,
                          suffix:SocialRegisterCubit.get(context).suffix,
                          onPressed:()
                          {
                            SocialRegisterCubit.get(context).changePasswordVisibility();
                          }
                        ),
                         SizedBox(
                          height:15.0.h,
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
                          prefix: Icons.phone_android_outlined,
                            text: "Phone",
                        ),
                         SizedBox(
                          height:30.0.h,
                        ),
                        defultButton(
                            function:()
                            {
                              if(formKey.currentState!.validate())
                              {
                                SocialRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                );
                              }
                            },
                          text:"register",
                          height:50.0.h,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
