import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/login/cubit/states.dart';
import 'package:shop_app/modules/shop_app/register/register_screen.dart';
import 'package:shop_app/network/local/cash_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constant.dart';

import '../../../layout/shop_app/shop_layout_screen.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
   var emailController = TextEditingController();
    var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: ((context, state) {
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status!)
            {
             
               
             CashHelper.saveData(
               key: 'token', 
               value: state.loginModel.data?.token
               ).then((value) => {
                 token = state.loginModel.data?.token,
                //  navigateAndFinish(context, ShopLayout())
               });
            }else
            {
              // print(state.loginModel.message);

              showToast(
                text:state.loginModel.message!, 
              state: ToastState.ERROR
              );
            }
          }
         }),
        builder:(context, state) { 
          return  Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                         style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black
                         ),
                      ),
                      Text(
                        'Login now to brows our hot offers',
                         style: Theme.of(context).textTheme.bodyText1?.copyWith(
                           color: Colors.grey
                         ),
                      ),
                      SizedBox(height: 30,),
                      defaultFormField(
                        controller: emailController, 
                        type: TextInputType.emailAddress, 
                        lable: 'Email Address', 
                        prefix: Icons.email_outlined
                        ),
                        SizedBox(height: 15,),
                         defaultFormField(
                        controller: passwordController, 
                         type: TextInputType.visiblePassword, 
                       
                        lable: 'Password',
                        onSubmit: (value){
                           if(formKey.currentState!.validate())
                              {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text, 
                                   password: passwordController.text);
                              }

                        },
                         isPassword:  ShopLoginCubit.get(context).isPassword,
                        suffix: ShopLoginCubit.get(context).suffix , 
                        suffixpressed: (){
                          ShopLoginCubit.get(context).changePasswordVisibility();
                              
                        },
                        prefix: Icons.lock_outline
                        ),
                         SizedBox(height: 30,),

                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context)=>defaultButton(
                            function: (){
                              if(formKey.currentState!.validate())
                              {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text, 
                                   password: passwordController.text);
                                   print(ShopCubit.get(context).categoriesModel!.data!.data[0].name);
                                   navigateTo(context,ShopLayout() );
                              }
                              
                            }, 
                            text:'login',
                            isUpperCase: true
                            ), 
                            fallback:(context)=>Center(child: CircularProgressIndicator()),
                         
                        ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account?'),
                              defaultTextButton(
                                function:(){
                                  navigateTo(context,RegisterScreen() );
                                }, 
                                text: 'Register'
                                ),

                               
                             
                            ],

                            
                          )
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        } ,
       
      ),
    );
  }
}