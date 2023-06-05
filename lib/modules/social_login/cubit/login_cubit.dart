import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>{

  SocialLoginCubit():super(SocialLoginInitialState());

  static SocialLoginCubit get(context)=>BlocProvider.of(context);

  bool isPassword = true;

  IconData suffix = Icons.visibility;

void changePasswordVisibility()
{
  isPassword = !isPassword;
  suffix = isPassword ? Icons.visibility :Icons.visibility_off_rounded;
  emit(SocialLoginChangePasswordVisibilityState());
}

void userLogin({
  required String email,
  required String password,
})
{
  emit(SocialLoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
  ).then((value)
  {
    print(value.user!.emailVerified);
    print(value.user!.email);
    print(value.user!.uid);
    emit(SocialLoginSuccessState(value.user!.uid));
  }).catchError((error)
  {
    emit(SocialLoginErrorState(error.toString()));
  });
}
}