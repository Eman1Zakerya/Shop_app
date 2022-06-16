import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../../models/shop_app/favorites_model.dart';
import '../../modules/shop_app/login/shop_login_screen.dart';
import '../../network/local/cash_helper.dart';

void navigateTo(BuildContext context, Widget widget)=> Navigator.push(context, 
MaterialPageRoute(builder: (context)=>widget),
);

void navigateAndFinish( BuildContext context, Widget widget)=>Navigator.pushAndRemoveUntil(
  context, 
 MaterialPageRoute(builder: (context)=>widget), 
  ( Route <dynamic>route) => false
  );


      Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
void Function(String)?onSubmit,
 void Function(String)? onChanged,
  VoidCallback? suffixpressed,
 
 VoidCallback? onTap,
 
  required String lable,
  required IconData prefix,
  IconData? suffix,
  bool isClicable = true,
  bool isPassword = false,
})=>TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted:onSubmit,
  onChanged: onChanged,
  obscureText: isPassword,
  enabled: isClicable,
  onTap:onTap ,
    validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }
      },
  decoration: InputDecoration(
    labelText: lable,
    suffix:IconButton(onPressed:suffixpressed ,icon:Icon(suffix) ,) ,
    prefixIcon:Icon(prefix) ,
    border: OutlineInputBorder(),
    
  ),
);


      Widget defaultButton({
        required VoidCallback? function,
        required String text,
        bool? isUpperCase

      })=>Container(
                  width: double.infinity,
                  color: defaultColor,
                  child: MaterialButton(
                    onPressed: function,
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );

                Widget defaultTextButton({
                   required VoidCallback? function,
                    required String text,
        
                })=> TextButton(onPressed: function, 
                    child: Text(text.toUpperCase()));


      void showToast({
        required String text,
        required ToastState state,
      }) => Fluttertoast.showToast(
               msg: text,
               toastLength: Toast.LENGTH_LONG,
               gravity: ToastGravity.BOTTOM,
               timeInSecForIosWeb: 5,
               backgroundColor: chooseToastColor(state),
               textColor: Colors.white,
               fontSize: 16.0
    ); 
    enum ToastState{SUCCESS,ERROR,WARNING}  

    Color chooseToastColor(ToastState state)
    {
      Color color;
      switch(state)
      {

        case ToastState.SUCCESS:
        color = Colors.green;
          break;
        case ToastState.ERROR:
         color = Colors.red;
          break;
        case ToastState.WARNING:
        color = Colors.amber;
          break;
      }
      return color;
    }          


    void signOut(BuildContext  context)
    {
       CashHelper.removData(key: 'token').then((value) {
        print(value);
             if(value!){
               navigateAndFinish(context, ShopLoginScreen());
             }
           });
    }

    void printFullText(String text)
    {
       final pattern = RegExp('.{1,800}');
       pattern.allMatches(text).forEach((match)=>print(match.group(0)));
    }

    Widget myDivider()=>Padding(
          padding: const EdgeInsetsDirectional.only(start: 20),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
              );

Widget buildListProduct( model , context , {bool isOldPrice = true})=>Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                         Image(image:NetworkImage(model.image!),
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        
                   
                        ),
                        if(model.discount!= 0 && isOldPrice)
                        Container(
                          color: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child:  Text('${model.discount}',
                          style: const TextStyle(
                              fontSize: 9,
                              color: Colors.white
                          ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 20,),
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                          Text(model.name!,style: const TextStyle(
                        height: 1.3,
                        fontWeight: FontWeight.bold,
                        
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(model.price!.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.3,
                            fontWeight: FontWeight.bold,
                            color: defaultColor
                          ),
                     
                          ),
                          const SizedBox(width: 5,),
                          if(model.discount!= 0 && isOldPrice)
                         Text(model.oldPrice.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            height: 1.3,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                          ),
                     
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: (){
                              ShopCubit.get(context).changeFavorites(model.id!);
                            
                            }, 
                          icon:   CircleAvatar(
                            radius: 15,
                            backgroundColor: 
                            ShopCubit.get(context).favorites[model.id!]! ? defaultColor : 
                            Colors.grey,
                            child: const Icon(Icons.favorite_border,
                            size: 14,
                             color: Colors.white,
                            ),
                          )
                          )
                   
                        ],
                      ),
                       ],
                     ),
                   )
                  ],
                ),
      ),
    );