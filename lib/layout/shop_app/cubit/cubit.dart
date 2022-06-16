
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/categories/categories_screen.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/layout/shop_app/favorit/favorits_screen.dart';
import 'package:shop_app/layout/shop_app/products/product_screen.dart';
import 'package:shop_app/layout/shop_app/search/search_screen.dart';
import 'package:shop_app/layout/shop_app/settings/settings_screen.dart';
import 'package:shop_app/models/shop_app/add_favorites_model.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/models/shop_app/favorites_model.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/components/components.dart';

import 'package:shop_app/shared/components/constant.dart';

import '../../../network/end_point.dart';
import '../../../network/local/cash_helper.dart';

class ShopCubit extends Cubit<ShopStates>{

  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context)=> BlocProvider.of(context);

   late  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategiriesScreen(),
    FavoritsScreen(),
    SettingsScreen(),
    SearchScreen(),
  ];

  void changeBottom(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

     HomeModel? homeModel;

     Map<int,bool> favorites = {};

   void getHomeData()
   {
     
     emit(ShopLoadingHomeDataState());

     DioHelper.getData(url: HOME,token: token).then((value) {
     

       homeModel = HomeModel.fromJson(value!.data);


       homeModel!.data.products.forEach((element) 
       { 
          favorites.addAll({
           element.id! : element.in_favorites!,

          });
       }
       );
     

       emit(ShopSuccessHomeDataState());

     }).catchError((error){

      //  print(error.toString());

       emit(ShopErrorHomeDataState());
     });
   }

    CategoriesModel? categoriesModel;

   void getCategoties()
   {
     
    

     DioHelper.getData(url: GET_CATEGORIES,token: token).then((value) {
     

       categoriesModel = CategoriesModel.fromJson(value!.data);


       

       emit(ShopSuccessCategoriesDataState());

     }).catchError((error){

       print(error.toString());

       emit(ShopErrorCategoriesDataState());
     });
   }

   ChangeFavoritesModel? changeFavoritesModel;

   void changeFavorites(int productId)
   {
     favorites[productId] = ! favorites[productId]!;
      emit(ShopChangeFavoritesState(changeFavoritesModel));
     DioHelper.postData(
       url: FAVORITES, 
       data: {
         'product_id': productId,
       },
       token: token
       ).then((value) {
         changeFavoritesModel = ChangeFavoritesModel.fromJson(value!.data);
   
          if(!changeFavoritesModel!.status!)
          {
            favorites[productId] = ! favorites[productId]!;

          }else{getFavorites();}

         emit(ShopSuccessChangeFavoritesState());

       }).catchError((error){
          favorites[productId] = ! favorites[productId]!;
         emit(ShopErrorChangeFavoritesState());
       });
   }

   



   FavoritesModel? favoritesModel;

   void getFavorites()
   {
     
      // print(token);

    emit(ShopLoadingGetFavoritesState());

     DioHelper.getData(url: FAVORITES,token: token).then((value) {
     

       favoritesModel = FavoritesModel.fromJson(value!.data);
    
       emit(ShopSuccessGetFavoritesState());

     }).catchError((error){

      //  print(error.toString());

       emit(ShopErrorGetFavoritesState());
     });
   }

    ShopLoginModel? userModel;

   void getUserData()
   {
     
      // print(token);

    emit(ShopLoadingUsrDataState());

     DioHelper.getData(url: PROFILE,token: token).then((value) {
     

       userModel = ShopLoginModel.fromJson(value!.data);
       print(userModel!.data!.name);
    
       emit(ShopSuccessUsrDataState(userModel!));

     }).catchError((error){

      //  print(error.toString());

       emit(ShopErrorUsrDataState());
     });
   }

   void updateUserData({
    required String name,
    required String email,
    required String phone,
   })
   {
     

    emit(ShopLoadingUpdateUserState());

     DioHelper.putData(url: UPDATE_PROFILE,token: token, data: {
      'name':name,
      'email':email,
      'phone':phone,
     }).then((value) {
     

       userModel = ShopLoginModel.fromJson(value!.data);
     
    
       emit(ShopSuccessUpdateUserState(userModel!));

     }).catchError((error){

      //  print(error.toString());

       emit(ShopErrorUpdateUserState());
     });
   }




     bool isDark = true;

 void changeAppMode({bool? fromShared})
 {
   if(fromShared != null)
   {
     isDark = fromShared;
     emit(AppChangeModeState());
   }
   
   else
   {
    isDark = !isDark;

  CashHelper.putBoolean(key: 'isDark',value: isDark).then((value)
  {
   
   emit(AppChangeModeState());
  });
  // print('eman${isDark}');
   }
  
 
  
 }
}