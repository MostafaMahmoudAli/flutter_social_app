import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context,widget)=> Navigator.push(
  context,
  MaterialPageRoute(
      builder:(context)=>widget),
);

void navigateAndFinish(context,widget)=>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder:(context)=>widget),
            (route) => false);

Widget defultButton({
  double width =double.infinity,
  double height =30.0,
  Color color = Colors.blue,
  bool isUpperCase =true,
  required Function() function,
  required String text,
})=>Container(
  color: color,
  width: width,
  height:height,
  child: MaterialButton(
    onPressed: function,
    child:Text(
      isUpperCase?text.toUpperCase():text,
      style:TextStyle(
          color:Colors.white
      ),
    ),
  ),
);

Widget defultFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required FormFieldValidator<String>validator,
  required  IconData? prefix,
  required String text,
  Function(String value)?function,
  Function()?onTap,
  ValueChanged <String> ?onChanged,
  bool isPassword = false,
  IconData ?suffix,
  Function()?onPressed,
}) => TextFormField(
  onTap:onTap,
  controller: controller,
  keyboardType: keyboardType,
  onFieldSubmitted: function ,
  onChanged:onChanged,
  validator:validator,
  obscureText:  isPassword,
  decoration: InputDecoration(
    labelText:text,
    border: OutlineInputBorder(),
    prefixIcon:Icon(
      prefix,
    ),
    suffixIcon:IconButton(
      onPressed:onPressed,
      icon: Icon(
        suffix,
      ),
    ) ,

  ),
) ;

Widget defultTextButton({
  required VoidCallback function,
  required String text,
  bool isUpperCase =true,
})=>TextButton(
  onPressed: function,
  child:Text(
    isUpperCase ? text.toUpperCase():text,
    style: TextStyle(
      fontSize:18.0,
      fontWeight:FontWeight.bold,
    ),
  ),
);

void showToast({
  required String text,
  required ToastStates state,

})=> Fluttertoast.showToast(
    msg:text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 18.0
);

enum ToastStates{success,error,warning}

Color chooseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.success:
      color=Colors.green;
      break;

    case ToastStates.error:
      color=Colors.red;
      break;

    case ToastStates.warning:
      color=Colors.amber;
      break;

  }
  return color ;
}

Widget myDivider()=>Padding(
  padding: const EdgeInsets.symmetric(horizontal:10.0),
  child:   Container(

    width:double.infinity,

    height:1.0,

    color:Colors.grey[800],

  ),
);

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String?title,
  List<Widget>?actions,
})=>AppBar(
  leading:IconButton(
    onPressed:()
    {
      Navigator.pop(context);
    },
    icon:Icon(
      Icons.arrow_back_ios_new_outlined,
    ),
  ),
  title:Text(
      title!
  ),
  actions:actions,
);