
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tasawq/shared/styles/icons_broken.dart';

Widget defaultButton({
  double width: double.infinity,
  Color background: Colors.blue,
  bool isUpperCase = true,
  @required double height,
  @required String text,
  @required Function function,
  @required double radius,
}) =>
    Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),

      //width: double.infinity,

      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );


Widget defaultTextButton ({
  @required Function function,
  @required String text,

})=> TextButton(onPressed: function, child: Text(text.toUpperCase()));

Widget defaultTextFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  @required IconData prefix,
  @required String lapelText,
  Function onSubmitted,
  Function onChanged,
  Function onTap,
  @required Function validate,
  bool isPassword = false,
  IconData suffix,
  Function suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      obscureText: isPassword,
      validator: validate,
      keyboardType: type,
      onTap: onTap,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffix),
              )
            : null,
        labelText: lapelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );



Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 30),
      child: Container(
        width: double.infinity,
        color: Colors.grey[300],
        height: 1,
      ),
    );


void navigateTo(context , widget) =>  Navigator.push(context, MaterialPageRoute(
builder: (context)=>widget,
),
);

void navigateAndFinish(context , widget) =>  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
builder: (context)=>widget,
),
    (Route<dynamic> route)=>false,
);

void showToast ({
  @required String text,
})=> Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: Colors.grey,
    textColor: Colors.white,
    fontSize: 16.0
);

Widget defaultAppBar({
  @required BuildContext context ,
  Widget title,
  List<Widget> actions ,
  double titleSpacing,
})=>AppBar(
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: Icon(IconBroken.Arrow___Left_2),
  ),
  title: title,
  titleSpacing: titleSpacing,
  actions: actions,
);