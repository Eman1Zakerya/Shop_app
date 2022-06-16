import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';


class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
 
 var nameController = TextEditingController();
 var emailController = TextEditingController();
 var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state)  {},
      builder:(context, state) 
      {
        var model = ShopCubit.get(context).userModel;
         nameController.text = model!.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;
        return  ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder:(context)=> Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Column(
                  children: [
                    if(state is ShopLoadingUpdateUserState)
                    LinearProgressIndicator(),
                      const SizedBox(height: 20,),
                    defaultFormField(
                      controller: nameController, 
                      type: TextInputType.name, 
                      lable: 'Name', 
                      prefix: Icons.person
                    ),
                    const SizedBox(height: 20,),
                     defaultFormField(
                      controller: emailController, 
                      type: TextInputType.emailAddress, 
                      lable: 'Email', 
                      prefix: Icons.email
                    ),
                    const SizedBox(height: 20,),
                     defaultFormField(
                      controller: phoneController, 
                      type: TextInputType.phone, 
                      lable: 'Phone', 
                      prefix: Icons.phone
                    ),
                    const SizedBox(height: 20,),
                     defaultButton(
                       function: (){
                        if(formKey.currentState!.validate())
                        {
                             ShopCubit.get(context).updateUserData(
                               name: nameController.text, 
                               email: emailController.text, 
                               phone: phoneController.text
                        );
                        }
                      
                       }, 
                       text: 'Update'
                       ),
                     const SizedBox(height: 20,),
                     defaultButton(
                       function: (){
                        ShopCubit.get(context).currentIndex =0;
                         signOut(context);
                       }, 
                       text: 'Logout'
                       ),
                  ],
                ),
              ],
            ),
          ),
              ),
              fallback:(context)=>const Center(child: CircularProgressIndicator()) ,
        );
      } ,
     
    );
  }
}