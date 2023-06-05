import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_register/cubit/social_register_states.dart';

import '../../../models/social_user_model/social_user_model.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>{
  SocialRegisterCubit():super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context)=>BlocProvider.of(context);

  bool isPassword = true;

  IconData suffix =Icons.visibility;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
}){
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value)
    {
      userCreate(
        uId:value.user!.uid,
        phone:phone,
        name:name,
        email:email,
      );
      print(value.user!.uid);
      print(value.user!.email);
    }).catchError((error)
    {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String uId,
    required String phone,
})
  {
    SocialUserModel model=SocialUserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      image:"https://img.freepik.com/free-photo/surprised-positive-dark-skinned-lady-points-smart-phone-device-suggests-have-conversation-group-chat-glad-recieve-many-messages-congratulation-mailbox-has-overjoyed-look_273609-26221.jpg?w=740&t=st=1670862956~exp=1670863556~hmac=599f6e3b7036a0db20edd47a1a52b837929314f65d60207dff39db7d149ff2a7",
      bio:"Write Your Bio ...",
      cover:"https://img.freepik.com/free-photo/horizontal-shot-administrative-manger-sits-lotus-pose-floor-studies-contract_273609-18031.jpg?w=740&t=st=1670867380~exp=1670867980~hmac=c8572adcd3d42d86b15ed2dbfcd755f1ad904ec72672ab4b593936bc021ec588",
      isEmailVerified:false,
    );

    FirebaseFirestore.instance.collection("users").doc(uId).set(model.toMap()).then((value)
    {
      emit(SocialCreateUserSuccessState(uId));
    }).catchError((error)
    {
      print(error.toString());
       emit(SocialCreateUserErrorState(error.toString()));
    });
  }
}