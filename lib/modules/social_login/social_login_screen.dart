import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/social_login/cubit/login_cubit.dart';
import 'package:social_app/shared/componants/componants.dart';
import 'package:social_app/shared/componants/constant.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

import '../social_register/social_register_screen.dart';
import 'cubit/login_states.dart';

class SocialLoginScreen extends StatelessWidget{

  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context)=>SocialLoginCubit(),
        child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(

        listener:(context,state)
        {
          if(state is SocialLoginErrorState)
          {
            showToast(
                text: state.error,
                state:ToastStates.error
            );
          }
          if(state is  SocialLoginSuccessState)
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
            body:Center(
              child: SingleChildScrollView(
                child: Form(
                  key:formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
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
                          "Login Now To Communicate With Your Friends",
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
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator:(String?value)
                            {
                              if(value!.isEmpty)
                              {
                                return "Email Address Must Not Be Empty";
                              }
                              return null;
                            },
                            prefix: Icons.email_outlined,
                            text: "Email Address",
                        ),
                          SizedBox(
                          height:20.0.h,
                        ),
                        defultFormField(
                            controller:passwordController,
                            keyboardType:TextInputType.visiblePassword,
                            validator:(String?value)
                            {
                              if(value!.isEmpty)
                              {
                                return "Password Must Not Be Empty";
                              }
                              return null;
                            },
                            prefix:Icons.lock,
                            text: "password",
                            isPassword:SocialLoginCubit.get(context).isPassword,
                          suffix:SocialLoginCubit.get(context).suffix,
                          onPressed: ()
                          {
                            SocialLoginCubit.get(context).changePasswordVisibility();
                          }


                        ),
                         SizedBox(
                          height:20.0.h,
                        ),
                        defultButton(
                            function:()
                            {
                              if(formKey.currentState!.validate())
                              {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                );
                              }
                            },
                            text: "login",
                          height:40.0.h,
                        ),
                         SizedBox(
                          height:20.0.h,
                        ),
                        Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text(
                              "don't have an account ?",
                              style:Theme.of(context).textTheme.bodyText1,
                            ),
                            defultTextButton(

                              function:()
                              {
                                navigateTo(context, SocialRegisterScreen());
                              },
                              text:'REGISTER',
                            ),
                          ],
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
