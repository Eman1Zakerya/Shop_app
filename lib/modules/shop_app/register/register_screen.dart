import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/register/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/register/cubit/states.dart';
import 'package:shop_app/shared/components/constant.dart';
import '../../../layout/shop_app/shop_layout_screen.dart';
import '../../../network/local/cash_helper.dart';
import '../../../shared/components/components.dart';


class RegisterScreen extends StatelessWidget {
var formKey = GlobalKey<FormState>();
 var emailController = TextEditingController();
 var passwordController = TextEditingController();
  var nameController = TextEditingController();
    var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context, state) 
        {
           if(state is ShopRegisterSuccessState)
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
              print(state.loginModel.message);

              showToast(
                text:state.loginModel.message!, 
              state: ToastState.ERROR
              );
            }
          }
         
        },
        builder:(context, state) 
        {
          return Scaffold(
          appBar: AppBar(),
          body:  Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Register',
                             style: Theme.of(context).textTheme.headline4?.copyWith(
                                  color: Colors.black
                             ),
                          ),
                          Text(
                            'Register now to brows our hot offers',
                             style: Theme.of(context).textTheme.bodyText1?.copyWith(
                               color: Colors.grey
                             ),
                          ),
                          SizedBox(height: 30,),
                           defaultFormField(
                            controller: nameController, 
                            type: TextInputType.name, 
                            lable: 'Name', 
                            prefix: Icons.person
                            ),
                            SizedBox(height: 15,),
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
                              
                            },
                             isPassword:  ShopRegisterCubit.get(context).isPassword,
                            suffix: ShopRegisterCubit.get(context).suffix , 
                            suffixpressed: (){
                              ShopRegisterCubit.get(context).changePasswordVisibility();
                                  
                            },
                            prefix: Icons.lock_outline
                            ),
                             defaultFormField(
                            controller: phoneController, 
                            type: TextInputType.phone, 
                            lable: 'Phone', 
                            prefix: Icons.phone
                            ),
                           
                             SizedBox(height: 30,),
          
                            ConditionalBuilder(
                              condition: state is ! ShopRegisterLoadingState,
                              builder: (context)=>defaultButton(
                                function: (){
                                  if(formKey.currentState!.validate())
                                  {
                                      ShopRegisterCubit.get(context).userRegister(
                                        name: nameController.text,
                                        email: emailController.text, 
                                       password: passwordController.text,
                                       phone: phoneController.text
                                       );
                                       print(ShopCubit.get(context).categoriesModel!.data!.data[0].name);
                                       navigateTo(context,ShopLayout() );
                                  }
                                  
                                }, 
                                text:'Register',
                                isUpperCase: true
                                ), 
                                fallback:(context)=>Center(child: CircularProgressIndicator()),
                             
                            ),
                            
                             
                          
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