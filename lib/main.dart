import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/shared/componants/componants.dart';
import 'package:social_app/shared/componants/constant.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'bloc_observer.dart';
import 'modules/social_login/social_login_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print("on background Message");
  print(message.data.toString());
  showToast(
    text: "on background Message",
    state: ToastStates.success,
  );
}

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();

  FirebaseMessaging.onMessage.listen((event)
  {
     print("onMessage");
     print(event.data.toString());
     showToast(text: "onMessage", state: ToastStates.success);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print("on Message on Opened");
    print(event.data.toString());
    showToast(text: "on Message on Opened", state: ToastStates.success);
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

   print ("mostafa");
  print(token);

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: "uId");

  Widget widget;

  if(uId !=null)
  {
    widget = SocialLayoutScreen();
  }else
  {
    widget = SocialLoginScreen();
  }

  runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp(this.startWidget);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>SocialCubit(),
      child: BlocConsumer<SocialCubit,SocialStates>(
        listener:(context,state){},
        builder:(context,state)
        {
          return ScreenUtilInit(
            designSize: const Size(360,690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder:(context,child)
            {
              return MaterialApp(
                debugShowCheckedModeBanner:false,
                theme:lightTheme,
                darkTheme:darkTheme,
                themeMode:ThemeMode.light,
                home: startWidget,
              );
            },
          );
        },
      ),
    );
  }
}


